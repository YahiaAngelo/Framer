import 'dart:typed_data';
import '../../domain/repositories/image_repository.dart';
import '../../domain/entities/picked_image.dart';
import '../data_sources/image_data_source.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataSource dataSource;

  ImageRepositoryImpl(this.dataSource);

  @override
  Future<PickedImage?> pickImage() async {
    final result = await dataSource.pickImageFromGallery();
    if (result == null) return null;

    return PickedImage(
      bytes: result['bytes'] as Uint8List,
      width: result['width'] as int,
      height: result['height'] as int,
    );
  }

  @override
  Future<Uint8List> applyFrame({
    required Uint8List imageBytes,
    required double frameSize,
    required int frameColor,
  }) async {
    return await dataSource.applyFrameToImage(
      imageBytes: imageBytes,
      frameSize: frameSize,
      frameColor: frameColor,
    );
  }

  @override
  Future<String> saveImage(Uint8List imageBytes) async {
    return await dataSource.saveImageToDevice(imageBytes);
  }

  @override
  Future<void> shareImage(String imagePath) async {
    return await dataSource.shareImageFile(imagePath);
  }
}
