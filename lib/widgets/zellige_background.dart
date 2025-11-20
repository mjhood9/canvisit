import 'package:flutter/material.dart';

class ZelligeBackground extends StatelessWidget {
  final Widget child;
  const ZelligeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ZelligePainter(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    );
  }
}

class _ZelligePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    const tileSize = 40.0;

    for (double y = -tileSize; y < size.height + tileSize; y += tileSize) {
      for (double x = -tileSize; x < size.width + tileSize; x += tileSize) {
        final rect = Rect.fromCenter(
          center: Offset(
            x + ((y / tileSize).floorToDouble() % 2) * tileSize / 2,
            y,
          ),
          width: tileSize - 6,
          height: tileSize - 6,
        );

        final r = RRect.fromRectAndRadius(rect, const Radius.circular(6));
        final color = (x + y).toInt() % 3 == 0
            ? const Color(0xFFB71C1C).withOpacity(0.07)
            : const Color(0xFF2E7D32).withOpacity(0.06);

        canvas.drawRRect(r, paint..color = color);
      }
    }

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = Colors.black12;

    for (double y = 0; y < size.height; y += tileSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    for (double x = 0; x < size.width; x += tileSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
