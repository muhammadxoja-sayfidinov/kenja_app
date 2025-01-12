// lib/providers/user_profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenja_app/data/providers/providers.dart';

import '../models/user_profile.dart';

final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUserProfile();
});
