import 'package:flutter/material.dart';
// import 'package:network_core/network_core.dart'; // Will be used once there's something to use

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Core Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Network Core Example'),
        ),
        body: const Center(
          child: Text('Example app for network_core package.\n'
                      'Implementations will go here.'),
        ),
      ),
    );
  }
}
