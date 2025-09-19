import 'package:flutter/material.dart';

class KtpOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);

    final double cardWidth = size.width * 0.9;
    final double cardHeight = cardWidth * (5.4 / 8.6); // Proporsi KTP
    final double left = (size.width - cardWidth) / 2;
    final double top = (size.height - cardHeight) / 2.5; // Sedikit ke atas

    final backgroundPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cardPath =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(left, top, cardWidth, cardHeight),
            const Radius.circular(12.0),
          ),
        );

    final overlayPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cardPath,
    );

    canvas.drawPath(overlayPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
