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
      body: Row(
        children: [
          Expanded(child: Container()),
          Expanded(child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text(
                  '1. SQLite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                // tileColor: Colors.red,
                subtitle: const Text('Support Android, IOS, MacOS', style: TextStyle(color: Colors.white60),),
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
                onTap: () => Get.toNamed('/notes'),
              ),
              ListTile(
                title: const Text(
                  '2. SQLite ffi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: const Text('Support Windows', style: TextStyle(color: Colors.white60),),
                // tileColor: Colors.red,
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
                onTap: () => Get.toNamed('/todo'),
              ),
              ListTile(
                title: const Text(
                  '3. Hive Database', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: const Text('Support Android, Windows', style: TextStyle(color: Colors.white60),),
                // tileColor: Colors.red,
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
                onTap: () => Get.toNamed('/contacts'),
              ),
              ListTile(
                title: const Text(
                  '4. Using Text/CSV/JSON files', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: const Text('Support Android, IOS, Linux, MacOS, Web, Windows', style: TextStyle(color: Colors.white60),),
                // tileColor: Colors.red,
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
                onTap: () => Get.toNamed('/profile'),
              ),
              ListTile(
                title: const Text(
                  '5. Objectbox', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: const Text('Support Android, Windows, IOS, Linux, MacOS', style: TextStyle(color: Colors.white60),),
                // tileColor: Colors.red,
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  '6. Shared Preferences Storage', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: const Text('Support Android, Windows, IOS, Linux, MacOS', style: TextStyle(color: Colors.white60),),
                // tileColor: Colors.red,
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white38),
                onTap: () {},
              ),
            ],
          ),)
        ],
      )
    );
  }

}