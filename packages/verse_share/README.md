# Share the verse

## Features

- [x] download on web
- [x] download on android
- [ ] share on web
- [ ] share android

## Getting started

`import 'package:verse_share/verse_share.dart';`

## Usage

Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
void captureImage() async {
    RenderRepaintBoundary boundary = _imageCaptureKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    await VerseShare().downloadImage(boundary: boundary, fileName: "test");
  }
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
