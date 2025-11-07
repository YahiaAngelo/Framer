import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';

// Top-level function for compute isolate
class FrameParams {
  final Uint8List imageBytes;
  final double frameSize;
  final int frameColor;

  FrameParams({
    required this.imageBytes,
    required this.frameSize,
    required this.frameColor,
  });
}

Uint8List _applyFrameInIsolate(FrameParams params) {
  // Decode the image
  final originalImage = img.decodeImage(params.imageBytes);
  if (originalImage == null) {
    throw Exception('Failed to decode image');
  }

  // Calculate frame dimensions
  final frameThickness = (originalImage.width * params.frameSize).toInt();

  // Create new image with frame
  final framedWidth = originalImage.width + (frameThickness * 2);
  final framedHeight = originalImage.height + (frameThickness * 2);

  final framedImage = img.Image(width: framedWidth, height: framedHeight);

  // Fill with frame color
  img.fill(
    framedImage,
    color: img.ColorRgb8(
      (params.frameColor >> 16) & 0xFF,
      (params.frameColor >> 8) & 0xFF,
      params.frameColor & 0xFF,
    ),
  );

  // Composite the original image onto the frame
  img.compositeImage(
    framedImage,
    originalImage,
    dstX: frameThickness,
    dstY: frameThickness,
  );

  // Encode back to bytes
  final encodedImage = img.encodeJpg(framedImage, quality: 95);
  return Uint8List.fromList(encodedImage);
}

class ImageDataSource {
  final ImagePicker _picker = ImagePicker();

  Future<Map<String, dynamic>?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 90,
      );

      if (image == null) return null;

      final bytes = await image.readAsBytes();

      // Decode to get dimensions
      final decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) {
        throw Exception('Failed to decode image');
      }

      return {
        'bytes': bytes,
        'width': decodedImage.width,
        'height': decodedImage.height,
      };
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  Future<Uint8List> applyFrameToImage({
    required Uint8List imageBytes,
    required double frameSize,
    required int frameColor,
  }) async {
    try {
      // Run the heavy image processing in a separate isolate
      final params = FrameParams(
        imageBytes: imageBytes,
        frameSize: frameSize,
        frameColor: frameColor,
      );

      return await compute(_applyFrameInIsolate, params);
    } catch (e) {
      throw Exception('Failed to apply frame: $e');
    }
  }

  Future<String> saveImageToDevice(Uint8List imageBytes) async {
    try {
      // Save to temp directory first
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${directory.path}/framed_$timestamp.jpg';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      // Save to gallery using Gal (handles permissions automatically)
      await Gal.putImage(filePath, album: 'Framer');

      return filePath;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  Future<void> shareImageFile(String imagePath) async {
    try {
      await Share.shareXFiles(
        [XFile(imagePath)],
        text: 'Check out my framed photo!',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 10, 10),
      );
    } catch (e) {
      throw Exception('Failed to share image: $e');
    }
  }
}
