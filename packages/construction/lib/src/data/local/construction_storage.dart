import 'package:persistent_storage/persistent_storage.dart';

abstract class ConstructionLocalStorageKeys {
  static const key = '__user_storage_key__';
}

abstract class ConstructionLocalStorage {
  Future<void> setValue(String value);
}

class ConstructionLocalStorageImpl
    implements ConstructionLocalStorage {

  const ConstructionLocalStorageImpl({
    required SharedPreferencesStorage storage,
  }) : _storage = storage;

  final SharedPreferencesStorage _storage;

  /// Sets authToken in Storage.
  @override
  Future<void> setValue(String value) => _storage.write(
        key: ConstructionLocalStorageKeys.key,
        value: value,
      );
}
