import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/dashboard.dart';
import 'package:login_demo/db/UserDatabase.dart';
import 'package:login_demo/login_page.dart';
import 'package:login_demo/register_page.dart';

import 'Helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void onRegisterClick(BuildContext context) {
    if (kDebugMode) {
      print("Register click");
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void onLoginClick(BuildContext context) {
    if (kDebugMode) {
      print("Login click");
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    Helper.getUser().then((value) {
      if (value != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard(value)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Login"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
              onPressed: () {
                onRegisterClick(context);
              },
              child: const Text("Register")),
          TextButton(
              onPressed: () {
                onLoginClick(context);
              },
              child: const Text("Login")),
        ]),
      ),
    );
  }
}
