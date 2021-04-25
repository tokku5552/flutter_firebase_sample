import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/presentation/notifier/user_state_notifier.dart';
import 'package:flutter_firebase_sample/presentation/page/login_page.dart';
import 'package:flutter_firebase_sample/presentation/page/splash_page.dart';
import 'package:flutter_firebase_sample/presentation/page/top_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userState = useProvider(authStreamProvider);
    return MaterialApp(
      title: 'Flutter SNS Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<UserState>(
        stream: userState,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<UserState> snapshot) {
          final state = (snapshot.connectionState == ConnectionState.waiting
              ? UserState.waiting
              : snapshot.data)!;
          return _convertPage(state: state);
        },
      ),
    );
  }

  StatelessWidget _convertPage({required UserState state}) {
    switch (state) {
      case UserState.waiting:
        return SplashPage();

      case UserState.noLogin:
        return LoginPage();

      case UserState.member:
        return TopPage();

      default: // 不明
        return LoginPage();
    }
  }
}
