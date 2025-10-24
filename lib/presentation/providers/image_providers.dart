import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_sources/image_data_source.dart';
import '../../data/repositories/image_repository_impl.dart';
import '../../domain/repositories/image_repository.dart';
import '../../domain/usecases/pick_image_usecase.dart';
import '../../domain/usecases/apply_frame_usecase.dart';
import '../../domain/usecases/save_image_usecase.dart';
import '../../domain/usecases/share_image_usecase.dart';
import '../../domain/entities/framed_image.dart';
import '../../core/services/preferences_service.dart';
import 'framed_image_notifier.dart';

// Preferences Service Provider
final preferencesServiceProvider = FutureProvider<PreferencesService>((ref) async {
  return await PreferencesService.init();
});

// Data Source Provider
final imageDataSourceProvider = Provider<ImageDataSource>((ref) {
  return ImageDataSource();
});

// Repository Provider
final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  final dataSource = ref.watch(imageDataSourceProvider);
  return ImageRepositoryImpl(dataSource);
});

// Use Case Providers
final pickImageUseCaseProvider = Provider<PickImageUseCase>((ref) {
  final repository = ref.watch(imageRepositoryProvider);
  return PickImageUseCase(repository);
});

final applyFrameUseCaseProvider = Provider<ApplyFrameUseCase>((ref) {
  final repository = ref.watch(imageRepositoryProvider);
  return ApplyFrameUseCase(repository);
});

final saveImageUseCaseProvider = Provider<SaveImageUseCase>((ref) {
  final repository = ref.watch(imageRepositoryProvider);
  return SaveImageUseCase(repository);
});

final shareImageUseCaseProvider = Provider<ShareImageUseCase>((ref) {
  final repository = ref.watch(imageRepositoryProvider);
  return ShareImageUseCase(repository);
});

// State Notifier Provider
final framedImageProvider = StateNotifierProvider<FramedImageNotifier, AsyncValue<FramedImage>>((ref) {
  final prefsAsync = ref.watch(preferencesServiceProvider);

  return prefsAsync.when(
    data: (prefs) => FramedImageNotifier(
      pickImageUseCase: ref.watch(pickImageUseCaseProvider),
      applyFrameUseCase: ref.watch(applyFrameUseCaseProvider),
      saveImageUseCase: ref.watch(saveImageUseCaseProvider),
      shareImageUseCase: ref.watch(shareImageUseCaseProvider),
      preferencesService: prefs,
      ref: ref,
    ),
    loading: () => FramedImageNotifier(
      pickImageUseCase: ref.watch(pickImageUseCaseProvider),
      applyFrameUseCase: ref.watch(applyFrameUseCaseProvider),
      saveImageUseCase: ref.watch(saveImageUseCaseProvider),
      shareImageUseCase: ref.watch(shareImageUseCaseProvider),
      preferencesService: null,
      ref: ref,
    ),
    error: (_, __) => FramedImageNotifier(
      pickImageUseCase: ref.watch(pickImageUseCaseProvider),
      applyFrameUseCase: ref.watch(applyFrameUseCaseProvider),
      saveImageUseCase: ref.watch(saveImageUseCaseProvider),
      shareImageUseCase: ref.watch(shareImageUseCaseProvider),
      preferencesService: null,
      ref: ref,
    ),
  );
});
