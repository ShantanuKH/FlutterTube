import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/models/user_model.dart';
import 'package:youtube_clone/features/auth/repository/user_data_service.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(UserDataServiceProvider).fetchCurrentUserData();
  return user;
});

final anyUserDataProvider = FutureProvider.family((ref, userId) async {
  final UserModel user =
      await ref.watch(UserDataServiceProvider).fetchanyUserData(userId);

  return user;
});
