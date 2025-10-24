import 'dart:typed_data';
import '../repositories/image_repository.dart';

class SaveImageUseCase {
  final ImageRepository repository;

  SaveImageUseCase(this.repository);

  Future<String> call(Uint8List imageBytes) async {
    return await repository.saveImage(imageBytes);
  }
}
