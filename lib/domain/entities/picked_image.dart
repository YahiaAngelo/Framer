import 'dart:typed_data';

class PickedImage {
  final Uint8List bytes;
  final int width;
  final int height;

  const PickedImage({
    required this.bytes,
    required this.width,
    required this.height,
  });
}
