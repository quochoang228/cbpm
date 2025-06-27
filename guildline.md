# CBPM Application - Development Guidelines

## Tổng quan kiến trúc

### Cấu trúc dự án
```
cbpm/
├── lib/                    # Main application
├── packages/               # Feature modules
│   ├── wo/                # Work Order module
│   ├── contract/          # Contract management module
│   └── ds/                # Design System
└── guildline.md           # Development guidelines
```

### Tech Stack
- **Framework**: Flutter
- **State Management**: Riverpod (HooksRiverpod)
- **Dependency Injection**: GetIt
- **Navigation**: GoRouter
- **HTTP Client**: Dio
- **Form Management**: FormBuilder

## Kiến trúc Module

### Cấu trúc Package
Mỗi feature module có cấu trúc standardized:
```
packages/[module_name]/
├── lib/
│   ├── entities/          # Data models & DTOs
│   ├── page/             # UI Pages
│   ├── provider/         # Riverpod providers
│   ├── repository/       # Data repositories
│   ├── widget/           # Reusable widgets
│   ├── router/           # Navigation paths
│   └── utils/            # Utilities & helpers
├── pubspec.yaml
└── README.md
```

### State Management Pattern
Sử dụng Riverpod với LoadState pattern:

```dart
@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  @override
  LoadState<List<FeatureModel>> build() {
    return const LoadState.notLoaded();
  }
  
  Future<void> loadData() async {
    state = const LoadState.loading();
    
    final result = await repository.getData();
    result.when(
      success: (data) => state = LoadState.fetched(data),
      failure: (error) => state = LoadState.failed(error),
    );
  }
}
```

### LoadState States
- `notLoaded`: Chưa load data
- `loading`: Đang load data
- `fetched`: Load thành công
- `failed`: Load thất bại
- `noData`: Không có data

## Hướng dẫn thêm Feature mới

### Bước 1: Tạo Package Structure
```bash
mkdir packages/new_feature
mkdir packages/new_feature/lib
mkdir packages/new_feature/lib/{entities,page,provider,repository,widget,router,utils}
```

### Bước 2: Setup pubspec.yaml
```yaml
name: new_feature
dependencies:
  flutter:
    sdk: flutter
  ds:
    path: ../ds
  hooks_riverpod: ^2.4.0
  go_router: ^10.0.0
```

### Bước 3: Định nghĩa Routes
```dart
// packages/new_feature/lib/router/paths.dart
class Paths {
  static const String featureList = '/feature-list';
  static const String featureDetail = '/feature-detail/:id';
  static const String featureCreate = '/feature-create';
}
```

### Bước 4: Tạo Entity/Model
```dart
// packages/new_feature/lib/entities/feature_model.dart
class FeatureModel {
  final int? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  
  const FeatureModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
  });
  
  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['created_at'] != null 
        ? DateTime.parse(json['created_at']) 
        : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
```

### Bước 5: Tạo Repository Interface
```dart
// packages/new_feature/lib/repository/feature_repository.dart
abstract class IFeatureRepository {
  Future<ApiResult<List<FeatureModel>>> getFeatures({
    int? page,
    int? limit,
    String? search,
  });
  
  Future<ApiResult<FeatureModel>> getFeatureById(int id);
  Future<ApiResult<FeatureModel>> createFeature(FeatureModel feature);
  Future<ApiResult<FeatureModel>> updateFeature(int id, FeatureModel feature);
  Future<ApiResult<void>> deleteFeature(int id);
}

class FeatureRepositoryImpl implements IFeatureRepository {
  final Dio _dio = Dependencies().getIt<Dio>();
  
  @override
  Future<ApiResult<List<FeatureModel>>> getFeatures({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      final response = await _dio.get('/features', queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
      });
      
      final List<FeatureModel> features = (response.data['data'] as List)
          .map((json) => FeatureModel.fromJson(json))
          .toList();
          
      return ApiResult.success(features);
    } catch (e) {
      return ApiResult.failure(ApiError.fromException(e));
    }
  }
  
  // Implement other methods...
}
```

