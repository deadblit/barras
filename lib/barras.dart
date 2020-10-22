library barras;

import 'package:flutter/material.dart';

import 'barcode_reader/barcode_reader_page.dart';

class Barras {

  static Future<String> scan(BuildContext context, {
    bool showBorder = true,
    int borderFlashDuration = 500,
    double viewfinderWidth = 240.0,
    double viewfinderHeight = 240.0,
    double borderRadius = 16.0,
    Color scrimColor = Colors.black54,
    Color borderColor = Colors.green,
    double borderStrokeWidth = 4.0,
    Color buttonColor = Colors.white,
    String cancelButtonText = "Cancel",
    bool successBeep = true,
  }) async {
    final String data = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => BarcodeReaderPage(
        showBorder: showBorder,
        borderFlashDuration: borderFlashDuration,
        viewfinderWidth: viewfinderWidth,
        viewfinderHeight: viewfinderHeight,
        borderRadius: borderRadius,
        scrimColor: scrimColor,
        borderColor: borderColor,
        borderStrokeWidth: borderStrokeWidth,
        buttonColor: buttonColor,
        cancelButtonText: cancelButtonText,
        successBeep: successBeep,
      )),
    );

    return data;
  }
}
