import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/framed_image.dart';
import '../../domain/usecases/pick_image_usecase.dart';
import '../../domain/usecases/apply_frame_usecase.dart';
import '../../domain/usecases/save_image_usecase.dart';
import '../../domain/usecases/share_image_usecase.dart';
import '../../core/services/preferences_service.dart';
import 'processing_state_provider.dart';

class FramedImageNotifier extends StateNotifier<AsyncValue<FramedImage>> {
  final PickImageUseCase pickImageUseCase;
  final ApplyFrameUseCase applyFrameUseCase;
  final SaveImageUseCase saveImageUseCase;
  final ShareImageUseCase shareImageUseCase;
  final PreferencesService? preferencesService;
  final Ref ref;

  FramedImageNotifier({
    required this.pickImageUseCase,
    required this.applyFrameUseCase,
    required this.saveImageUseCase,
    required this.shareImageUseCase,
    required this.preferencesService,
    required this.ref,
  }) : super(AsyncValue.data(FramedImage(
          frameSize: preferencesService?.getFrameSize() ?? 0.05,
          frameColor: preferencesService?.getFrameColor() ?? 0xFFFFFFF5,
        )));

  Future<void> pickImage() async {
    // Preserve current frame settings before loading
    final currentState = state.value ?? FramedImage(
      frameSize: preferencesService?.getFrameSize() ?? 0.05,
      frameColor: preferencesService?.getFrameColor() ?? 0xFFFFFFF5,
    );
    final savedFrameSize = currentState.frameSize;
    final savedFrameColor = currentState.frameColor;

    state = const AsyncValue.loading();
    try {
      final pickedImage = await pickImageUseCase();
      if (pickedImage != null) {
        final newState = FramedImage(
          originalImage: pickedImage.bytes,
          framedImage: null,
          imageWidth: pickedImage.width,
          imageHeight: pickedImage.height,
          frameSize: savedFrameSize,  // Preserve frame size
          frameColor: savedFrameColor, // Preserve frame color
        );

        // Just set the image, no processing
        state = AsyncValue.data(newState);
      } else {
        state = AsyncValue.data(currentState);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }


  Future<void> saveImage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasImage) return;

    ref.read(isProcessingProvider.notifier).state = true;

    try {
      // Process the image with current frame settings
      final framedImageBytes = await applyFrameUseCase(
        imageBytes: currentState.originalImage!,
        frameSize: currentState.frameSize,
        frameColor: currentState.frameColor,
      );

      // Save the processed image
      await saveImageUseCase(framedImageBytes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      ref.read(isProcessingProvider.notifier).state = false;
    }
  }

  Future<void> shareImage() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasImage) return;

    ref.read(isProcessingProvider.notifier).state = true;

    try {
      // Process the image with current frame settings
      final framedImageBytes = await applyFrameUseCase(
        imageBytes: currentState.originalImage!,
        frameSize: currentState.frameSize,
        frameColor: currentState.frameColor,
      );

      // Save and share the processed image
      final imagePath = await saveImageUseCase(framedImageBytes);
      await shareImageUseCase(imagePath);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      ref.read(isProcessingProvider.notifier).state = false;
    }
  }

  void updateFrameSize(double size) {
    final currentState = state.value;
    if (currentState == null || !currentState.hasImage) return;

    // Update state immediately - no processing
    state = AsyncValue.data(
      currentState.copyWith(frameSize: size),
    );

    // Save to preferences
    preferencesService?.saveFrameSize(size);
  }

  void updateFrameColor(int color) {
    final currentState = state.value;
    if (currentState == null || !currentState.hasImage) return;

    // Update state immediately - no processing
    state = AsyncValue.data(
      currentState.copyWith(frameColor: color),
    );

    // Save to preferences
    preferencesService?.saveFrameColor(color);
  }

  void reset() {
    state = AsyncValue.data(FramedImage(
      frameSize: preferencesService?.getFrameSize() ?? 0.05,
      frameColor: preferencesService?.getFrameColor() ?? 0xFFFFFFF5,
    ));
  }
}
