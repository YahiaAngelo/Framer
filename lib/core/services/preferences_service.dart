import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _frameSizeKey = 'frame_size';
  static const String _frameColorKey = 'frame_color';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static Future<PreferencesService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PreferencesService(prefs);
  }

  // Frame Size
  Future<void> saveFrameSize(double size) async {
    await _prefs.setDouble(_frameSizeKey, size);
  }

  double getFrameSize() {
    return _prefs.getDouble(_frameSizeKey) ?? 0.05; // Default 5%
  }

  // Frame Color
  Future<void> saveFrameColor(int color) async {
    await _prefs.setInt(_frameColorKey, color);
  }

  int getFrameColor() {
    return _prefs.getInt(_frameColorKey) ?? 0xFFFFFFF5; // Default cream
  }
}
