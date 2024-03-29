import 'package:flutter/material.dart';
import 'package:project_promise/pages/home_page.dart';
import 'package:project_promise/groups/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:project_promise/log_in.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: ((context) => AuthAPI()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    print('TOP CHANGE Value changed to: $value!');

    return MaterialApp(
      title: 'Appwrite Auth Demo',
      debugShowCheckedModeBanner: false,
      home: value == AuthStatus.uninitialized
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : value == AuthStatus.authenticated
              ? const HomePage()
              : const LoginPage(),
    );
  }
}
