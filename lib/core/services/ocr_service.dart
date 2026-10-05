import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;

class OcrResult {
  final String text;
  final List<OcrLine> lines;

  final int imageWidth;
  final int imageHeight;

  OcrResult({
    required this.text,
    required this.lines,
    required this.imageWidth,
    required this.imageHeight,
  });
}

class OcrWord {
  final String text;
  final double left;
  final double top;
  final double right;
  final double bottom;

  OcrWord({
    required this.text,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });
}

class OcrLine {
  final String text;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final List<OcrWord> words;

  OcrLine({
    required this.text,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.words,
  });
}

class OcrService {
  final TextRecognizer _recognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  List<OcrLine> findNumericLines(OcrResult result) {
    return result.lines.where((line) {
      final normalized = line.text.replaceAll(RegExp(r'[^0-9]'), '');

      return normalized.length >= 4;
    }).toList();
  }

  Future<OcrResult> recognize(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);

    final recognizedText = await _recognizer.processImage(inputImage);

    final lines = <OcrLine>[];

    for (final block in recognizedText.blocks) {
      for (final line in block.lines) {
        final box = line.boundingBox;

        final words = <OcrWord>[];

        for (final element in line.elements) {
          final elementBox = element.boundingBox;

          words.add(
            OcrWord(
              text: element.text,
              left: elementBox.left,
              top: elementBox.top,
              right: elementBox.right,
              bottom: elementBox.bottom,
            ),
          );
        }

        lines.add(
          OcrLine(
            text: line.text,
            left: box.left,
            top: box.top,
            right: box.right,
            bottom: box.bottom,
            words: words,
          ),
        );
      }
    }

    final bytes = await File(imagePath).readAsBytes();
    final decodedImage = img.decodeImage(bytes);

    if (decodedImage == null) {
      throw Exception('No se pudo obtener el tamaño de la imagen');
    }

    return OcrResult(
      text: recognizedText.text,
      lines: lines,
      imageWidth: decodedImage.width,
      imageHeight: decodedImage.height,
    );
  }

  void dispose() {
    _recognizer.close();
  }
}
