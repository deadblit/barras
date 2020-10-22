import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;

class BarcodeReaderOverlayPainter extends CustomPainter {
  final drawBorder;
  final viewfinderWidth;
  final viewfinderHeight;
  final borderRadius;
  final scrimColor;
  final borderColor;
  final borderStrokeWidth;

  BarcodeReaderOverlayPainter({
    this.drawBorder = true,
    this.viewfinderWidth = 240.0,
    this.viewfinderHeight = 240.0,
    this.borderRadius = 16.0,
    this.scrimColor = Colors.black54,
    this.borderColor = Colors.green,
    this.borderStrokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final halfCutoutWidth = viewfinderWidth / 2;
    final halfCutoutHeight = viewfinderHeight / 2;

    // Draw the semitransparent area with a cutout in center
    _paintViewfinderScrim(
        canvas, size, center, halfCutoutWidth, halfCutoutHeight);

    // Draw the border arcs in the center cutout corners
    if (drawBorder) {
      _paintViewfinderBorder(canvas, center, halfCutoutWidth, halfCutoutHeight);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final previousPainter = oldDelegate as BarcodeReaderOverlayPainter;

    return (previousPainter.drawBorder != drawBorder);
  }

  void _paintViewfinderScrim(Canvas canvas, Size canvasSize, Offset center,
      double halfCutoutWidth, double halfCutoutHeight) {
    final scrimPaint = Paint()..color = scrimColor;

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()
            ..addRect(Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height)),
          Path()
            ..addRRect(RRect.fromLTRBR(
                center.dx - halfCutoutWidth,
                center.dy - halfCutoutHeight,
                center.dx + halfCutoutWidth,
                center.dy + halfCutoutHeight,
                Radius.circular(borderRadius)))
            ..close(),
        ),
        scrimPaint);
  }

  void _paintViewfinderBorder(Canvas canvas, Offset center,
      double halfCutoutWidth, double halfCutoutHeight) {
    final arcAreaSide = borderRadius;
    final arcAreaOffset = borderRadius / 2;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderStrokeWidth;

    // Top left arc
    var arcRect = Rect.fromLTWH(
      center.dx - halfCutoutWidth + arcAreaOffset,
      center.dy - halfCutoutHeight + arcAreaOffset,
      arcAreaSide,
      arcAreaSide,
    );

    canvas.drawPath(
      Path()
        ..addArc(
          arcRect,
          Math.pi,
          Math.pi / 2,
        )
        ..moveTo(arcRect.topRight.dx - arcAreaSide / 2, arcRect.topRight.dy)
        ..relativeLineTo(arcAreaSide, 0)
        ..moveTo(arcRect.bottomLeft.dx, arcRect.bottomLeft.dy - arcAreaSide / 2)
        ..relativeLineTo(0, arcAreaSide),
      borderPaint,
    );

    // Top right arc
    arcRect = Rect.fromLTWH(
      center.dx + halfCutoutWidth - arcAreaSide - arcAreaOffset,
      center.dy - halfCutoutHeight + arcAreaOffset,
      arcAreaSide,
      arcAreaSide,
    );

    canvas.drawPath(
      Path()
        ..addArc(
          arcRect,
          0,
          -Math.pi / 2,
        )
        ..moveTo(arcRect.topLeft.dx - arcAreaSide / 2, arcRect.topLeft.dy)
        ..relativeLineTo(arcAreaSide, 0)
        ..moveTo(
            arcRect.bottomRight.dx, arcRect.bottomRight.dy - arcAreaSide / 2)
        ..relativeLineTo(0, arcAreaSide),
      borderPaint,
    );

    // Bottom right arc
    arcRect = Rect.fromLTWH(
      center.dx + halfCutoutWidth - arcAreaSide - arcAreaOffset,
      center.dy + halfCutoutHeight - arcAreaSide - arcAreaOffset,
      arcAreaSide,
      arcAreaSide,
    );

    canvas.drawPath(
      Path()
        ..addArc(
          arcRect,
          0,
          Math.pi / 2,
        )
        ..moveTo(arcRect.topRight.dx, arcRect.topRight.dy - arcAreaSide / 2)
        ..relativeLineTo(0, arcAreaSide)
        ..moveTo(arcRect.bottomLeft.dx - arcAreaSide / 2, arcRect.bottomLeft.dy)
        ..relativeLineTo(arcAreaSide, 0),
      borderPaint,
    );

    // Bottom left arc
    arcRect = Rect.fromLTWH(
      center.dx - halfCutoutWidth + arcAreaOffset,
      center.dy + halfCutoutHeight - arcAreaSide - arcAreaOffset,
      arcAreaSide,
      arcAreaSide,
    );

    canvas.drawPath(
      Path()
        ..addArc(
          arcRect,
          Math.pi,
          -Math.pi / 2,
        )
        ..moveTo(arcRect.topLeft.dx, arcRect.topLeft.dy - arcAreaSide / 2)
        ..relativeLineTo(0, arcAreaSide)
        ..moveTo(
            arcRect.bottomRight.dx - arcAreaSide / 2, arcRect.bottomRight.dy)
        ..relativeLineTo(arcAreaSide, 0),
      borderPaint,
    );
  }
}