### Bước 6: Tạo Provider
```dart
// packages/new_feature/lib/provider/feature_provider.dart
@riverpod
class FeatureListNotifier extends _$FeatureListNotifier {
  @override
  LoadState<List<FeatureModel>> build() {
    return const LoadState.notLoaded();
  }
  
  Future<void> loadFeatures({
    int? page,
    String? search,
  }) async {
    state = const LoadState.loading();
    
    final result = await Dependencies()
        .getIt<IFeatureRepository>()
        .getFeatures(page: page, search: search);
        
    result.when(
      success: (features) {
        if (features.isEmpty) {
          state = const LoadState.noData();
        } else {
          state = LoadState.fetched(features);
        }
      },
      failure: (error) {
        state = LoadState.failed(error);
        showToast(error.message ?? 'Có lỗi xảy ra');
      },
    );
  }
  
  Future<void> refreshFeatures() async {
    await loadFeatures();
  }
  
  Future<void> searchFeatures(String query) async {
    await loadFeatures(search: query);
  }
}

@riverpod
class FeatureDetailNotifier extends _$FeatureDetailNotifier {
  @override
  LoadState<FeatureModel> build(int id) {
    return const LoadState.notLoaded();
  }
  
  Future<void> loadFeatureDetail() async {
    state = const LoadState.loading();
    
    final result = await Dependencies()
        .getIt<IFeatureRepository>()
        .getFeatureById(id);
        
    result.when(
      success: (feature) {
        state = LoadState.fetched(feature);
      },
      failure: (error) {
        state = LoadState.failed(error);
      },
    );
  }
}
```

### Bước 7: Tạo UI Pages
```dart
// packages/new_feature/lib/page/feature_list_page.dart
class FeatureListPage extends HookConsumerWidget {
  const FeatureListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    
    useEffect(() {
      ref.read(featureListProvider.notifier).loadFeatures();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách Feature',
          style: DSTextStyle.headlineLarge.semiBold(),
        ),
        backgroundColor: DSColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(Paths.featureCreate),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) {
                ref.read(featureListProvider.notifier)
                    .searchFeatures(value);
              },
            ),
          ),
          
          // Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.read(featureListProvider.notifier)
                  .refreshFeatures(),
              child: ref.watch(featureListProvider).match(
                notLoaded: (_) => const SizedBox(),
                loading: (_) => const ListLoading(),
                noData: (_) => const BaseEmptyState(
                  title: 'Không có dữ liệu',
                  subtitle: 'Chưa có feature nào được tạo',
                ),
                failed: (error) => BaseEmptyState(
                  title: 'Có lỗi xảy ra',
                  subtitle: error.error.message ?? '',
                  onRetry: () => ref.read(featureListProvider.notifier)
                      .loadFeatures(),
                ),
                fetched: (data) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    final feature = data.data[index];
                    return FeatureCard(
                      feature: feature,
                      onTap: () => context.push(
                        Paths.featureDetail.replaceAll(':id', '${feature.id}'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### Bước 8: Tạo Reusable Widgets
```dart
// packages/new_feature/lib/widget/feature_card.dart
class FeatureCard extends StatelessWidget {
  final FeatureModel feature;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const FeatureCard({
    super.key,
    required this.feature,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      feature.name ?? '',
                      style: DSTextStyle.headlineSmall.semiBold(),
                    ),
                  ),
                  _buildStatusChip(),
                  if (onEdit != null || onDelete != null)
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit' && onEdit != null) onEdit!();
                        if (value == 'delete' && onDelete != null) onDelete!();
                      },
                      itemBuilder: (context) => [
                        if (onEdit != null)
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Chỉnh sửa'),
                          ),
                        if (onDelete != null)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Xóa'),
                          ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (feature.createdAt != null)
                Text(
                  'Tạo lúc: ${DateFormat('dd/MM/yyyy HH:mm').format(feature.createdAt!)}',
                  style: DSTextStyle.bodySmall.copyWith(
                    color: DSColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatusChip() {
    Color backgroundColor;
    Color textColor;
    
    switch (feature.status?.toLowerCase()) {
      case 'active':
        backgroundColor = DSColors.success;
        textColor = DSColors.white;
        break;
      case 'inactive':
        backgroundColor = DSColors.error;
        textColor = DSColors.white;
        break;
      default:
        backgroundColor = DSColors.warning;
        textColor = DSColors.black;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        feature.status ?? 'Unknown',
        style: DSTextStyle.bodySmall.copyWith(color: textColor),
      ),
    );
  }
}
```

### Bước 9: Form Management
```dart
// packages/new_feature/lib/page/feature_form_page.dart
class FeatureFormPage extends HookConsumerWidget {
  final FeatureModel? feature; // null for create, not null for edit
  
