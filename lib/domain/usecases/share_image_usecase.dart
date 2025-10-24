import '../repositories/image_repository.dart';

class ShareImageUseCase {
  final ImageRepository repository;

  ShareImageUseCase(this.repository);

  Future<void> call(String imagePath) async {
    return await repository.shareImage(imagePath);
  }
}
