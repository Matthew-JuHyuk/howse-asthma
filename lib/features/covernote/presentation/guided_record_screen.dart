import 'package:flutter/material.dart';
import '../../../core/session/session_controller.dart';
import '../data/preparation_repository.dart';
import '../data/consent_repository.dart';
import '../domain/preparation.dart';
import '../domain/s9_models.dart';
import '../ui/app_chrome.dart';
import '../ui/brand.dart';
import 'preparation_strings.dart';
import 'record_review.dart';

/// One recording entry point. Opening this screen never starts the microphone.
class GuidedRecordScreen extends StatefulWidget {
  const GuidedRecordScreen({
    super.key,
    required this.repository,
    this.profiles,
    this.initialPatient,
    this.caseId,
    this.initiallyTyped = false,
  });
  final PreparationRepository repository;
  final Map<String, String>? profiles;
  final String? initialPatient, caseId;
  final bool initiallyTyped;
  @override
  State<GuidedRecordScreen> createState() => _GuidedRecordScreenState();
}

class _GuidedRecordScreenState extends State<GuidedRecordScreen> {
  final _text = TextEditingController();
  final _focus = FocusNode();
  Map<String, String>? _profiles;
  String? _patient, _error, _owner;
  String _topic = 'feelPrompt';
  bool _busy = false, _listening = false, _typed = false, _usedVoice = false;
  PreparationRepository get repo => widget.repository;
  @override
  void initState() {
    super.initState();
    _owner = repo.uid;
    _typed = widget.initiallyTyped;
    _profiles = widget.profiles;
    _patient = widget.initialPatient ?? widget.profiles?.keys.firstOrNull;
    if (_profiles == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    }
  }

  Future<void> _load() async {
    try {
      final ownName =
          SessionScope.of(context).profile?.fullName ?? s10(context, 'patient');
      final profiles = await repo.careProfiles();
      if (!mounted || repo.uid != _owner) return;
      profiles.putIfAbsent(repo.uid, () => ownName);
      setState(() {
        _profiles = profiles;
        _patient = repo.uid;
        _error = null;
      });
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    }
  }

  Future<void> _listen() async {
    if (_listening || _busy) return;
    _focus.unfocus();
    setState(() {
      _listening = true;
      _error = null;
    });
    try {
      final words = await PreparationRepository.native.invokeMethod<String>(
        'listen',
        {'language': Localizations.localeOf(context).toLanguageTag()},
      );
      if (!mounted || repo.uid != _owner) return;
      if (words != null && words.trim().isNotEmpty) {
        _text.text = [
          _text.text.trim(),
          words.trim(),
        ].where((v) => v.isNotEmpty).join('\n');
        _usedVoice = true;
        _typed = true;
      } else {
        _error = s10(context, 'voiceFallback');
      }
    } catch (_) {
      if (mounted) _error = s10(context, 'voiceFallback');
    } finally {
      if (mounted) setState(() => _listening = false);
    }
  }

  Future<void> _stop() async {
    try {
      await PreparationRepository.native.invokeMethod('stop');
    } catch (_) {
      if (mounted) {
        setState(() {
          _listening = false;
          _error = s10(context, 'voiceFallback');
        });
      }
    }
  }

