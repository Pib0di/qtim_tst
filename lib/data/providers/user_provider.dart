import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/profile/data/profile_repository.dart';
import '../models/user.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref.watch(profileRepositoryProvider));
});

class UserNotifier extends StateNotifier<User?> {
  final ProfileRepository repository;

  UserNotifier(this.repository) : super(null);

  Future<void> getUser() async {
    final user = await repository.getUser();
    if (user != null) {
      state = user;
    }
  }
}
