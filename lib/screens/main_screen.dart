import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to App",
              style: TextStyle(fontSize: 30.0, color: Colors.blue),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Login Screen"),
            ),
          ],
        ),
      ),
    );
  }
}