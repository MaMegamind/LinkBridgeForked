# 🔗 link_bridge

A lightweight Flutter plugin to handle **deep linking** and **deferred links** on Android and iOS – a simple, Firebase-free alternative to Dynamic Links.

---

## ✅ Features

- 🔗 Deep linking on Android & iOS (App Links & Universal Links)
- ⏳ Deferred deep linking (handle links even if the app is installed after the click)
- 📈 Built-in analytics for links
- 🛠 Zero additional configuration required
- ⚙️ Works with `https://linkbridge.chimeratechsolutions.com`

---

## 📲 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  link_bridge: 1.1.4
```

---

## 📦 Platform Setup

### 🟢 Android

Edit `android/app/src/main/AndroidManifest.xml`:

```xml
<!-- Disable Flutter's default deep linking -->
<meta-data android:name="flutter_deeplinking_enabled" android:value="false" />

<!-- App Link support -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="https"
        android:host="${your_app_name}.chimeratechsolutions.com"
        android:pathPrefix="/link" />
</intent-filter>
```

> Replace `${your_app_name}` with your actual app name or identifier.

---

### 🍏 iOS

1. Open your project in **Xcode**
2. Go to **Signing & Capabilities** → Add **Associated Domains**
3. Add the following domain for all build configurations (Debug, Release, Profile):

```
applinks:${your_app_name}.chimeratechsolutions.com
```

4. Then in your `Info.plist`:

```xml
<key>FlutterDeepLinkingEnabled</key>
<false/>
<key>AssociatedDomains</key>
<array>
    <string>applinks:${your_app_name}.chimeratechsolutions.com</string>
</array>
```

---

## 💻 Dart API

Import the plugin:

```dart
import 'package:link_bridge/link_bridge.dart';
```

### 🔍 Get deep link on app launch:

```dart
Uri? deepLink = await LinkBridge().init();
```

### 📡 Listen for deep links in the foreground:

```dart
LinkBridge().listen((Uri? deepLink) async {
  print('New deep link: $deepLink');
});
```

---

## 📌 Notes

- 🧠 Works out of the box — no need for Firebase or extra setup
- 📥 Handles install → open flow (deferred links)
- 📊 Includes analytics for tracking link usage
- 👯 Fully supports App Links (Android) and Universal Links (iOS)
