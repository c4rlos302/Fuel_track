import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/ocr_image_viewer.dart';
import '../../../core/services/ocr_service.dart';

class ScanTestPage extends StatefulWidget {
  const ScanTestPage({super.key});

  @override
  State<ScanTestPage> createState() => _ScanTestPageState();
}

class _ScanTestPageState extends State<ScanTestPage> {
  final ImagePicker _picker = ImagePicker();
  final OcrService _ocrService = OcrService();

  String? imagePath;
  OcrResult? ocrResult;

  String detectedText = '';
  bool processing = false;

  Future<void> pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      imagePath = image.path;
      processing = true;
      detectedText = '';
    });

    try {
      final result = await _ocrService.recognize(image.path);
      if (!mounted) return;

      final output = StringBuffer();

      output.writeln('TEXTO COMPLETO');
      output.writeln('----------------');
      output.writeln(result.text);
      output.writeln();

      output.writeln('LÍNEAS DETECTADAS');
      output.writeln('----------------');

      for (final line in result.lines) {
        output.writeln(
          '${line.text} '
          '[x:${line.left.toStringAsFixed(0)}, '
          'y:${line.top.toStringAsFixed(0)}, '
          'w:${(line.right - line.left).toStringAsFixed(0)}, '
          'h:${(line.bottom - line.top).toStringAsFixed(0)}]',
        );
      }

      output.writeln();
      output.writeln('PALABRAS DETECTADAS');
      output.writeln('------------------');

      for (final line in result.lines) {
        for (final word in line.words) {
          output.writeln(
            '${word.text} '
            '[x:${word.left.toStringAsFixed(0)}, '
            'y:${word.top.toStringAsFixed(0)}, '
            'w:${(word.right - word.left).toStringAsFixed(0)}, '
            'h:${(word.bottom - word.top).toStringAsFixed(0)}]',
          );
        }
      }

      final candidates = _ocrService.findNumericLines(result);

      debugPrint("CANDIDATOS NUMÉRICOS");
      debugPrint("-------------------");

      for (final candidate in candidates) {
        debugPrint(
          '${candidate.text} '
          '[x:${candidate.left.toInt()}, '
          'y:${candidate.top.toInt()}, '
          'w:${(candidate.right - candidate.left).toInt()}, '
          'h:${(candidate.bottom - candidate.top).toInt()}]',
        );
      }

      setState(() {
        ocrResult = result;
        detectedText = output.toString();
        processing = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        processing = false;
        detectedText = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba OCR')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: processing ? null : pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Seleccionar imagen'),
              ),
            ),

            const SizedBox(height: 24),
            if (imagePath != null && ocrResult != null)
              Expanded(
                child: SingleChildScrollView(
                  child: OcrImageViewer(
                    imagePath: imagePath!,
                    result: ocrResult!,
                  ),
                ),
              ),

            if (processing) const CircularProgressIndicator(),

            if (!processing && detectedText.isNotEmpty)
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        detectedText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
