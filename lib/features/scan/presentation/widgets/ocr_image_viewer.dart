import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/services/ocr_service.dart';

class OcrImageViewer extends StatelessWidget {
  final String imagePath;
  final OcrResult result;

  const OcrImageViewer({
    super.key,
    required this.imagePath,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = result.imageWidth.toDouble();
        final imageHeight = result.imageHeight.toDouble();

        if (imageWidth == 0 || imageHeight == 0) {
          return Image.file(File(imagePath));
        }

        final scale = constraints.maxWidth / imageWidth;

        final displayWidth = imageWidth * scale;
        final displayHeight = imageHeight * scale;

        return SizedBox(
          width: displayWidth,
          height: displayHeight,
          child: Stack(
            children: [
              Image.file(
                File(imagePath),
                width: displayWidth,
                height: displayHeight,
                fit: BoxFit.fill,
              ),

              for (final line in result.lines)
                Positioned(
                  left: line.left * scale,
                  top: line.top * scale,
                  width: (line.right - line.left) * scale,
                  height: (line.bottom - line.top) * scale,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Text(
                          line.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
