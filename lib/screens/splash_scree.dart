import 'dart:async';
import 'package:flutter/material.dart';
import '../base_class.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseClass<SplashScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeSystemUiColor();
      updateProgress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }

  void updateProgress() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    gotoNextWithNoBack(const HomeScreen());
  }
}
