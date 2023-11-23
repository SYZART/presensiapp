import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:presensiapp/pages/home_page.dart';
import 'package:presensiapp/pages/profile_page.dart';
import 'package:presensiapp/pages/rekap_page.dart';
import 'package:presensiapp/pages/schedule_page.dart';
import 'package:presensiapp/providers/page_provider.dart';
import 'package:presensiapp/style.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (context.watch<PageProvider>().index) {
        case 0:
          return const Home();

        case 1:
          return const SchedulePage();

        case 2:
          return const RekapPage();

        case 3:
          return const ProfilePage();

        default:
          return const Home();
      }
    }

    Widget customBottomNav() {
      return BottomNavigationBar(
          selectedLabelStyle: primayTextStyle.copyWith(fontWeight: bold),
          selectedItemColor: secondaryColor,
          currentIndex: context.read<PageProvider>().index,
          onTap: (value) {
            context.read<PageProvider>().index = value;
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.calendar_1), label: 'Jadwal'),
            BottomNavigationBarItem(icon: Icon(Iconsax.note_1), label: 'Rekap'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_circle), label: 'Profile'),
          ]);
    }

    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
