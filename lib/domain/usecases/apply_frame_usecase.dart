import 'dart:typed_data';
import '../repositories/image_repository.dart';

class ApplyFrameUseCase {
  final ImageRepository repository;

  ApplyFrameUseCase(this.repository);

  Future<Uint8List> call({
    required Uint8List imageBytes,
    required double frameSize,
    required int frameColor,
  }) async {
    return await repository.applyFrame(
      imageBytes: imageBytes,
      frameSize: frameSize,
      frameColor: frameColor,
    );
  }
}
