# Barras

This document is also available in: **English** \| [Português](https://github.com/deadblit/barras/blob/main/README-pt_BR.md)

---

Barras is a simple and customizable barcode scanning Flutter package for Android and iOS. It uses AVCaptureSession in iOS and ZXing in Android.

Please bear in mind that Barras is experimental, in early development stage.

## Getting Started

### Requirements

Barras requires camera usage permission, on both iOS and Android. This must be implemented by you,
considering any alternatives that you may be already using for user permission requests.

If you are not handling permissions yet, there are good plugins to do it, like [permission_handler](https://pub.dev/packages/permission_handler).

Besides that, Barras depends on the following:

- Flutter 2.10.5 or higher
- Android API 26 (Marshmallow) or newer
- iOS 9.0 or newer

### Import and use in your code

Add Barras dependency to the `pubspec.yaml` file:

```yaml
dependencies:
  barras: ^0.2.1
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

![Default barcode capture page](https://github.com/deadblit/barras/raw/main/example/screenshots/Screenshot_20201022-034615.jpg)

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

![Customized barcode capture page](https://github.com/deadblit/barras/raw/main/example/screenshots/Screenshot_20201022-034726.jpg)

You can check a working example app in the [example folder](https://github.com/deadblit/barras/example/lib/).
