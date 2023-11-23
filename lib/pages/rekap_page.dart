import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/location_provider.dart';
import 'package:presensiapp/providers/schedule_provider.dart';
import 'package:presensiapp/services/attendance_service.dart';
import 'package:presensiapp/style.dart';
import 'package:provider/provider.dart';

class RekapPage extends StatelessWidget {
  const RekapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Params paramss = Params();
              paramss.idUser = ID.idUser;
              paramss.alamat = context.read<LocationProvider>().addres;
              paramss.dateTime = DateTime.now().toString().split(' ')[0];
              paramss.jamMasuk = DateFormat.Hm().format(DateTime.now());
              paramss.status = "Masuk";
              context.read<AttendanceProvider>().createAttendance(paramss);
            },
            child: Consumer<AttendanceProvider>(
              builder: (context, value, child) {
                if (value.stateCreateAttendance ==
                    ResultStateAttendanceProvider.loading) {
                  return const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text(
                    'attendance',
                    style: primayTextStyle,
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Params paramss = Params();
              paramss.idUser = ID.idUser;
              paramss.dateTime = DateTime.now().toString().split(' ')[0];
              paramss.jamKeluar = DateFormat.Hm().format(DateTime.now());
              debugPrint(paramss.dateTime);
              context.read<AttendanceProvider>().updateAttendance(paramss);
            },
            child: Consumer<AttendanceProvider>(
              builder: (context, value, child) {
                if (value.stateUpdateAttendance ==
                    ResultStateAttendanceProvider.outLoading) {
                  return const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Text(
                    'Out',
                    style: primayTextStyle,
                  );
                }
              },
            ),
          ),
          IconButton(
              onPressed: () =>
                  context.read<ScheduleProvider>().getMySchedule('001'),
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () => context
                  .read<ScheduleTodayProvider>()
                  .getMyScheduleToday(ID.idUser, ID.dateNow),
              icon: const Icon(Iconsax.direct_notification))
        ],
      ),
    );
  }
}
