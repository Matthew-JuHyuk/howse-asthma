// Builds launcher and in-app brand images from the concept artwork.
//
//   dart run tool/make_brand_assets.dart <concept.png>
//
// Writes into assets/branding/:
//   covernote_icon_1024.png       opaque full icon (iOS / legacy Android)
//   covernote_foreground.png      adaptive foreground, glyph on transparent,
//                                 sized for the 66% safe zone
//   covernote_monochrome.png      adaptive monochrome (white glyph, alpha)
//   covernote_mark.png            256px rounded mark for in-app headers
import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: dart run tool/make_brand_assets.dart <concept.png>');
    exit(2);
  }
  final src = img.decodeImage(File(args.first).readAsBytesSync());
  if (src == null) {
    stderr.writeln('cannot decode concept image');
    exit(2);
  }
  final square = img.copyResizeCropSquare(
    src,
    size: 1024,
    interpolation: img.Interpolation.cubic,
  );

  // Background = median of the four 32px corners.
  final samples = <img.Pixel>[];
  for (final (x0, y0) in [(0, 0), (992, 0), (0, 992), (992, 992)]) {
    for (var y = y0; y < y0 + 32; y += 4) {
      for (var x = x0; x < x0 + 32; x += 4) {
        samples.add(square.getPixel(x, y));
      }
    }
  }
  int med(num Function(img.Pixel) f) {
    final v = samples.map((p) => f(p).toInt()).toList()..sort();
    return v[v.length ~/ 2];
  }

  final bg = (med((p) => p.r), med((p) => p.g), med((p) => p.b));
  stdout.writeln(
    'background #${[bg.$1, bg.$2, bg.$3].map((c) => c.toRadixString(16).padLeft(2, '0')).join()}',
  );

  final out = Directory('assets/branding')..createSync(recursive: true);

  final opaque = img.Image(width: 1024, height: 1024, numChannels: 3);
  img.compositeImage(opaque, square);
  File(
    '${out.path}/covernote_icon_1024.png',
  ).writeAsBytesSync(img.encodePng(opaque));

  // Glyph alpha from distance to the background colour.
  final glyph = img.Image(width: 1024, height: 1024, numChannels: 4);
  var minX = 1024, minY = 1024, maxX = 0, maxY = 0;
  for (var y = 0; y < 1024; y++) {
    for (var x = 0; x < 1024; x++) {
      final p = square.getPixel(x, y);
      final d = math.sqrt(
        math.pow(p.r - bg.$1, 2) +
            math.pow(p.g - bg.$2, 2) +
            math.pow(p.b - bg.$3, 2),
      );
      final a = ((d - 18) / 40 * 255).clamp(0, 255).toInt();
      if (a > 0) {
        glyph.setPixelRgba(x, y, p.r, p.g, p.b, a);
        if (a > 128) {
          minX = math.min(minX, x);
          minY = math.min(minY, y);
          maxX = math.max(maxX, x);
          maxY = math.max(maxY, y);
        }
      } else {
        glyph.setPixelRgba(x, y, 0, 0, 0, 0);
      }
    }
  }
  final cropped = img.copyCrop(
    glyph,
    x: minX,
    y: minY,
    width: maxX - minX + 1,
    height: maxY - minY + 1,
  );
  stdout.writeln('glyph bbox ${cropped.width}x${cropped.height}');

  img.Image placed(double fraction, {bool white = false}) {
    final canvas = img.Image(width: 1024, height: 1024, numChannels: 4);
    final scale = 1024 * fraction / math.max(cropped.width, cropped.height);
    final g = img.copyResize(
      cropped,
      width: (cropped.width * scale).round(),
      height: (cropped.height * scale).round(),
      interpolation: img.Interpolation.cubic,
    );
    if (white) {
      for (final p in g) {
        p
          ..r = 255
          ..g = 255
          ..b = 255;
      }
    }
    img.compositeImage(
      canvas,
      g,
      dstX: (1024 - g.width) ~/ 2,
      dstY: (1024 - g.height) ~/ 2,
      blend: img.BlendMode.direct,
    );
    return canvas;
  }

  // Adaptive icons: 108dp canvas, 66dp safe circle. flutter_launcher_icons
  // wraps the layer in a 16% inset, so 0.76 here ends up at ~52% of the canvas.
  File(
    '${out.path}/covernote_foreground.png',
  ).writeAsBytesSync(img.encodePng(placed(0.76)));
  File(
    '${out.path}/covernote_monochrome.png',
  ).writeAsBytesSync(img.encodePng(placed(0.76, white: true)));

  final mark = img.copyResize(
    opaque,
    width: 256,
    height: 256,
    interpolation: img.Interpolation.cubic,
  );
  final rounded = img.Image(width: 256, height: 256, numChannels: 4);
  const r = 56;
  for (var y = 0; y < 256; y++) {
    for (var x = 0; x < 256; x++) {
      final cx = x < r ? r : (x > 255 - r ? 255 - r : x);
      final cy = y < r ? r : (y > 255 - r ? 255 - r : y);
      final inside = math.pow(x - cx, 2) + math.pow(y - cy, 2) <= r * r;
      final p = mark.getPixel(x, y);
      rounded.setPixelRgba(x, y, p.r, p.g, p.b, inside ? 255 : 0);
    }
  }
  File(
    '${out.path}/covernote_mark.png',
  ).writeAsBytesSync(img.encodePng(rounded));
  stdout.writeln('wrote ${out.path}');
}
