// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = ChangeNotifierProvider(
  (ref) => UserStateNotifier(),
);
final authStreamProvider = StreamProvider.autoDispose((_) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return auth.onAuthStateChanged.map((user) => user != null);
});

class UserStateNotifier extends ChangeNotifier {
  // implements
}

enum UserState {
  // 初期化中
  waiting,

  // 未ログイン
  noLogin,

  //ログイン済み
  member
}
