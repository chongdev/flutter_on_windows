import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 Ways to Store Data Offline in Flutter'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text(
              '1. SQLite', style: TextStyle(color: Colors.white),),
            // tileColor: Colors.red,
            trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
            onTap: () => Get.toNamed('/notes'),
          ),
          ListTile(
            title: const Text(
              '2. Hive Database', style: TextStyle(color: Colors.white),),
            // tileColor: Colors.red,
            trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
            onTap: () => Get.toNamed('/contacts'),
          ),
        ],
      ),
    );
  }

}