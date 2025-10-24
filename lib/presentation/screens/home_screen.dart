import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/image_providers.dart';
import '../providers/processing_state_provider.dart';
import '../widgets/action_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final framedImageState = ref.watch(framedImageProvider);
    final isProcessing = ref.watch(isProcessingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Framer'),
      ),
      body: Stack(
        children: [
          framedImageState.when(
        data: (framedImage) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: framedImage.hasImage
                        ? _buildImagePreviewWithFrame(
                            framedImage.originalImage!,
                            framedImage.frameSize,
                            framedImage.frameColor,
                          )
                        : _buildPlaceholder(context, ref),
                  ),
                ),
                if (framedImage.hasImage) ...[
                  _buildControls(context, ref, framedImage),
                  const SizedBox(height: 16),
                  _buildActions(context, ref, framedImage),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF2C2C2C),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(framedImageProvider.notifier).reset(),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
          // Processing overlay
          if (isProcessing)
            Container(
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Processing...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImagePreviewWithFrame(
    Uint8List imageBytes,
    double frameSize,
    int frameColor,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(frameColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(constraints.maxWidth * frameSize), // Proportional frame
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.memory(
              imageBytes,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 60,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Add a photo to get started',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: () => ref.read(framedImageProvider.notifier).pickImage(),
          icon: const Icon(Icons.add_a_photo),
          label: const Text('Pick Image'),
        ),
      ],
    );
  }

  Widget _buildControls(BuildContext context, WidgetRef ref, framedImage) {
    final theme = Theme.of(context);
    final frameSizePixels = framedImage.frameThicknessPixels;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Frame Size',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${frameSizePixels}px',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.remove, size: 20, color: theme.colorScheme.onSurfaceVariant),
                Expanded(
                  child: Slider(
                    value: framedImage.frameSize,
                    min: 0.01,
                    max: 0.15,
                    onChanged: (value) {
                      ref.read(framedImageProvider.notifier).updateFrameSize(value);
                    },
                  ),
                ),
                Icon(Icons.add, size: 20, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Frame Color',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildColorOption(ref, 0xFFFFFFF5, 'Cream'),
                _buildColorOption(ref, 0xFFFFFFFF, 'White'),
                _buildColorOption(ref, 0xFF2C2C2C, 'Black'),
                _buildColorOption(ref, 0xFFD4AF37, 'Gold'),
                _buildColorOption(ref, 0xFF8B7355, 'Wood'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(WidgetRef ref, int colorValue, String label) {
    return InkWell(
      onTap: () {
        ref.read(framedImageProvider.notifier).updateFrameColor(colorValue);
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Color(colorValue),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(ref.context).colorScheme.outline.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(ref.context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, framedImage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              icon: Icons.refresh,
              label: 'New',
              onPressed: () => ref.read(framedImageProvider.notifier).pickImage(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ActionButton(
              icon: Icons.save_alt,
              label: 'Save',
              isPrimary: true,
              onPressed: framedImage.hasImage
                  ? () async {
                      await ref.read(framedImageProvider.notifier).saveImage();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Image saved successfully!'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                          ),
                        );
                      }
                    }
                  : () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ActionButton(
              icon: Icons.share,
              label: 'Share',
              onPressed: framedImage.hasImage
                  ? () => ref.read(framedImageProvider.notifier).shareImage()
                  : () {},
            ),
          ),
        ],
      ),
    );
  }
}
