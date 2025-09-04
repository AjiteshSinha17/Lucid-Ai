# 🚀 Lucid AI Chatbot Setup Instructions

## 📋 Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Firebase account
- OpenAI API key (optional)

## 🛠️ Installation Steps

### 1. Extract the Project
```bash
# Extract the zip file and navigate to project directory
unzip lucid_ai_chatbot.zip
cd lucid_ai_chatbot
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project
3. Enable Authentication (Email/Password and Google)

#### Configure Android
1. Add an Android app to your Firebase project
2. Use package name: `com.example.lucid_ai_chatbot`
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### Configure iOS (if building for iOS)
1. Add an iOS app to your Firebase project
2. Use bundle ID: `com.example.lucidAiChatbot`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

### 4. Environment Variables
1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
2. Edit `.env` file with your API keys:
   ```
   OPENAI_API_KEY=your_openai_api_key_here
   FIREBASE_API_KEY=your_firebase_api_key_here
   ```

### 5. Android Configuration
Add to `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 34

    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.3.1')
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.android.gms:play-services-auth:20.7.0'
}
```

### 6. Run the App
```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For web
flutter run -d web
```

## 🎯 Features

✅ **Authentication System**
- Google Sign-In
- GitHub Sign-In (mock)
- Email/Password authentication
- Beautiful animated UI

✅ **AI Chatbot**
- OpenAI integration
- Smart roadmap detection
- Markdown formatting
- Context-aware responses

✅ **Learning Roadmaps**
- 15+ comprehensive roadmaps
- Visual learning paths
- Official documentation links
- PDF downloads
- Career guidance

✅ **Beautiful UI**
- Glassmorphism design
- Smooth animations
- Gradient backgrounds
- Dark theme

## 🔧 Customization

### Add New Roadmaps
Edit `lib/services/roadmap_service.dart`:
```dart
DetailedRoadmapModel(
  id: 'your-roadmap',
  title: 'Your Technology',
  // ... configuration
),
```

### Change Theme Colors
Edit `lib/main.dart`:
```dart
colorScheme: const ColorScheme.dark(
  primary: Color(0xFFYourColor),
  secondary: Color(0xFFYourColor),
),
```

### Add API Providers
Edit `lib/services/ai_provider.dart` to add more AI services.

## 📱 Testing

### Test Authentication
1. Try Google Sign-In
2. Try Email/Password registration
3. Test sign-out functionality

### Test Roadmaps
1. Ask: "Show me Flutter roadmap"
2. Try: "How to learn React?"
3. Browse roadmap search

### Test UI
1. Check animations
2. Test responsive design
3. Verify dark theme

## 🚨 Troubleshooting

### Common Issues

**Build Errors:**
- Run `flutter clean && flutter pub get`
- Check Flutter version: `flutter --version`

**Firebase Auth Errors:**
- Verify `google-services.json` is in correct location
- Check Firebase console configuration

**API Errors:**
- Verify `.env` file exists and has correct keys
- Check internet connection

**UI Issues:**
- Ensure all dependencies are installed
- Check device/emulator compatibility

## 📞 Support

For issues:
1. Check Firebase console logs
2. Run `flutter doctor` to verify setup
3. Check device logs: `flutter logs`

## 🎉 You're Ready!

Your Lucid AI Chatbot is now set up and ready to use! Enjoy exploring developer roadmaps with your new AI companion! 🚀
