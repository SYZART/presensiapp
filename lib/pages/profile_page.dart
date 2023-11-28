import 'dart:math';

import 'package:flutter/material.dart';
import 'package:presensiapp/main.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/pages/login_page.dart';
import 'package:presensiapp/providers/location_provider.dart';
import 'package:presensiapp/providers/page_provider.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/user_info.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Placeholder(),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12)),
              backgroundColor: MaterialStateProperty.all(secondaryColor)),
          onPressed: () =>
              UsersInfo().logout().then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  )),
          child: Text(
            'Log Out',
            style: secondaryTextStyle.copyWith(
                letterSpacing: 0.5, fontWeight: semiBold),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              context.read<PageProvider>().logout(UniqueKey());
              await UsersInfo().logout();
              runApp(MyApp());
            },
            child: Text('log'))
      ],
    );
  }
}
