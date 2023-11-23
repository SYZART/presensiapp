import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:presensiapp/pages/home_page.dart';
import 'package:presensiapp/pages/login_page.dart';
import 'package:presensiapp/pages/main_page.dart';
import 'package:presensiapp/pages/splash_page.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/auth_provider.dart';
import 'package:presensiapp/providers/location_provider.dart';
import 'package:presensiapp/providers/page_provider.dart';
import 'package:presensiapp/providers/schedule_provider.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<LocationProvider>(
            create: (context) => LocationProvider()),
        ChangeNotifierProvider<ScheduleProvider>(
            create: (context) => ScheduleProvider()),
        ChangeNotifierProvider<ScheduleTodayProvider>(
            create: (context) => ScheduleTodayProvider()),
        ChangeNotifierProvider<PageProvider>(
            create: (context) => PageProvider()),
        ChangeNotifierProvider<AttendanceProvider>(
            create: (context) => AttendanceProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login-page': (context) => const LoginPage(),
          '/home-page': (context) => const Home(),
          '/main-page': (context) => const MainPage()
        },
      ),
    );
  }
}

// class AuthCheck extends StatefulWidget {
//   const AuthCheck({super.key});

//   @override
//   State<AuthCheck> createState() => _AuthCheckState();
// }

// class _AuthCheckState extends State<AuthCheck> {
//   late SharedPreferences sharedPreferences;
//   bool userAvailable = false;

//   @override
//   void initState() {
//     super.initState();

//     _getCurrentUser();
//   }

//   void _getCurrentUser() async {
//     sharedPreferences = await SharedPreferences.getInstance();

//     try {
//       if (sharedPreferences.getString('id') != null) {
//         setState(() {
//           print("-");
//           User.username = sharedPreferences.getString('id')!;
//           print(User.username);
//           userAvailable = true;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userAvailable = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return userAvailable ? const Navbar() : const Login();
//   }
// }
