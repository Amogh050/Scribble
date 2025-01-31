import 'package:flutter/material.dart';
import 'package:scriclone/models/touch_points.dart';
import 'dart:ui' as ui;

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.pointsList});

  List<TouchPoints?> pointsList; // Allow nullable points

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] == null || pointsList[i + 1] == null) {
        continue; // Skip null values to separate strokes
      }

      TouchPoints currentPoint = pointsList[i]!;
      TouchPoints nextPoint = pointsList[i + 1]!;

      // Draw line if both points exist
      canvas.drawLine(
          currentPoint.points, nextPoint.points, currentPoint.paint);
    }

    // Draw individual points
    for (var point in pointsList) {
      if (point != null) {
        canvas.drawPoints(ui.PointMode.points, [point.points], point.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
