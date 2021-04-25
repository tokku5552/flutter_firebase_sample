import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = ChangeNotifierProvider(
  (ref) => UserStateNotifier(),
);

final authStreamProvider = StreamProvider.autoDispose((_) {
  final auth = FirebaseAuth.instance;
  final _userStateStreamController = StreamController<UserState>();
  auth.authStateChanges().listen((user) {
    var state = UserState.noLogin;
    if (user != null) {
      state = UserState.member;
      _userStateStreamController.sink.add(state);
    }
  });
  return _userStateStreamController.stream;
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
