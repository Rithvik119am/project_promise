import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

Future<pw.ImageProvider> imageDocument() async {
// Load the image file
  final Uint8List imageData =
      (await rootBundle.load('god_d.jpg')).buffer.asUint8List();

  final image = pw.MemoryImage(imageData);

  return image;
}
