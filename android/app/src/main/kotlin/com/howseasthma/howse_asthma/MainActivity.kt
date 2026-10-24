package com.howseasthma.howse_asthma

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer

class MainActivity : FlutterActivity() {
    private var speech: SpeechRecognizer? = null
    private var speechReply: MethodChannel.Result? = null
    private var speechLanguage = "en-US"
    override fun configureFlutterEngine(engine: FlutterEngine) {
        super.configureFlutterEngine(engine)
        MethodChannel(engine.dartExecutor.binaryMessenger, "covernote/capture").setMethodCallHandler { call, result ->
            when(call.method) {
                "listen" -> {
                    if(speechReply != null) { result.error("busy", "Already recording", null); return@setMethodCallHandler }
                    speechReply = result
                    speechLanguage = call.argument<String>("language") ?: "en-US"
                    if(checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                        requestPermissions(arrayOf(Manifest.permission.RECORD_AUDIO), 301)
                    } else startSpeech()
                }
                "stop" -> { try { speech?.stopListening(); result.success(null) } catch(_:Exception) { finishSpeech(error="recognition_failed"); result.success(null) } }
                "configure" -> {
                    val enabled=call.argument<Boolean>("enabled") ?: false
                    val prefs=getSharedPreferences("cn_direct", MODE_PRIVATE)
                    if(!enabled) {
                        prefs.edit().remove("config").apply()
                        DirectRecordReceiver.cancel(this)
                    } else {
                        val config=org.json.JSONObject(call.arguments as Map<*, *>)
                        config.put("token", java.util.UUID.randomUUID().toString())
                        prefs.edit().putString("config",config.toString()).commit()
                        if(Build.VERSION.SDK_INT>=33 && checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS)!=PackageManager.PERMISSION_GRANTED) {
                            requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS),302)
                            result.error("notification_permission", "Grant permission, then enable the action again", null)
                            return@setMethodCallHandler
                        }
                        DirectRecordReceiver.show(this,config)
                    }
                    result.success(null)
                }
                "disable" -> {
                    getSharedPreferences("cn_direct",MODE_PRIVATE).edit().remove("config").commit()
                    DirectRecordReceiver.cancel(this); result.success(null)
                }
                "pending" -> {
                    val owner=call.argument<String>("owner") ?: ""
                    val queue=DirectRecordReceiver.queue(this)
                    val out=mutableListOf<Map<String,Any?>>()
                    for(i in 0 until queue.length()) {
                        val e=queue.getJSONObject(i)
                        if(e.optString("owner",e.optString("patient_key"))==owner)out.add(DirectRecordReceiver.asMap(e))
                    }
                    result.success(out)
                }
                "ack" -> {
                    val owner=call.argument<String>("owner") ?: ""
                    val id=call.argument<String>("id") ?: ""
                    DirectRecordReceiver.remove(this,owner,id); result.success(null)
                }
                "clear" -> {
                    val owner=call.argument<String>("owner") ?: ""
                    val queue=DirectRecordReceiver.queue(this)
                    for(i in 0 until queue.length()){
                        val e=queue.getJSONObject(i)
                        if(e.optString("owner",e.optString("patient_key"))==owner)DirectRecordReceiver.remove(this,owner,e.optString("id"))
                    }
                    getSharedPreferences("cn_direct",MODE_PRIVATE).edit().remove("config").commit()
                    DirectRecordReceiver.cancel(this);result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
    private fun finishSpeech(text:String?=null,error:String?=null) {
        val reply=speechReply; speechReply=null
        try { speech?.destroy() } catch(_:Exception) {}
        speech=null
        if(error!=null)reply?.error(error,"Recognition unavailable; use text or buttons",null) else reply?.success(text ?: "")
    }
    private fun startSpeech() {
      try {
        if(!SpeechRecognizer.isRecognitionAvailable(this)){finishSpeech(error="unsupported");return}
        speech=if(Build.VERSION.SDK_INT>=31 && SpeechRecognizer.isOnDeviceRecognitionAvailable(this)) SpeechRecognizer.createOnDeviceSpeechRecognizer(this) else SpeechRecognizer.createSpeechRecognizer(this)
        speech!!.setRecognitionListener(object:RecognitionListener {
            override fun onReadyForSpeech(params:Bundle?) {}
            override fun onBeginningOfSpeech() {}
            override fun onRmsChanged(rmsdB:Float) {}
            override fun onBufferReceived(buffer:ByteArray?) {}
            override fun onEndOfSpeech() {}
            override fun onPartialResults(partialResults:Bundle?) {}
            override fun onEvent(eventType:Int,params:Bundle?) {}
            override fun onError(error:Int) { finishSpeech(error="recognition_$error") }
            override fun onResults(results:Bundle?) { finishSpeech(results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)?.firstOrNull()) }
        })
        try { speech!!.startListening(Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE,speechLanguage)
            putExtra(RecognizerIntent.EXTRA_MAX_RESULTS,1)
        }) } catch(_:Exception) {finishSpeech(error="recognition_failed")}
      } catch(_:Exception) { finishSpeech(error="recognition_failed") }
    }
    override fun onRequestPermissionsResult(requestCode:Int,permissions:Array<out String>,grantResults:IntArray) {
        super.onRequestPermissionsResult(requestCode,permissions,grantResults)
        if(requestCode==301) {
            if(grantResults.firstOrNull()==PackageManager.PERMISSION_GRANTED)startSpeech() else finishSpeech(error="permission_denied")
        }
    }
    override fun onDestroy() {finishSpeech(error="cancelled");super.onDestroy()}
}
