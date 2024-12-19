<div align="center">

# 🎬 Movie-App

<h3>A Modern Flutter Movie Discovery App</h3>

[![Flutter Version](https://img.shields.io/badge/Flutter-≥3.5.4-02569B?logo=flutter)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-≥3.5.4-0175C2?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](./CONTRIBUTING.md)

[Features](#features) • [Installation](#installation) • [Dependencies](#dependencies) • [Demo](#demo) 



## ✨ Features


### 🎯 Core Features

#### 🔍 Discovery
- **Browse** - Explore movies by genres and categories
- **Search** - Find movies instantly with real-time suggestions
- **Trending** - Stay updated with popular and upcoming releases
- **Details** - Comprehensive movie information and metadata

#### 📱 User Experience
- **Modern UI** - Clean Material Design interface
- **Dark Theme** - Eye-friendly dark mode
- **Responsive** - Adaptive layouts for all screen sizes
- **Smooth** - Custom animations and transitions

#### 🔖 Personal
- **Watchlist** - Save movies for later viewing
- **Firebase Sync** - Cloud-based watchlist storage
- **Quick Access** - Easy-to-use watchlist management

---


### 🏗 Components
- **API Service** - TMDb integration & data fetching
- **Firebase Service** - Cloud storage & synchronization
- **Models** - Data structures & serialization
- **UI Components** - Reusable widgets & screens

---

## ⚡ Installation

### Prerequisites
```bash
flutter --version  # ≥3.5.4
dart --version    # ≥3.5.4
```

### Quick Start
```bash
# Clone repository
git clone https://github.com/yourusername/movie_app.git

# Install dependencies
flutter pub get

# Run application
flutter run
```

### 🔑 API Configuration
1. Get TMDb API key from [themoviedb.org](https://www.themoviedb.org/documentation/api)
2. Add to `lib/service/service.dart`:
```dart
const apiKey = "YOUR_API_KEY";
```

---

## 🔧 Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  cupertino_icons: ^1.0.8
  carousel_slider: ^5.0.0
  http: ^1.2.2
  firebase_core: ^3.8.1
  cloud_firestore: ^5.5.1
  dio: ^5.7.0
```

---
## 🎥 Demo

<div align="center">
  <a href="https://youtube.com/shorts/pghiT03mPe8" target="_blank">
    <img src="https://img.shields.io/badge/WATCH%20DEMO-red?style=for-the-badge&logo=youtube&logoColor=white" alt="Watch Demo" width="200"/>
  </a>
</div>

###
Click the button above to watch the complete app demonstration

---


---

## 📄 License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

---

<div align="center">

## 💖 Support

Leave a ⭐️ if this project helped you!


