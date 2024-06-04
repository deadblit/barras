import 'package:barras/barras.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Barras reader",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _scannedCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barras Sample App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBarcodeLabel(),
            _buildDefaultScanButton(context),
            _buildCustomScanButton(context),
          ],
        ),
      ),
    );
  }

  // Build a text widget that shows the last scanned QR code
  Widget _buildBarcodeLabel() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(16.0),
      ),
      height: 224.0,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        _scannedCode,
        textAlign: TextAlign.center,
        maxLines: 4,
        softWrap: true,
      ),
    );
  }

  // Build the button that opens Barras with default settings
  Widget _buildDefaultScanButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
      ),
      onPressed: () async {
        // Open the barcode reading page. Returned data will be null if
        // Cancel button is pressed, or if user navigates back
        final data = await Barras.scan(context);

        setState(() {
          _scannedCode = data ?? "";
        });
      },
      child: const Text('OPEN DEFAULT SCANNER'),
    );
  }

  // Build the button that opens Barras with customizations
  Widget _buildCustomScanButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        backgroundColor: Colors.white,
      ),
      onPressed: () async {
        // Open the barcode reading page. Customize the appearance, changing the
        // viewfinder color, size and blinking speed. Returned data will be null
        // if Cancel button is pressed, or if user navigates back
        final data = await Barras.scan(
          context,
          viewfinderHeight: 120,
          viewfinderWidth: 300,
          scrimColor: const Color.fromRGBO(128, 0, 0, 0.5),
          borderColor: Colors.red,
          borderRadius: 24,
          borderStrokeWidth: 2,
          buttonColor: Colors.yellow,
          borderFlashDuration: 250,
          cancelButtonText: "取消",
          successBeep: false,
        );

        setState(() {
          _scannedCode = data ?? "";
        });
      },
      child: const Text('OPEN CUSTOMIZED SCANNER'),
    );
  }
}
