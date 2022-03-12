import 'package:flutter/material.dart';
import 'package:flutter_on_windows/screens/home_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkAuth();

    return const Scaffold(
      body: Center(
        child: Text('กำลังโหลด...'),
      ),
    );
  }

  void _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.off(() => const HomeScreen());
  }
}
