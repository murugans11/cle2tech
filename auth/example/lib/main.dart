import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // For ProviderScope
import 'package:auth/auth.dart'; // Import the auth package

void main() {
  runApp(
    // For Riverpod to work, we need to wrap the app in a ProviderScope
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Package Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Here we use the LoginScreen from the 'auth' package
    // You could also navigate to it from a button, etc.
    return LoginScreen();
  }
}
