🔗 link_bridge
A lightweight Flutter plugin to handle deep linking and deferred links on Android and iOS – a simple, Firebase-free alternative to Dynamic Links.

✅ Features
🔗 Deep linking on Android & iOS (App Links & Universal Links)

⏳ Deferred deep linking (handle links even if app is installed after the click)

📈 Built-in analytics for links

🛠 Zero additional configuration required

⚙️ Works with https://linkbridge.vooomapp.com

📲 Installation
Add to your pubspec.yaml:

yaml
Copy
Edit
dependencies:
link_bridge: 1.0.4
📦 Platform Setup
🟢 Android
Edit android/app/src/main/AndroidManifest.xml:

xml
Copy
Edit
<meta-data android:name="flutter_deeplinking_enabled" android:value="false" />

<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="https"
        android:host="linkbridge.vooomapp.com"
        android:pathPrefix="/link/${your_app_name}" />
</intent-filter>
Replace ${your_app_name} with your actual app name or identifier.

🍏 iOS
Open your project in Xcode.

Under Signing & Capabilities, add Associated Domains for all build configurations (Debug, Release, and Profile).

Add the following domain:

css
Copy
Edit
applinks:linkbridge.vooomapp.com
In your Info.plist:

xml
Copy
Edit
<key>FlutterDeepLinkingEnabled</key>
<false/>
<key>AssociatedDomains</key>
<array>
<string>applinks:linkbridge.vooomapp.com</string>
</array>
💻 Dart API
Import the plugin:

dart
Copy
Edit
import 'package:link_bridge/link_bridge.dart';
🔍 Get deep link on app launch:
dart
Copy
Edit
Uri? deepLink = await LinkBridge().init();
📡 Listen for deep links in the foreground:
dart
Copy
Edit
LinkBridge().listen((Uri? deepLink) async {
print('New deep link: $deepLink');
});
📌 Notes
🧠 Works out of the box — no need for Firebase or extra setup.

📥 Handles install → open flow (deferred links).

📊 Includes analytics for tracking link usage.

👯 Fully supports App Links (Android) and Universal Links (iOS).

