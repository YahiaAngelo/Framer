import '../repositories/image_repository.dart';
import '../entities/picked_image.dart';

class PickImageUseCase {
  final ImageRepository repository;

  PickImageUseCase(this.repository);

  Future<PickedImage?> call() async {
    return await repository.pickImage();
  }
}
