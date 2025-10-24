import 'dart:typed_data';
import '../entities/picked_image.dart';

abstract class ImageRepository {
  /// Pick an image from the gallery
  Future<PickedImage?> pickImage();

  /// Apply frame to an image
  Future<Uint8List> applyFrame({
    required Uint8List imageBytes,
    required double frameSize,
    required int frameColor,
  });

  /// Save the framed image to device storage
  Future<String> saveImage(Uint8List imageBytes);

  /// Share the framed image
  Future<void> shareImage(String imagePath);
}
