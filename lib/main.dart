import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/controllers/auth_controller.dart';
import 'package:flutter_firebase_sample/presentation/page/login_page.dart';
import 'package:flutter_firebase_sample/presentation/page/splash_page.dart';
import 'package:flutter_firebase_sample/presentation/page/top_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SNS Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    // final stream = useProvider(authStreamProvider.stream);
    // final snapshot = useStream(stream, initialData: UserState.waiting);
    return _convertPage(state: authControllerState);
  }
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
