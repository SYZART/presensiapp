import 'dart:io';

import 'package:flutter/material.dart';
import 'package:presensiapp/main.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/pages/login_page.dart';
import 'package:presensiapp/pages/main_page.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/auth_provider.dart';
import 'package:presensiapp/user_info.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    isRememberMe();
    Future.delayed(const Duration(seconds: 2));
    super.initState();
  }

  void isRememberMe() async {
    String? myId = await UsersInfo().getIdUser();
    if (myId == null && context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
      debugPrint(Log.key.toString());
      return;
    } else if (myId != null && context.mounted) {
      ID.idUser = myId;
      await context
          .read<AuthProvider>()
          .getMyProfile(ID.idUser)
          .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
                (route) => false,
              ))
          .catchError(exit(0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
