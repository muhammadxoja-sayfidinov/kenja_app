// lib/providers/user_repository_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/constants.dart';
import '../repositories/user_repository.dart';

// FlutterSecureStorage Provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// UserRepository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return UserRepository(
    baseUrl: Constants.baseUrl,
    secureStorage: secureStorage,
  );
});
