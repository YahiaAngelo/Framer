import 'dart:typed_data';

class FramedImage {
  final Uint8List? originalImage;
  final Uint8List? framedImage;
  final double frameSize;
  final int frameColor;
  final int? imageWidth;
  final int? imageHeight;

  const FramedImage({
    this.originalImage,
    this.framedImage,
    this.frameSize = 0.05,
    this.frameColor = 0xFFFFFFF5, // Cream/vintage white
    this.imageWidth,
    this.imageHeight,
  });

  FramedImage copyWith({
    Uint8List? originalImage,
    Uint8List? framedImage,
    double? frameSize,
    int? frameColor,
    int? imageWidth,
    int? imageHeight,
  }) {
    return FramedImage(
      originalImage: originalImage ?? this.originalImage,
      framedImage: framedImage ?? this.framedImage,
      frameSize: frameSize ?? this.frameSize,
      frameColor: frameColor ?? this.frameColor,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
    );
  }

  bool get hasImage => originalImage != null;
  bool get hasFramedImage => framedImage != null;

  int get frameThicknessPixels {
    if (imageWidth == null) return 0;
    return (imageWidth! * frameSize).round();
  }
}
