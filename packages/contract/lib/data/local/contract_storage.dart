part of '../../contract.dart';

abstract class IOCContractLocalStorageKeys {
  static const key = '__user_storage_key__';
}

abstract class IOCContractLocalStorage {
  Future<void> setValue(String value);
}

class IOCContractLocalStorageImpl
    implements IOCContractLocalStorage {
  const IOCContractLocalStorageImpl({
    required SharedPreferencesStorage storage,
  }) : _storage = storage;

  final SharedPreferencesStorage _storage;

  /// Sets authToken in Storage.
  @override
  Future<void> setValue(String value) => _storage.write(
        key: IOCContractLocalStorageKeys.key,
        value: value,
      );
}