  const FeatureFormPage({super.key, this.feature});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          feature == null ? 'Tạo Feature' : 'Chỉnh sửa Feature',
          style: DSTextStyle.headlineLarge.semiBold(),
        ),
        backgroundColor: DSColors.primary,
      ),
      body: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                initialValue: feature?.name,
                decoration: const InputDecoration(
                  labelText: 'Tên Feature *',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Vui lòng nhập tên'),
                  FormBuilderValidators.minLength(3, errorText: 'Tên phải có ít nhất 3 ký tự'),
                ]),
              ),
              const SizedBox(height: 16),
              
              FormBuilderDropdown<String>(
                name: 'status',
                initialValue: feature?.status ?? 'active',
                decoration: const InputDecoration(
                  labelText: 'Trạng thái *',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'active', child: Text('Hoạt động')),
                  DropdownMenuItem(value: 'inactive', child: Text('Không hoạt động')),
                ],
                validator: FormBuilderValidators.required(
                  errorText: 'Vui lòng chọn trạng thái'
                ),
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                child: DSButton(
                  label: feature == null ? 'Tạo' : 'Cập nhật',
                  isLoading: isLoading.value,
                  onPressed: () => _handleSubmit(
                    context, 
                    ref, 
                    formKey, 
                    isLoading,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormBuilderState> formKey,
    ValueNotifier<bool> isLoading,
  ) async {
    if (!formKey.currentState!.saveAndValidate()) return;
    
    final values = formKey.currentState!.value;
    isLoading.value = true;
    
    try {
      final newFeature = FeatureModel(
        id: feature?.id,
        name: values['name'],
        status: values['status'],
      );
      
      final repository = Dependencies().getIt<IFeatureRepository>();
      final result = feature == null
          ? await repository.createFeature(newFeature)
          : await repository.updateFeature(feature!.id!, newFeature);
      
      result.when(
        success: (_) {
          showToast('${feature == null ? 'Tạo' : 'Cập nhật'} thành công');
          context.pop();
          // Refresh list
          ref.invalidate(featureListProvider);
        },
        failure: (error) {
          showToast(error.message ?? 'Có lỗi xảy ra');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
```

### Bước 10: Register Dependencies
```dart
// lib/core/dependencies.dart hoặc main.dart
void setupDependencies() {
  final getIt = GetIt.instance;
  
  // Register repository
  getIt.registerLazySingleton<IFeatureRepository>(
    () => FeatureRepositoryImpl(),
  );
}
```

### Bước 11: Update Navigation
```dart
// lib/router/app_router.dart
GoRoute(
  path: '/feature-list',
  builder: (context, state) => const FeatureListPage(),
),
GoRoute(
  path: '/feature-detail/:id',
  builder: (context, state) {
    final id = int.parse(state.pathParameters['id']!);
    return FeatureDetailPage(id: id);
  },
),
GoRoute(
  path: '/feature-create',
  builder: (context, state) => const FeatureFormPage(),
),
```

## Best Practices

### 1. Error Handling
```dart
// Luôn handle error trong provider
result.when(
  success: (data) {
    state = LoadState.fetched(data);
  },
  failure: (error) {
    state = LoadState.failed(error);
    showToast(error.message ?? 'Có lỗi xảy ra');
  },
);
```

### 2. Loading States
```dart
// Hiển thị loading khi cần
if (isLoading) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const LoadingDialog(),
  );
}
```

### 3. Form Validation
```dart
// Sử dụng FormBuilder với validator
FormBuilderTextField(
  name: 'email',
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Vui lòng nhập email'),
    FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
  ]),
)
```

### 4. Design System Usage
```dart
// Luôn sử dụng components từ DS package
DSButton(label: 'Submit', onPressed: () {}),
Text('Title', style: DSTextStyle.headlineLarge.semiBold()),
Container(color: DSColors.primary),
```

### 5. Navigation Best Practices
```dart
// Push với data
context.push('/detail', extra: {'id': 123});

// Replace current route
context.pushReplacement('/login');

// Go back
context.pop(result);
```

### 6. File Upload Pattern
```dart
// Sử dụng CustomMultiFilePicker
final files = await showModalBottomSheet<List<PlatformFile>?>(
  context: context,
  builder: (_) => const CustomMultiFilePicker(),
);
```

### 7. Pagination Pattern
```dart
@riverpod
class PaginatedListNotifier extends _$PaginatedListNotifier {
  int _currentPage = 1;
  List<ItemModel> _allItems = [];
  
  @override
  LoadState<List<ItemModel>> build() {
    return const LoadState.notLoaded();
  }
  
  Future<void> loadPage({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _allItems.clear();
    }
    
    // Load data for current page
    final result = await repository.getItems(page: _currentPage);
    
    result.when(
      success: (newItems) {
        _allItems.addAll(newItems);
        _currentPage++;
        state = LoadState.fetched(_allItems);
      },
      failure: (error) {
        state = LoadState.failed(error);
      },
    );
  }
}
```

## Code Style & Conventions

### 1. Naming Conventions
- **Classes**: PascalCase (e.g., `FeatureModel`, `FeatureRepository`)
- **Files**: snake_case (e.g., `feature_model.dart`, `feature_repository.dart`)
- **Variables**: camelCase (e.g., `featureList`, `isLoading`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `API_BASE_URL`)

### 2. Import Order
```dart
// 1. Dart imports
import 'dart:async';
import 'dart:io';

// 2. Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Package imports
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

// 4. Local imports
import '../entities/feature_model.dart';
import '../provider/feature_provider.dart';
```

### 3. Code Organization
- Một file chỉ nên chứa một class chính
- Sử dụng barrel exports cho public APIs
- Group related functionality trong cùng folder

### 4. Documentation
```dart
/// Repository interface for managing features
/// 
/// Provides methods for CRUD operations on [FeatureModel]
abstract class IFeatureRepository {
  /// Fetches a paginated list of features
  /// 
  /// [page] - Page number (1-based)
  /// [limit] - Items per page
  /// [search] - Search query
  Future<ApiResult<List<FeatureModel>>> getFeatures({
    int? page,
    int? limit,
    String? search,
  });
}
```

## Testing Guidelines

### 1. Unit Tests
```dart
// test/provider/feature_provider_test.dart
void main() {
  group('FeatureListNotifier', () {
    test('should load features successfully', () async {
      // Arrange
      final mockRepository = MockFeatureRepository();
      when(mockRepository.getFeatures()).thenAnswer(
        (_) async => ApiResult.success([FeatureModel(id: 1, name: 'Test')]),
      );
      
      // Act
      final notifier = FeatureListNotifier();
      await notifier.loadFeatures();
      
      // Assert
      expect(notifier.state, isA<LoadState<List<FeatureModel>>>());
    });
  });
}
```

### 2. Widget Tests
```dart
// test/widget/feature_card_test.dart
void main() {
  testWidgets('FeatureCard displays feature information', (tester) async {
    // Arrange
    const feature = FeatureModel(id: 1, name: 'Test Feature');
    
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: FeatureCard(feature: feature),
      ),
    );
    
    // Assert
    expect(find.text('Test Feature'), findsOneWidget);
  });
}
```

## Performance Guidelines

### 1. Efficient Rebuilds
```dart
// Sử dụng Consumer thay vì ref.watch khi có thể
Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(featureProvider);
    return Text(state.toString());
  },
)
```

### 2. Lazy Loading
```dart
// Lazy load heavy operations
@riverpod
Future<List<FeatureModel>> expensiveComputation(ExpensiveComputationRef ref) async {
  // Only computed when needed
  return await heavyCalculation();
}
```

### 3. Image Optimization
```dart
// Sử dụng cached_network_image cho network images
CachedNetworkImage(
  imageUrl: feature.imageUrl,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
)
```

## Security Best Practices

### 1. API Keys
```dart
// Không hardcode API keys
const apiKey = String.fromEnvironment('API_KEY');
```

### 2. Input Validation
```dart
// Luôn validate user input
FormBuilderTextField(
  name: 'email',
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.email(),
    (value) {
      if (value != null && value.contains('<script>')) {
        return 'Input không hợp lệ';
      }
      return null;
    },
  ]),
)
```

### 3. Secure Storage
```dart
// Sử dụng flutter_secure_storage cho sensitive data
final storage = FlutterSecureStorage();
await storage.write(key: 'token', value: accessToken);
```

## Deployment & CI/CD

### 1. Build Commands
```bash
# Development build
flutter build apk --debug

# Production build
flutter build apk --release
flutter build appbundle --release
```

### 2. Code Quality
```bash
# Linting
flutter analyze

# Formatting
dart format .

# Tests
flutter test
```

### 3. Environment Configuration
```dart
// lib/core/config.dart
class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.example.com',
  );
  
  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: false);
}
```

## Troubleshooting

### Common Issues

1. **Provider not found**
   - Đảm bảo provider được khai báo với @riverpod
   - Check scope của ProviderScope

2. **Navigation errors**
   - Verify route paths trong GoRouter
   - Check context availability

3. **State not updating**
   - Ensure proper state assignment in notifier
   - Check if using correct provider reference

4. **Build errors**
   - Run `flutter clean && flutter pub get`
   - Check dependency versions compatibility

### Debug Tools
```dart
// Enable provider logging
ProviderScope(
  observers: [ProviderLogger()],
  child: MyApp(),
)
```

## Conclusion

Guideline này cung cấp framework standardized cho việc phát triển features trong CBPM application. Tuân thủ các patterns và best practices này sẽ đảm bảo code quality, maintainability và team collaboration hiệu quả.

Khi có thắc mắc hoặc cần support, hãy tham khảo existing code trong `packages/wo/` và `packages/contract/`