  Future<bool> _consent() async {
    if (repo.demo) return true;
    final consent = ConsentRepository();
    if (await consent.hasActive(ConsentPurpose.treatment)) return true;
    if (!mounted) return false;
    final agreed = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(s10(c, 'confirm')),
        content: Text(s10(c, 'consent')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: Text(s10(c, 'cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text(s10(c, 'allow')),
          ),
        ],
      ),
    );
    if (agreed != true || repo.uid != _owner) return false;
    await consent.accept(ConsentPurpose.treatment);
    return true;
  }

  Future<void> _save() async {
    final text = _text.text.trim();
    final patient = _patient;
    if (_busy || _listening || text.isEmpty || patient == null) return;
    _focus.unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (!await _consent() || !mounted || repo.uid != _owner) return;
      final result = await repo.analyze(
        action: 'structure_record',
        input: {
          if (widget.caseId != null) 'case_id': widget.caseId,
          'patient_key': patient,
          'patient_name': _profiles![patient],
          'transcript': text,
          'today': dayKey(repo.today),
          'timezone': repo.today.timeZoneOffset.inMinutes,
          'language': Localizations.localeOf(context).toLanguageTag(),
        },
      );
      if (!mounted || repo.uid != _owner) return;
      final proposals = validateVoiceProposal(result['events'], text);
      if (proposals.isEmpty) {
        setState(() => _error = s10(context, 'nothingToRecord'));
        return;
      }
      final selected = await RecordReviewController(
        context,
        repo,
        _profiles![patient]!,
      ).confirm(proposals, text);
      if (!mounted ||
          selected == null ||
          selected.isEmpty ||
          repo.uid != _owner) {
        return;
      }
      final source = preparationId();
      final synced = await repo.record([
        for (final v in selected)
          TreatmentEvent(
            id: preparationId(),
            patientKey: patient,
            kind: v['kind'],
            day: v['day'],
            sourceId: source,
            text: text,
            values: {
              ...v,
              'input_path': _usedVoice ? 'voice' : 'text',
              'language': Localizations.localeOf(context).toLanguageTag(),
              'model': result['model'],
              'prompt_version': result['prompt_version'],
            },
          ),
      ]);
      if (!mounted || repo.uid != _owner) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s10(context, synced ? 'saved' : 'pending'))),
      );
      Navigator.pop(context, true);
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'recordRetry'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    if (_listening) {
      PreparationRepository.native
          .invokeMethod('stop')
          .catchError((Object _) => null);
    }
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profiles = _profiles;
    return PopScope(
      canPop: !_busy,
      child: Scaffold(
        appBar: CoverNoteAppBar(title: Text(s10(context, 'recordEntry'))),
        bottomNavigationBar: profiles == null
            ? null
            : Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom,
                ),
                child: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                  child: FilledButton.icon(
                    onPressed: _busy || _listening || _text.text.trim().isEmpty
                        ? null
                        : _save,
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text(
                      s10(context, _busy ? 'processing' : 'reviewRecord'),
                    ),
                  ),
                ),
              ),
        body: SafeArea(
          child: profiles == null
              ? Center(
                  child: _error == null
                      ? const CircularProgressIndicator()
                      : TextButton(onPressed: _load, child: Text(_error!)),
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    if (profiles.length > 1)
                      DropdownButtonFormField<String>(
                        initialValue: _patient,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: s10(context, 'careRecords'),
                        ),
                        items: [
                          for (final p in profiles.entries)
                            DropdownMenuItem(
                              value: p.key,
                              child: Text(
                                p.value,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: _busy || _listening || _text.text.isNotEmpty
                            ? null
                            : (v) => setState(() => _patient = v),
                      )
                    else
                      Text(
                        profiles.values.first,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    const SizedBox(height: 24),
                    Text(
                      s10(context, 'recordWelcome'),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(s10(context, 'recordWelcomeBody')),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final topic in [
                          ('feelPrompt', Icons.favorite_outline),
                          ('medicinePrompt', Icons.medication_outlined),
                          ('dayPrompt', Icons.nights_stay_outlined),
                        ])
                          ChoiceChip(
                            avatar: Icon(topic.$2, size: 18),
                            label: Text(s10(context, topic.$1)),
                            selected: _topic == topic.$1,
                            onSelected: _busy
                                ? null
                                : (_) => setState(() => _topic = topic.$1),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CnCard(
                      color: CnColors.mint,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s10(context, '${_topic}Question'),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          Text(s10(context, '${_topic}Example')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: _busy
                          ? null
                          : _listening
                          ? _stop
                          : _listen,
                      icon: Icon(
                        _listening
                            ? Icons.stop_circle_outlined
                            : Icons.mic_rounded,
                        size: 28,
                      ),
                      label: Text(
                        s10(context, _listening ? 'stop' : 'startSpeaking'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (!_typed)
                      TextButton.icon(
                        onPressed: _busy || _listening
                            ? null
                            : () {
                                setState(() => _typed = true);
                                _focus.requestFocus();
                              },
                        icon: const Icon(Icons.keyboard_alt_outlined),
                        label: Text(s10(context, 'preferTyping')),
                      ),
                    if (_typed)
                      TextField(
                        controller: _text,
                        focusNode: _focus,
                        enabled: !_busy && !_listening,
                        minLines: 3,
                        maxLines: 7,
                        maxLength: 1000,
                        decoration: InputDecoration(
                          labelText: s10(context, 'yourWords'),
                          hintText: s10(context, 'recordHint'),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    if (_listening) ...[
                      const SizedBox(height: 12),
                      const LinearProgressIndicator(),
                      Text(s10(context, 'listening')),
                    ],
                    if (_busy) const LinearProgressIndicator(),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
