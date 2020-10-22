# Barras

A simple and customizable barcode scanning Flutter package for Android and iOS. It uses AVCaptureSession in iOS and ZXing in Android.

Please bear in mind that Barras is experimental, in early development stage.

## Getting Started

### iOS specific setup

You'll need to configure the camera usage permission message and embed view previews in the `Info.plist` file:

```xml
<key>NSCameraUsageDescription</key>
<string>Camera permission is required for barcode scanning.</string>
<key>io.flutter.embedded_views_preview</key>
<true/>
```

### Import and use in your code

Add Barras dependency to the `pubspec.yaml` file:

```yaml
dependencies:
  barras: ^0.0.1
```

Import it in your code:

```dart
import 'package:barras/barras.dart';
```

Simply call the `scan` method, and we are good to go:

```dart
// Open the barcode reading page. Returned data will be null if
// Cancel button is pressed, or if user navigates back
final data = await Barras.scan(context);
```

![Default barcode capture page](https://github.com/deadblit/barras/example/screenshots/Screenshot_20201022-034615.jpg)

You can also customize the appearance of the barcode capture page:

```dart
// Open the barcode reading page. Customize the appearance, changing the
// viewfinder color, size and blinking speed. Returned data will be null
// if Cancel button is pressed, or if user navigates back
final data = await Barras.scan(
  context,
  viewfinderHeight: 120,
  viewfinderWidth: 300,
  scrimColor: Color.fromRGBO(128, 0, 0, 0.5),
  borderColor: Colors.red,
  borderRadius: 24,
  borderStrokeWidth: 2,
  buttonColor: Colors.yellow,
  borderFlashDuration: 250,
  cancelButtonText: "取消",
  successBeep: false,
);
```

![Customized barcode capture page](https://github.com/deadblit/barras/example/screenshots/Screenshot_20201022-034726.jpg)

You can check a working example app in the [example folder](https://github.com/deadblit/barras/example/lib/).
