# Framer 🖼️

A beautiful, minimalist Flutter app that adds vintage film-style frames to your photos. Simple, elegant, and completely free.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?logo=flutter)](https://flutter.dev)
[![Material 3](https://img.shields.io/badge/Material-3-6200EE?logo=material-design)](https://m3.material.io)

## ✨ Features

- **Real-time Preview** - Instant visual feedback as you adjust frame settings
- **Adjustable Frame Size** - Precise control from 2px to 30px (1% to 15%)
- **Vintage Color Palette** - Cream, White, Black, Gold, and Wood frame colors
- **Material You Design** - Beautiful, adaptive UI with warm vintage-inspired colors
- **Smart Persistence** - Remembers your last frame size and color preferences
- **High-Quality Export** - Saves full-resolution framed images to your gallery
- **Easy Sharing** - Share framed photos directly from the app
- **Clean Architecture** - Well-structured, maintainable codebase

## 📱 Screenshots

_Coming soon..._

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three distinct layers:

```
lib/
├── core/
│   ├── services/         # Shared services (preferences)
│   └── theme/           # Material You theme
├── domain/
│   ├── entities/        # Business models
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business logic
├── data/
│   ├── data_sources/    # Data sources (API, local storage)
│   └── repositories/    # Repository implementations
└── presentation/
    ├── providers/       # Riverpod state management
    ├── screens/         # UI screens
    └── widgets/         # Reusable UI components
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod 2.6
- **UI**: Material Design 3 (Material You)
- **Typography**: Google Fonts (Roboto)
- **Image Processing**: Dart `image` package with isolate computing
- **Persistence**: SharedPreferences
- **Storage**: Gal (gallery saver)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart 3.0.0 or higher
- Xcode 14+ (for iOS)
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yahiaangelo/framer.git
   cd framer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android (APK)**
```bash
flutter build apk --release
```

**Android (App Bundle)**
```bash
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

## 🎨 Design Philosophy

Framer embraces simplicity and does one thing perfectly: adding beautiful frames to your photos. The app features:

- **Material You** design system with warm, vintage-inspired colors
- **Golden brown** primary color (#745B0C) for a film-like aesthetic
- **Instant feedback** - all adjustments happen in real-time
- **No complexity** - just pick, frame, and save

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Material Design 3 color scheme inspired by vintage film photography
- Icons from Material Icons
- Font from Google Fonts (Roboto)

## 📬 Contact

Yahia Angelo - [@yahiaangelo](https://github.com/yahiaangelo)

Project Link: [https://github.com/yahiaangelo/framer](https://github.com/yahiaangelo/framer)

## 🔒 Privacy

Framer processes all images locally on your device. No data is sent to external servers. Your photos remain private and secure.

---

Made with ❤️ using Flutter
