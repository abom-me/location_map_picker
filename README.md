# location_map_picker:


### easy widget to pick a location on a map.

Made by Nasr Al-Rahbi [@abom_me](https://twitter.com/abom_me):

- Compatibility with Geolocator
- Use of Google map APIs

|             | Android | iOS    | Flutter Web |
| ----------- | ------- | ------ | ----------- |
| **Support** | SDK 20+ | iOS 9+ | Not yet         |

Location picker using the official [google_maps_flutter](https://pub.dev/packages/google_maps_flutter).



## Setup

Pubspec changes:

```
      dependencies:
        map_location_picker: ^0.0.6
```
Sample example:

```dart
import 'package:location_map_picker/location_map_picker.dart';
MapPicker(
apiKey: "YOUR_API_KEY",
onPin: (PinData? result) {
...
},
);
```

## Getting Started

- Get an API key at <https://cloud.google.com/maps-platform/>.

- And don't forget to enable the following APIs in <https://console.cloud.google.com/google/maps-apis/>

  - Maps SDK for Android
  - Maps SDK for iOS
  - Places API
  - Geocoding API
  - Maps JavaScript API

- And ensure to enable billing for the project.

For more details, see [Getting started with Google Maps Platform](https://developers.google.com/maps/gmp-get-started).

### Android

1. Set the `minSdkVersion` in `android/app/build.gradle`:

```groovy
android {
    defaultConfig {
        minSdkVersion 20
    }
}
```

This means that app will only be available for users that run Android SDK 20 or higher.

2. Specify your API key in the application manifest `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>
```

#### Hybrid Composition

To use [Hybrid Composition](https://flutter.dev/docs/development/platform-integration/platform-views)
to render the `GoogleMap` widget on Android, set `AndroidGoogleMapsFlutter.useAndroidViewSurface` to
true.

```dart
if (defaultTargetPlatform == TargetPlatform.android) {
  AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
}
```

### iOS

To set up, specify your API key in the application delegate `ios/Runner/AppDelegate.m`:

```objectivec
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"YOUR KEY HERE"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
```

Or in your swift code, specify your API key in the application delegate `ios/Runner/AppDelegate.swift`:

```swift
import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### Note

The following permissions are not required to use Google Maps Android API v2, but are recommended.

`android.permission.ACCESS_COARSE_LOCATION` Allows the API to use WiFi or mobile cell data (or both) to determine the device's location. The API returns the location with an accuracy approximately equivalent to a city block.

`android.permission.ACCESS_FINE_LOCATION` Allows the API to determine as precise a location as possible from the available location providers, including the Global Positioning System (GPS) as well as WiFi and mobile cell data.

---

You must also explicitly declare that your app uses the android.hardware.location.network or android.hardware.location.gps hardware features if your app targets Android 5.0 (API level 21) or higher and uses the ACCESS_COARSE_LOCATION or ACCESS_FINE_LOCATION permission in order to receive location updates from the network or a GPS, respectively.

```xml
<uses-feature android:name="android.hardware.location.network" android:required="false" />
<uses-feature android:name="android.hardware.location.gps" android:required="false"  />
```

---

The following permissions are defined in the package manifest, and are automatically merged into your app's manifest at build time. You **don't** need to add them explicitly to your manifest:

`android.permission.INTERNET` Used by the API to download map tiles from Google Maps servers.

`android.permission.ACCESS_NETWORK_STATE` Allows the API to check the connection status in order to determine whether data can be downloaded.


See the `example` directory for a complete sample app.


### Parameters of the pinGoogleMap

```dart
/// Here add the starting location, this location will appear directly when entering the widget
  /// You can leave it blank and it will use a default location

   LatLng? startLocation;


  /// Here, type the text that appears below before choosing a location, you can leave it blank

String? inputText;


  /// Here is the widget that will appear in the submit button
  /// You can leave it blank and it will use the default send icon

  Widget? sendBtnIcon = const Icon(Icons.send);


  ///Here is the text color of the text box, it is black by default
  Color? textInputColor;



  /// Here is the icon that appears next to the text box for the position name, at the bottom
  Widget? inputIcon;



  /// This String is required and mandatory, here  type your API key from Google Cloud
 
  final String apiKey;


  /// Here is the text that will appear in the search box at the top
  /// default phrase (Search For A Place)

   String? searchBoxHintText;


  /// Here is the language of the map and the name of the places, just type the language code
  /// For example: for Arabic (ar) for English (en)
  /// You can leave it blank and it will be in English by default
  String? mapLanguage;


  ///Here is type of the map, if it is normal, satellite, etc
  MapType? mapType;


  /// Here comes the data after selecting the location, including the name of the place and its LatLng
  final void Function(PinData pinData) onPin;

```
## Real Example:

![Video Example](https://s9.gifyu.com/images/RPReplay_Final1671293028_AdobeExpress.gif)

## 👨🏻‍💻 Follow me  :
[![Twitter](https://img.shields.io/badge/Twitter-%231DA1F2.svg?logo=Twitter&logoColor=white)](https://twitter.com/abom_me)

[![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?logo=Instagram&logoColor=white)](https://instagram.com/abom.me)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://linkedin.com/in/nasr-al-rahbi-08a573245)

[![Stack Overflow](https://img.shields.io/badge/-Stackoverflow-FE7A16?logo=stack-overflow&logoColor=white)](https://stackoverflow.com/users/19994059/nasr-al-rahbi)

