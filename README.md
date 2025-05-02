# 🔗 link_bridge

> **⚡ To use this plugin, you must [create an account and get your App Key here](https://linkbridge.chimeratechsolutions.com/account).**

A lightweight Flutter plugin for **deep linking** and **deferred deep linking** on Android and iOS — a simple, Firebase-free alternative to Dynamic Links.

---

## ✅ Features

- 🔗 Deep linking on Android & iOS (App Links & Universal Links)
- ⏳ Deferred deep linking (works even if app installed after clicking the link)
- 📈 Built-in link analytics
- 🛠 Zero additional configuration beyond platform files
- ⚙️ Integrated with `https://linkbridge.chimeratechsolutions.com`

---

## 📲 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  link_bridge: ^1.2.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Getting Started

Before using the plugin, you must create an account and get your App Key:

1. Go to [linkbridge.chimeratechsolutions.com/account](https://linkbridge.chimeratechsolutions.com/account).
2. Create a free account.
3. Add your app name.
4. Copy your **App Key**.

You will need this key when generating the DeepLink.

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
> 🔔 Replace `${your_app_name}` with your actual app name or identifier.

---

### 🍏 iOS

1. Open your project in **Xcode**.
2. Go to **Signing & Capabilities** → Add **Associated Domains**.
3. Add:

```
applinks:${your_app_name}.chimeratechsolutions.com
```

4. Edit your `Info.plist`:

```xml
<key>FlutterDeepLinkingEnabled</key>
<false/>
<key>AssociatedDomains</key>
<array>
    <string>applinks:${your_app_name}.chimeratechsolutions.com</string>
</array>
```

---

## 💻 Usage

Import the plugin:

```dart
import 'package:link_bridge/link_bridge.dart';
```

### 🔍 Initialize with your App Key

```dart
Uri? deepLink = await LinkBridge().init();
```

### 📡 Listen for deep links:

```dart
LinkBridge().listen((Uri? deepLink) async {
  print('New deep link: $deepLink');
});
```

---

## 📌 Notes

- 🧠 Works out of the box — no Firebase or 3rd-party setup needed
- 📥 Supports install → open flows (deferred links)
- 📊 Built-in lightweight analytics
- 👯 Full support for App Links (Android) and Universal Links (iOS)

---

# ⚠ Important

- You **must initialize** the plugin with a valid **App Key** for it to work.
- If no key is provided, the plugin will not handle links.
