import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:qrcode_forked/qrcode_forked.dart';
import 'package:torch_controller/torch_controller.dart';

import 'barcode_reader_overlay_painter.dart';

class BarcodeReaderPage extends StatefulWidget {
  final bool showBorder;
  final int borderFlashDuration;
  final double viewfinderWidth;
  final double viewfinderHeight;
  final double borderRadius;
  final Color scrimColor;
  final Color borderColor;
  final double borderStrokeWidth;
  final Color buttonColor;
  final String cancelButtonText;
  final bool successBeep;

  BarcodeReaderPage({
    this.showBorder = true,
    this.borderFlashDuration = 500,
    this.viewfinderWidth = 240.0,
    this.viewfinderHeight = 240.0,
    this.borderRadius = 16.0,
    this.scrimColor = Colors.black54,
    this.borderColor = Colors.green,
    this.borderStrokeWidth = 4.0,
    this.buttonColor = Colors.white,
    this.cancelButtonText = "Cancel",
    this.successBeep = true,
  });

  @override
  _BarcodeReaderPageState createState() => _BarcodeReaderPageState();
}

class _BarcodeReaderPageState extends State<BarcodeReaderPage> {
  QRCaptureController _captureController = QRCaptureController();

  bool _hasTorch = false;
  bool _isTorchOn = false;
  bool _isBorderVisible = false;
  Timer? _borderFlashTimer;

  @override
  void initState() {
    super.initState();

    if (widget.showBorder) {
      setState(() {
        _isBorderVisible = true;
      });

      if (widget.borderFlashDuration > 0) {
        _borderFlashTimer = Timer.periodic(
            Duration(milliseconds: widget.borderFlashDuration), (timer) {
          setState(() {
            _isBorderVisible = !_isBorderVisible;
          });
        });
      }
    }
    TorchController().hasTorch.then((value) {
      setState(() {
        _hasTorch = value ?? false;
      });
    });

    _captureController.onCapture((data) {
      _captureController.pause();
      if (widget.successBeep) {
        FlutterBeep.beep();
      }
      Navigator.of(context).pop(data);
    });
  }

  @override
  void dispose() {
    _borderFlashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildCaptureView(),
          _buildViewfinder(context),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Widget _buildCaptureView() {
    return QRCaptureView(
      controller: _captureController,
    );
  }

  Widget _buildViewfinder(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: BarcodeReaderOverlayPainter(
        drawBorder: _isBorderVisible,
        viewfinderWidth: widget.viewfinderWidth,
        viewfinderHeight: widget.viewfinderHeight,
        borderRadius: widget.borderRadius,
        scrimColor: widget.scrimColor,
        borderColor: widget.borderColor,
        borderStrokeWidth: widget.borderStrokeWidth,
      ),
    );
  }

  Widget _buildButtonBar() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        color: Colors.black26,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTorchButton(),
            _buildCancelButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTorchButton() {
    return (_hasTorch)
        ? IconButton(
            icon: Icon(
              (_isTorchOn) ? Icons.flash_on : Icons.flash_off,
              color: widget.buttonColor,
            ),
            onPressed: () {
              if (_isTorchOn) {
                _captureController.torchMode = CaptureTorchMode.off;
              } else {
                _captureController.torchMode = CaptureTorchMode.on;
              }

              setState(() {
                _isTorchOn = !_isTorchOn;
              });
            },
          )
        : Container(
            width: 10,
            height: 10,
          );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        _captureController.pause();
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        foregroundColor: widget.buttonColor,
      ),
      child: Text(widget.cancelButtonText),
    );
  }
}
