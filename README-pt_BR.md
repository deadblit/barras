# Barras

Este documento também está disponível em: [English](https://github.com/deadblit/barras/blob/main/README.md) \| **Português**

---

Barras é um pacote Flutter para leitura de códigos de barras, simples e configurável, disponível para Android e iOS. Utiliza `AVCaptureSession` no iOS e `ZXing` no Android.

Por favor lembre-se de que Barras é um pacote experimental, em estágio de desenvolvimento inicial.

## Começando

### Requisitos

O Barras precisa da permissão para uso da camera, tanto no iOS quanto no Android. Este tratamento precisa
ser implementado por você, considerando as alternativas que você possivelmente já pode estar usando
para solicitar permissões para o usuário.

Se você ainda não está tratando permissões, existem plugins bons para fazer o tratamento, 
como o [permission_handler](https://pub.dev/packages/permission_handler).

Além disso, Barras depende do seguinte:

- Flutter 2.2.3 ou mais recente
- Android API 26 (Marshmallow) ou mais recente
- iOS 9.0 ou mais recente

### Importe e utilize no seu código

Adicione a dependência da Barras no seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  barras: ^0.1.0-nullsafety.1
```

Importe no seu código:

```dart
import 'package:barras/barras.dart';
```

Simplemente chame o método `scan` e estamos prontos:

```dart
// Abre a página de leitura de códigos de barras. O retorno será
// null se o botão Cancel for apertado, ou se o usuário navegar para trás.
final codigo = await Barras.scan(context);
```

![Página de captura padrão](https://github.com/deadblit/barras/raw/main/example/screenshots/Screenshot_20201022-034615.jpg)

Você também pode customizar a aparência da página de captura de códigos de barras:

```dart
// Abre a página de leitura de códigos de barras. Configura a a aparência,
// modificando a cor do visor, seu tamanho e a velocidade de piscar.
// O retorno será null se o botão Cancel for apertado, ou se o usuário
// navegar para trás.
final codigo = await Barras.scan(
  context,
  viewfinderHeight: 120,
  viewfinderWidth: 300,
  scrimColor: Color.fromRGBO(0, 128, 0, 0.5),
  borderColor: Colors.lightGreen,
  borderRadius: 24,
  borderStrokeWidth: 2,
  buttonColor: Colors.yellow,
  borderFlashDuration: 250,
  cancelButtonText: "Cancelar",
  successBeep: false,
);
```

![Página de captura customizada](https://github.com/deadblit/barras/raw/main/example/screenshots/Screenshot_20201026-181635.jpg)

Você pode ver um app de exemplo funcional na [pasta example](https://github.com/deadblit/barras/example/lib/).
