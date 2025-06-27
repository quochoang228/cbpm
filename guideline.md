# Guideline: Phát triển Flutter Super App

> 📘 **Hướng dẫn chi tiết về các thành phần trong kiến trúc Flutter Super App**, bao gồm mô tả, cách triển khai, các bước thực hiện, công cụ đề xuất, và lưu ý khi sử dụng. Guideline được trình bày rõ ràng và đầy đủ, phù hợp để sử dụng làm tài liệu tham khảo cho đội phát triển.

---

## 📋 Mục lục

1. [🎯 Giới thiệu](#1-giới-thiệu)
2. [🏗️ Tổng quan kiến trúc](#2-tổng-quan-kiến-trúc)
3. [🛡️ Core App Shell](#3-core-app-shell)
4. [🧭 Dynamic Router](#4-dynamic-router)
5. [🧩 Feature Modules](#5-feature-modules)
6. [🔧 Server Driven Config](#6-server-driven-config)
7. [🚀 CI/CD + Monitoring](#7-cicd--monitoring)
8. [🔒 Kiểm thử và bảo mật](#8-kiểm-thử-và-bảo-mật)
9. [📚 Tài liệu tham khảo](#9-tài-liệu-tham-khảo)

---

## 1. Giới thiệu

Guideline này cung cấp hướng dẫn chi tiết để phát triển **Flutter Super App**, một ứng dụng đa chức năng tích hợp nhiều mini app (Wallet, RideHailing, Shopping, Chat, v.v.) trên nền tảng Flutter.

### 🎯 Mục tiêu

- **🚀 Hiệu suất cao**: Tối ưu hóa performance và tốc độ
- **📈 Khả năng mở rộng**: Dễ dàng thêm/bớt tính năng
- **🔒 Bảo mật**: Đảm bảo an toàn dữ liệu người dùng
- **🔧 Dễ bảo trì**: Cấu trúc rõ ràng, tài liệu đầy đủ

### 📐 Nguyên tắc thiết kế

- **🧩 Modularity**: Kiến trúc module hóa
- **☁️ Server-driven UI**: Giao diện điều khiển từ server
- **⚙️ CI/CD automation**: Tự động hóa quy trình phát triển

### 📚 Guideline bao gồm

- ✅ Mô tả chi tiết từng thành phần
- ✅ Hướng dẫn triển khai với mã mẫu và công cụ đề xuất
- ✅ Lưu ý để tránh lỗi phổ biến và tối ưu hóa

---

## 2. Tổng quan kiến trúc

Kiến trúc Flutter Super App gồm **5 thành phần chính**:

| Thành phần                  | Mô tả                                                            |
|-----------------------------|------------------------------------------------------------------|
| 🛡️ **Core App Shell**      | Lớp nền tảng cung cấp khởi tạo, theme, localization, và DI       |
| 🧭 **Dynamic Router**       | Hệ thống điều hướng động với deeplink và offline fallback        |
| 🧩 **Feature Modules**      | Các mô-đun độc lập (Wallet, RideHailing, Shopping, Chat)         |
| 🔧 **Server Driven Config** | Cấu hình từ server cho remote config, A/B testing, và dynamic UI |
| 🚀 **CI/CD + Monitoring**   | Quy trình phát triển, triển khai, và giám sát                    |

### 🏗️ Sơ đồ kiến trúc

```
┌──────────────────────────────────────────────────────────────┐
│                    FLUTTER SUPER APP                        │
│                                                              │
│ ┌─────────────────────┐  ┌──────────────────────────────┐    │
│ │   CORE APP SHELL    │  │      DYNAMIC ROUTER          │    │
│ │  - Lazy App Init    │  │  - Deeplink (go_router)     │    │
│ │  - Theme (cached)   │  │  - Dynamic nav config        │    │
│ │  - Localization     │  │  - Offline fallback          │    │
│ │  - Auth Module      │  └──────────────────────────────┘    │
│ │  - DI Container     │                                     │
│ │    (lazy init)      │                                     │
│ └─────────────────────┘                                     │
│            │                                               │
│            ▼                                               │
│ ┌────────────────────────────────────────────────────────┐ │
│ │                FEATURE MODULES                        │ │
│ │ ┌─────────────────┐  ┌────────────────────────────┐   │ │
│ │ │ WalletModule    │  │ RideHailingModule          │   │ │
│ │ │ - Payment SDK   │  │ - Map SDK (optimized)     │   │ │
│ │ │ - Transaction   │  │ - Real-time socket        │   │ │
│ │ │ - Feature flag  │  │ - Protocol Buffers        │   │ │
│ │ └─────────────────┘  └────────────────────────────┘   │ │
│ │ ┌─────────────────┐  ┌────────────────────────────┐   │ │
│ │ │ ShoppingModule  │  │ ChatModule                 │   │ │
│ │ │ - Product list  │  │ - WebSocket/MQTT          │   │ │
│ │ │ - Cart          │  │ - Notification             │   │ │
│ │ │ - Feature flag  │  │ - Protocol Buffers        │   │ │
│ │ └─────────────────┘  └────────────────────────────┘   │ │
│ │   ... thêm mini app (game, service...)              │ │
│ │   (Dynamic Feature Delivery)                        │ │
│ └────────────────────────────────────────────────────────┘ │
│                                                            │
│ ┌──────────────────────────────┐                           │
│ │ SERVER DRIVEN CONFIG         │                           │
│ │ - Remote config (cached)     │                           │
│ │ - A/B Test (LaunchDarkly)   │                           │
│ │ - Dynamic form/UI schema     │                           │
│ │ - JSON schema optimized      │                           │
│ │ - API versioning             │                           │
│ └──────────────────────────────┘                           │
│                                                            │
└──────────────────────────────────────────────────────────────┘

               ┌──────────────────────────────┐
               │ CI/CD + MONITORING           │
               │ - GitHub Actions (parallel)  │ 
               │ - Fastlane (optimized)      │
               │ - Firebase Crashlytics      │
               │ - Sentry + Analytics        │
               │ - Canary releases           │
               │ - Automated testing         │
               │ - App distribution          │
               └──────────────────────────────┘
```

---

## 3. Core App Shell

### 📝 Mô tả

Core App Shell là **lớp nền tảng** của ứng dụng, cung cấp:

- 🚀 **Lazy App Init**: Khởi tạo ứng dụng tối ưu, chỉ tải tài nguyên cần thiết
- 🎨 **Theme (Cached)**: Quản lý giao diện với bộ nhớ đệm cục bộ
- 🌐 **Localization**: Hỗ trợ đa ngôn ngữ
- 🔐 **Auth Module**: Xác thực người dùng, tách thành mô-đun riêng
- 📦 **DI Container (Lazy Init)**: Quản lý phụ thuộc với khởi tạo lười

### 🛠️ Cách triển khai

#### a. Lazy App Init

**🔧 Công cụ**: `flutter_background_initializer` hoặc tự viết logic

**📋 Bước triển khai**:

1. **Cài đặt package**:
   ```bash
   flutter pub add flutter_background_initializer
   ```

2. **Tạo file `app_initializer.dart`**:
   ```dart
   import 'package:flutter_background_initializer/flutter_background_initializer.dart';

   class AppInitializer {
     static Future<void> initialize() async {
       // Khởi tạo các thành phần cần thiết
       await BackgroundInitializer.initialize();
       // Ví dụ: Khởi tạo Firebase, Hive, hoặc SharedPreferences
       await Firebase.initializeApp();
       await Hive.initFlutter();
     }
   }
   ```

3. **Gọi initializer trong `main.dart`**:
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await AppInitializer.initialize();
     runApp(MyApp());
   }
   ```

#### b. Theme (Cached)

**🔧 Công cụ**: `provider` + `shared_preferences`

**📋 Bước triển khai**:

1. **Cài đặt packages**:
   ```bash
   flutter pub add provider shared_preferences
   ```

2. **Tạo `theme_provider.dart`**:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:shared_preferences/shared_preferences.dart';

   class ThemeProvider with ChangeNotifier {
     ThemeData _themeData = ThemeData.dark();
     bool _isDarkMode = true;

     ThemeProvider() {
       _loadTheme();
     }

     Future<void> _loadTheme() async {
       final prefs = await SharedPreferences.getInstance();
       _isDarkMode = prefs.getBool('darkMode') ?? true;
       _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
       notifyListeners();
     }

     void toggleTheme() async {
       _isDarkMode = !_isDarkMode;
       _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
       final prefs = await SharedPreferences.getInstance();
       await prefs.setBool('darkMode', _isDarkMode);
       notifyListeners();
     }

     ThemeData get themeData => _themeData;
   }
   ```

3. **Áp dụng trong `main.dart`**:
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await AppInitializer.initialize();
     runApp(
       MultiProvider(
         providers: [
           ChangeNotifierProvider(create: (_) => ThemeProvider()),
         ],
         child: const MyApp(),
       ),
     );
   }

   class MyApp extends StatelessWidget {
     const MyApp({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         theme: Provider.of<ThemeProvider>(context).themeData,
         home: const HomeScreen(),
       );
     }
   }
   ```

#### c. Localization

**🔧 Công cụ**: `flutter_localizations` + `intl`

**📋 Bước triển khai**:

1. **Cài đặt packages**:
   ```bash
   flutter pub add flutter_localizations intl
   ```

2. **Cấu hình `pubspec.yaml`**:
   ```yaml
   flutter:
     generate: true
   ```

3. **Tạo file `l10n.yaml`**:
   ```yaml
   arb-dir: lib/l10n
   template-arb-file: app_en.arb
   output-localization-file: app_localizations.dart
   ```

4. **Tạo file ngôn ngữ `lib/l10n/app_en.arb`**:
   ```json
   {
     "helloWorld": "Hello World",
     "@helloWorld": {
       "description": "Greeting message"
     }
   }
   ```

5. **Sử dụng trong ứng dụng**:
   ```dart
   import 'package:flutter_localizations/flutter_localizations.dart';
   import 'package:flutter_gen/gen_l10n/app_localizations.dart';

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         localizationsDelegates: AppLocalizations.localizationsDelegates,
         supportedLocales: AppLocalizations.supportedLocales,
         home: HomeScreen(),
       );
     }
   }

   class HomeScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         body: Center(
           child: Text(AppLocalizations.of(context)!.helloWorld),
         ),
       );
     }
   }
   ```

#### d. Auth Module

**🔧 Công cụ**: Firebase Auth hoặc JWT

**📋 Bước triển khai**:

1. **Cài đặt Firebase Auth**:
   ```bash
   flutter pub add firebase_auth firebase_core
   ```

2. **Tạo `lib/modules/auth/auth_service.dart`**:
   ```dart
   class AuthService {
     final FirebaseAuth _auth = FirebaseAuth.instance;

     Future<User?> signIn(String email, String password) async {
       try {
         UserCredential result = await _auth.signInWithEmailAndPassword(
           email: email,
           password: password,
         );
         return result.user;
       } catch (e) {
         throw Exception('Login failed: $e');
       }
     }

     Future<void> signOut() async {
       await _auth.signOut();
     }
   }
   ```

#### e. DI Container (Lazy Init)

**🔧 Công cụ**: `get_it`

**📋 Bước triển khai**:

1. **Cài đặt package**:
   ```bash
   flutter pub add get_it
   ```

2. **Tạo `di.dart`**:
   ```dart
   import 'package:get_it/get_it.dart';
   import 'modules/auth/auth_service.dart';

   final getIt = GetIt.instance;

   void setupDI() {
     getIt.registerLazySingleton<AuthService>(() => AuthService());
     // Đăng ký các service khác
   }
   ```

3. **Gọi trong `main.dart`**:
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await AppInitializer.initialize();
     setupDI();
     runApp(MyApp());
   }
   ```

4. **Sử dụng trong code**:
   ```dart
   final authService = getIt<AuthService>();
   await authService.signIn('user@example.com', 'password');
   ```

### ⚠️ Lưu ý

> **Các điểm quan trọng cần lưu ý**

- **🚀 Lazy App Init**: Đảm bảo chỉ khởi tạo các thành phần cần thiết trong lần đầu mở ứng dụng. Tránh tải dữ liệu nặng ngay từ đầu.

- **🎨 Theme**: Kiểm tra hiệu suất khi thay đổi theme trên thiết bị thấp cấp. Cache theme ở định dạng nhẹ (JSON).

- **🌐 Localization**: Tạo quy trình tự động để đồng bộ file `.arb` với dịch vụ dịch thuật (Crowdin).

- **🔐 Auth Module**: Mã hóa dữ liệu nhạy cảm trước khi lưu trữ cục bộ. Sử dụng `flutter_secure_storage`.

- **📦 DI Container**: Tránh đăng ký quá nhiều singleton để giảm bộ nhớ. Kiểm tra memory leak.

---

## 4. Dynamic Router

### 📝 Mô tả

Dynamic Router quản lý **điều hướng động**, hỗ trợ:

- 🔗 **Deeplink**: Mở màn hình cụ thể từ URL hoặc thông báo
- ⚙️ **Dynamic Nav Config**: Cấu hình điều hướng từ server
- 📶 **Offline Fallback**: Dự phòng khi mất kết nối

### 🛠️ Cách triển khai

#### a. Deeplink (go_router)

**🔧 Công cụ**: `go_router`

**📋 Bước triển khai**:

1. **Cài đặt package**:
   ```bash
   flutter pub add go_router
   ```

2. **Tạo `router.dart`**:
   ```dart
   import 'package:go_router/go_router.dart';
   import 'screens/home_screen.dart';
   import 'screens/wallet_screen.dart';

   final router = GoRouter(
     routes: [
       GoRoute(
         path: '/',
         builder: (context, state) => HomeScreen(),
       ),
       GoRoute(
         path: '/wallet',
         builder: (context, state) => WalletScreen(),
       ),
     ],
     initialLocation: '/',
   );
   ```

3. **Áp dụng trong `main.dart`**:
   ```dart
   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp.router(
         routerConfig: router,
         theme: Provider.of<ThemeProvider>(context).themeData,
         localizationsDelegates: AppLocalizations.localizationsDelegates,
         supportedLocales: AppLocalizations.supportedLocales,
       );
     }
   }
   ```

4. **Xử lý deeplink**:
   ```dart
   router.addRoute(
     GoRoute(
       path: '/product/:id',
       builder: (context, state) => ProductScreen(id: state.params['id']!),
     ),
   );
   ```

#### b. Dynamic Nav Config

**🔧 Công cụ**: Firebase Remote Config

**📋 Bước triển khai**:

1. **Cài đặt Firebase Remote Config**:
   ```bash
   flutter pub add firebase_remote_config
   ```

2. **Tạo `nav_config_service.dart`**:
   ```dart
   import 'package:firebase_remote_config/firebase_remote_config.dart';

   class NavConfigService {
     final remoteConfig = FirebaseRemoteConfig.instance;

     Future<void> init() async {
       await remoteConfig.setConfigSettings(
         RemoteConfigSettings(
           fetchTimeout: Duration(minutes: 1),
           minimumFetchInterval: Duration(hours: 1),
         ),
       );
       await remoteConfig.fetchAndActivate();
     }

     String getNavConfig() {
       return remoteConfig.getString('nav_config');
     }
   }
   ```

3. **Cập nhật router dựa trên config**:
   ```dart
   final navConfig = getIt<NavConfigService>().getNavConfig();
   if (navConfig.contains('new_route')) {
     router.addRoute(
       GoRoute(
         path: '/new_route',
         builder: (context, state) => NewScreen(),
       ),
     );
   }
   ```

#### c. Offline Fallback

**🔧 Công cụ**: `shared_preferences` hoặc `hive`

**📋 Bước triển khai**:

1. **Lưu cấu hình cục bộ**:
   ```dart
   import 'package:shared_preferences/shared_preferences.dart';

   class NavConfigCache {
     static const _navConfigKey = 'nav_config';

     Future<void> saveNavConfig(String config) async {
       final prefs = await SharedPreferences.getInstance();
       await prefs.setString(_navConfigKey, config);
     }

     Future<String?> getNavConfig() async {
       final prefs = await SharedPreferences.getInstance();
       return prefs.getString(_navConfigKey);
     }
   }
   ```

2. **Sử dụng fallback**:
   ```dart
   String navConfig = await getIt<NavConfigService>().getNavConfig();
   if (navConfig.isEmpty) {
     navConfig = (await NavConfigCache().getNavConfig()) ?? defaultNavConfig;
   }
   ```

### ⚠️ Lưu ý

- **🔗 Deeplink**: Kiểm tra deeplink trên cả iOS và Android, đảm bảo xử lý lỗi khi URL không hợp lệ.

- **⚙️ Dynamic Nav Config**: Giới hạn số lượng route động để tránh làm chậm router. Cache config cục bộ.

- **📶 Offline Fallback**: Kiểm tra định kỳ tính hợp lệ của config cục bộ để tránh sử dụng dữ liệu cũ.

---

## 5. Feature Modules

### 📝 Mô tả

Feature Modules là các **mô-đun độc lập** (Wallet, RideHailing, Shopping, Chat), hỗ trợ:

- 📦 **Dynamic Feature Delivery**: Tải mô-đun theo nhu cầu
- 🎛️ **Feature Flag**: Bật/tắt tính năng
- ⚡ **Protocol Buffers**: Tối ưu hóa truyền dữ liệu
- 🗺️ **Optimized Map SDK**: Tăng hiệu suất bản đồ
- 🔌 **API Contract**: Giao tiếp rõ ràng giữa các mô-đun

### 🛠️ Cách triển khai

#### a. Dynamic Feature Delivery

**🔧 Công cụ**: Play Feature Delivery (Android)

**📋 Bước triển khai**:

1. **Cấu hình `build.gradle`**:
   ```groovy
   android {
     dynamicFeatures = [":wallet", ":ride_hailing"]
   }
   ```

2. **Tạo module động**:
   ```bash
   flutter create --template=module wallet
   ```

3. **Tải module động**:
   ```dart
   import 'package:play_feature_delivery/play_feature_delivery.dart';

   void loadWalletModule() async {
     final playFeatureDelivery = PlayFeatureDelivery();
     await playFeatureDelivery.installModule('wallet');
     // Chuyển đến màn hình Wallet
     router.go('/wallet');
   }
   ```

#### b. Feature Flag

**🔧 Công cụ**: LaunchDarkly hoặc Firebase Remote Config

**📋 Bước triển khai**:

1. **Cài đặt LaunchDarkly**:
   ```bash
   flutter pub add launchdarkly_flutter
   ```

2. **Tạo `feature_flag_service.dart`**:
   ```dart
   import 'package:launchdarkly_flutter/launchdarkly_flutter.dart';

   class FeatureFlagService {
     final LaunchDarklyClient _client = LaunchDarklyClient();

     Future<void> init() async {
       await _client.init('your-sdk-key', 'user-id');
     }

     Future<bool> isFeatureEnabled(String key) async {
       return await _client.boolVariation(key, false);
     }
   }
   ```

3. **Sử dụng trong mô-đun**:
   ```dart
   if (await getIt<FeatureFlagService>().isFeatureEnabled('wallet_payment')) {
     // Hiển thị tính năng thanh toán
   }
   ```

#### c. Protocol Buffers

**🔧 Công cụ**: `protobuf` và `grpc`

**📋 Bước triển khai**:

1. **Cài đặt protoc và plugin**:
   ```bash
   dart pub global activate protoc_plugin
   ```

2. **Tạo file `.proto`** (ví dụ: `message.proto`):
   ```proto
   syntax = "proto3";
   message ChatMessage {
     string id = 1;
     string content = 2;
     int64 timestamp = 3;
   }
   ```

3. **Sinh mã Dart**:
   ```bash
   protoc --dart_out=lib/generated message.proto
   ```

4. **Sử dụng trong ChatModule**:
   ```dart
   import 'generated/message.pb.dart';

   void sendMessage(String content) {
     final message = ChatMessage()
       ..id = Uuid().v4()
       ..content = content
       ..timestamp = DateTime.now().millisecondsSinceEpoch;
     // Gửi qua WebSocket
   }
   ```

#### d. Optimized Map SDK

**🔧 Công cụ**: Google Maps hoặc Mapbox + Isolate

**📋 Bước triển khai**:

1. **Cài đặt Mapbox**:
   ```bash
   flutter pub add mapbox_gl
   ```

2. **Tạo `map_service.dart`**:
   ```dart
   import 'package:mapbox_gl/mapbox_gl.dart';
   import 'dart:isolate';

   class MapService {
     Future<void> renderMap() async {
       final receivePort = ReceivePort();
       await Isolate.spawn(_renderMapIsolate, receivePort.sendPort);
       // Xử lý kết quả từ Isolate
     }

     static void _renderMapIsolate(SendPort sendPort) {
       // Logic render bản đồ
       sendPort.send('Map rendered');
     }
   }
   ```

3. **Sử dụng trong RideHailingModule**:
   ```dart
   final mapService = getIt<MapService>();
   await mapService.renderMap();
   ```

#### e. API Contract

**🔧 Công cụ**: OpenAPI hoặc Dart interfaces

**📋 Bước triển khai**:

1. **Tạo interface cho WalletModule**:
   ```dart
   abstract class WalletService {
     Future<void> makePayment(double amount, String currency);
     Future<List<Transaction>> getTransactions();
   }
   ```

2. **Triển khai trong `wallet_service_impl.dart`**:
   ```dart
   class WalletServiceImpl implements WalletService {
     @override
     Future<void> makePayment(double amount, String currency) async {
       // Gọi Payment SDK
     }

     @override
     Future<List<Transaction>> getTransactions() async {
       // Trả về danh sách giao dịch
       return [];
     }
   }
   ```

3. **Đăng ký trong DI**:
   ```dart
   getIt.registerLazySingleton<WalletService>(() => WalletServiceImpl());
   ```

### ⚠️ Lưu ý

- **📦 Dynamic Feature Delivery**: Kiểm tra tính tương thích trên các phiên bản Android khác nhau. Cung cấp giao diện dự phòng.

- **🎛️ Feature Flag**: Giới hạn số lượng flag để tránh phức tạp. Tạo dashboard để quản lý flag.

- **⚡ Protocol Buffers**: Đảm bảo server và client sử dụng cùng phiên bản `.proto`. Kiểm tra hiệu suất với dữ liệu lớn.

- **🗺️ Map SDK**: Tối ưu hóa tài nguyên (RAM, CPU) trên thiết bị thấp cấp. Cache dữ liệu bản đồ cục bộ.

- **🔌 API Contract**: Tài liệu hóa rõ ràng các interface, sử dụng Swagger nếu tích hợp với API server.

---

## 6. Server Driven Config

### 📝 Mô tả

Server Driven Config cung cấp:

- 💾 **Cached Remote Config**: Cấu hình từ xa với bộ nhớ đệm
- 🧪 **A/B Testing (LaunchDarkly)**: Thử nghiệm tính năng
- 🎯 **Optimized JSON Schema**: Tạo giao diện động
- 📈 **API Versioning**: Đảm bảo tương thích ngược

### 🛠️ Cách triển khai

#### a. Cached Remote Config

**🔧 Công cụ**: Firebase Remote Config

**📋 Bước triển khai**:

1. **Cài đặt package**:
   ```bash
   flutter pub add firebase_remote_config
   ```

2. **Tạo `remote_config_service.dart`**:
   ```dart
   import 'package:firebase_remote_config/firebase_remote_config.dart';
   import 'package:shared_preferences/shared_preferences.dart';

   class RemoteConfigService {
     final remoteConfig = FirebaseRemoteConfig.instance;
     final cache = RemoteConfigCache();

     Future<void> init() async {
       await remoteConfig.setConfigSettings(
         RemoteConfigSettings(
           fetchTimeout: Duration(minutes: 1),
           minimumFetchInterval: Duration(hours: 1),
         ),
       );
       await remoteConfig.fetchAndActivate();
       await cache.saveConfig(remoteConfig.getAll());
     }

     String getConfig(String key) {
       final cachedValue = cache.getConfig(key);
       return cachedValue ?? remoteConfig.getString(key);
     }
   }

   class RemoteConfigCache {
     Future<void> saveConfig(Map<String, RemoteConfigValue> config) async {
       final prefs = await SharedPreferences.getInstance();
       for (var entry in config.entries) {
         await prefs.setString(entry.key, entry.value.asString());
       }
     }

     String? getConfig(String key) async {
       final prefs = await SharedPreferences.getInstance();
       return prefs.getString(key);
     }
   }
   ```

#### b. A/B Testing (LaunchDarkly)

**🔧 Công cụ**: LaunchDarkly

**📋 Bước triển khai**:

1. **Cài đặt package**:
   ```bash
   flutter pub add launchdarkly_flutter
   ```

2. **Tích hợp trong `feature_flag_service.dart`** (đã đề cập ở Feature Modules).

#### c. Optimized JSON Schema

**🔧 Công cụ**: `json_serializable`

**📋 Bước triển khai**:

1. **Cài đặt package**:
   ```bash
   flutter pub add json_serializable json_annotation
   flutter pub add --dev build_runner
   ```

2. **Tạo schema** (`form_schema.dart`):
   ```dart
   import 'package:json_annotation/json_annotation.dart';

   part 'form_schema.g.dart';

   @JsonSerializable()
   class FormSchema {
     final String id;
     final List<FormField> fields;

     FormSchema({required this.id, required this.fields});

     factory FormSchema.fromJson(Map<String, dynamic> json) =>
         _$FormSchemaFromJson(json);
   }

   @JsonSerializable()
   class FormField {
     final String type;
     final String label;

     FormField({required this.type, required this.label});

     factory FormField.fromJson(Map<String, dynamic> json) =>
         _$FormFieldFromJson(json);
   }
   ```

3. **Generate code**:
   ```bash
   dart run build_runner build
   ```

4. **Sử dụng trong UI**:
   ```dart
   final schema = FormSchema.fromJson(
     jsonDecode(remoteConfig.getString('form_schema'))
   );
   // Tạo form động dựa trên schema
   ```

#### d. API Versioning

**🔧 Công cụ**: `dio`

**📋 Bước triển khai**:

1. **Cài đặt Dio**:
   ```bash
   flutter pub add dio
   ```

2. **Tạo `api_client.dart`**:
   ```dart
   import 'package:dio/dio.dart';

   class ApiClient {
     final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.example.com/v1'));

     Future<Response> get(String path) async {
       return await _dio.get(path);
     }
   }
   ```

3. **Xử lý versioning**:
   ```dart
   if (response.statusCode == 426) {
     // Chuyển sang v2
     _dio.options.baseUrl = _dio.options.baseUrl.replaceFirst('/v1', '/v2');
     return await get(path);
   }
   ```

### ⚠️ Lưu ý

- **💾 Cached Remote Config**: Đặt `minimumFetchInterval` hợp lý để cân bằng giữa tính mới và hiệu suất.

- **🧪 A/B Testing**: Theo dõi hiệu quả thử nghiệm qua dashboard LaunchDarkly. Đảm bảo nhóm thử nghiệm đủ lớn.

- **🎯 Optimized JSON Schema**: Kiểm tra hiệu suất khi schema phức tạp. Cache schema cục bộ để hỗ trợ offline.

- **📈 API Versioning**: Tài liệu hóa các phiên bản API. Tạo kế hoạch thông báo khi ngừng hỗ trợ phiên bản cũ.

---

## 7. CI/CD + Monitoring

### 📝 Mô tả

CI/CD và Monitoring cung cấp:

- 🔄 **Parallel Jobs (GitHub Actions)**: Tự động hóa build và triển khai
- 🐤 **Canary Releases**: Phát hành thử nghiệm
- 🧪 **Automated Testing**: Unit, widget, và integration test
- 📊 **Sentry + Analytics**: Theo dõi lỗi và hành vi người dùng

### 🛠️ Cách triển khai

#### a. Parallel Jobs trong GitHub Actions

**🔧 Công cụ**: GitHub Actions, Fastlane

**📋 Bước triển khai**:

1. **Tạo file `.github/workflows/ci.yml`**:
   ```yaml
   name: CI/CD
   on:
     push:
       branches: [main]

   jobs:
     test:
       runs-on: ubuntu-latest
       steps:
       - uses: actions/checkout@v3
       - name: Setup Flutter
         uses: subosito/flutter-action@v2
         with:
           flutter-version: '3.x'
       - run: flutter test

     build-android:
       runs-on: ubuntu-latest
       steps:
       - uses: actions/checkout@v3
       - uses: subosito/flutter-action@v2
       - run: flutter build apk --release
       - name: Upload artifact
         uses: actions/upload-artifact@v3
         with:
           name: apk
           path: build/app/outputs/flutter-apk/app-release.apk
   ```

2. **Tối ưu hóa Fastlane (Android)**:
   ```ruby
   # fastlane/Fastfile
   lane :beta do
     gradle(task: 'assembleRelease')
     upload_to_play_store(track: 'beta')
   end
   ```

#### b. Canary Releases

**🔧 Công cụ**: Firebase App Distribution

**📋 Bước triển khai**:

1. **Cài đặt Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Cấu hình Firebase App Distribution**:
   ```bash
   firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk --groups "beta-testers"
   ```

#### c. Automated Testing

**🔧 Công cụ**: `flutter_test`, `mockito`

**📋 Bước triển khai**:

1. **Cài đặt packages**:
   ```bash
   flutter pub add --dev flutter_test mockito
   ```

2. **Tạo unit test** (`test/auth_service_test.dart`):
   ```dart
   import 'package:mockito/mockito.dart';
   import 'package:test/test.dart';

   class MockFirebaseAuth extends Mock implements FirebaseAuth {}

   void main() {
     test('Auth Service Test', () {
       final mockAuth = MockFirebaseAuth();
       final authService = AuthService(mockAuth);
       // Test logic
       expect(authService.signIn('test', 'pass'), completes);
     });
   }
   ```

3. **Chạy test**:
   ```bash
   flutter test
   ```

#### d. Sentry + Analytics

**🔧 Công cụ**: Sentry, Firebase Analytics

**📋 Bước triển khai**:

1. **Cài đặt Sentry**:
   ```bash
   flutter pub add sentry_flutter
   ```

2. **Khởi tạo Sentry**:
   ```dart
   import 'package:sentry_flutter/sentry_flutter.dart';

   void main() async {
     await SentryFlutter.init(
       (options) => options.dsn = 'your-sentry-dsn',
       appRunner: () => runApp(MyApp()),
     );
   }
   ```

3. **Cài đặt Firebase Analytics**:
   ```bash
   flutter pub add firebase_analytics
   ```

4. **Gửi sự kiện**:
   ```dart
   import 'package:firebase_analytics/firebase_analytics.dart';

   final analytics = FirebaseAnalytics.instance;
   await analytics.logEvent(
     name: 'screen_view', 
     parameters: {'screen_name': 'Home'}
   );
   ```

### ⚠️ Lưu ý

- **🔄 Parallel Jobs**: Tối ưu hóa thời gian chạy bằng cách sử dụng caching (ví dụ: cache Flutter SDK).

- **🐤 Canary Releases**: Theo dõi phản hồi từ nhóm thử nghiệm trước khi mở rộng. Đặt ngưỡng lỗi tối đa.

- **🧪 Automated Testing**: Đặt mục tiêu độ phủ kiểm thử > 90%. Sử dụng CI để chạy test tự động.

- **📊 Sentry + Analytics**: Thiết lập cảnh báo tự động cho lỗi nghiêm trọng. Phân tích dữ liệu analytics để tối ưu hóa tính năng.

---

## 8. Kiểm thử và bảo mật

### 🧪 Kiểm thử

#### Các loại kiểm thử

| Loại test | Mô tả | Ví dụ |
|-----------|-------|-------|
| **Unit Test** | Kiểm tra logic của từng lớp | AuthService, WalletService |
| **Widget Test** | Kiểm tra giao diện Flutter | HomeScreen, FormScreen |
| **Integration Test** | Kiểm tra luồng người dùng hoàn chỉnh | đăng nhập → xem ví |

**🔧 Công cụ**: `flutter_test`, `mockito`, `integration_test`

**📋 Bước triển khai**:

1. **Tạo integration test** trong thư mục `integration_test`:
   ```dart
   import 'package:integration_test/integration_test.dart';

   void main() {
     IntegrationTestWidgetsFlutterBinding.ensureInitialized();

     testWidgets('Login flow test', (tester) async {
       await tester.pumpWidget(MyApp());
       // Test logic
       await tester.tap(find.text('Login'));
       await tester.pumpAndSettle();
     });
   }
   ```

2. **Chạy test**:
   ```bash
   flutter test integration_test
   ```

### 🔒 Bảo mật

#### Các biện pháp bảo mật

- **🔐 Mã hóa dữ liệu**: Sử dụng `flutter_secure_storage` để lưu token, thông tin nhạy cảm
- **🛡️ Bảo vệ API**: Sử dụng HTTPS, OAuth2, và API Key
- **🔍 Kiểm tra bảo mật**: Sử dụng OWASP ZAP hoặc MobSF để kiểm tra lỗ hổng

**📋 Ví dụ mã hóa dữ liệu**:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
await storage.write(key: 'token', value: 'jwt_token');
```

### ⚠️ Lưu ý

- 📅 Định kỳ kiểm tra bảo mật, đặc biệt khi tích hợp SDK mới
- 📊 Thiết lập monitoring để phát hiện các hoạt động bất thường
- 🔄 Cập nhật thường xuyên các dependency để vá lỗ hổng bảo mật

---

## 9. Tài liệu tham khảo

### 📚 Tài liệu chính thức

| Công nghệ | Link |
|-----------|------|
| **Flutter** | [https://flutter.dev/docs](https://flutter.dev/docs) |
| **Firebase** | [https://firebase.google.com/docs](https://firebase.google.com/docs) |
| **GoRouter** | [https://pub.dev/packages/go_router](https://pub.dev/packages/go_router) |
| **LaunchDarkly** | [https://docs.launchdarkly.com](https://docs.launchdarkly.com) |
| **Sentry** | [https://sentry.io/for/flutter](https://sentry.io/for/flutter) |
| **Protocol Buffers** | [https://developers.google.com/protocol-buffers](https://developers.google.com/protocol-buffers) |
| **Mapbox** | [https://docs.mapbox.com/mapbox-gl-js/api](https://docs.mapbox.com/mapbox-gl-js/api) |

### 🎯 Best Practices

- 📖 **Code Review**: Luôn review code trước khi merge
- 📝 **Documentation**: Tài liệu hóa đầy đủ API và architecture
- 🚀 **Performance**: Monitoring và tối ưu hóa thường xuyên
- 🔒 **Security**: Kiểm tra bảo mật định kỳ
- 🧪 **Testing**: Maintain test coverage > 90%

---

## 🎉 Kết luận

Guideline này cung cấp **hướng dẫn chi tiết** để phát triển Flutter Super App với kiến trúc tối ưu. Mỗi thành phần được triển khai với các công cụ hiện đại, kèm theo mã mẫu và lưu ý để tránh lỗi phổ biến.

### 🚀 Bước tiếp theo

1. **📋 Thiết lập môi trường phát triển** theo guideline
2. **🏗️ Triển khai từng module** một cách tuần tự  
3. **🧪 Viết test** cho từng thành phần
4. **📊 Thiết lập monitoring** và analytics
5. **🔄 Tối ưu hóa** dựa trên feedback và metrics

> 💡 **Tip**: Bắt đầu với Core App Shell, sau đó mở rộng dần các Feature Modules.

---

**📞 Hỗ trợ**: Nếu bạn cần hỗ trợ thêm về việc triển khai hoặc giải thích sâu hơn về một phần cụ thể, hãy liên hệ với team phát triển.
