import 'package:flutter_on_windows/screens/contact/contact_screen.dart';
import 'package:flutter_on_windows/screens/home_screen.dart';
import 'package:flutter_on_windows/screens/profile/profile_screen.dart';
import 'package:flutter_on_windows/screens/splash_screen.dart';
import 'package:flutter_on_windows/screens/note/note_screen.dart';
import 'package:flutter_on_windows/screens/todo/todo_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static final route = [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: "/home",
      page: () => const HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: "/notes",
      page: () => const NoteScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: "/contacts",
      page: () => const ContactScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: "/profile",
      page: () => const ProfileScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: "/todo",
      page: () => const TodoScreen(),
      transition: Transition.fade,
    ),
  ];
}
