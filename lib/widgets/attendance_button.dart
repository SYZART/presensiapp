import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/schedule_provider.dart';
import 'package:presensiapp/services/attendance_service.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/widgets/presensi_radio_button.dart';
import 'package:provider/provider.dart';

class AttendanceButton extends StatelessWidget {
  const AttendanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool containsAny(String text, List<String> substrings) {
      // returns true if any substring of the [substrings] list is contained in the [text]
      for (var substring in substrings) {
        if (text.contains(substring)) return true;
      }
      return false;
    }

    SizeConfig().init(context);
    return Consumer<ScheduleTodayProvider>(
      builder: (context, value, child) {
        if (value.stateToday == ResultStateSchduleProvider.loading) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: secondaryColor,
                  )),
            ),
          );
        } else if (value.stateToday == ResultStateSchduleProvider.hasData) {
          return context
                  .watch<AttendanceProvider>()
                  .attendanceToday
                  .data[0]
                  .status
                  .contains('i')
              ? Text('')
              : InkWell(
                  onTap: () {
                    Params paramss = Params();
                    paramss.idUser = ID.idUser;
                    paramss.dateTime = DateTime.now().toString().split(' ')[0];
                    paramss.jamKeluar = DateFormat.Hm().format(DateTime.now());
                    context
                                .read<AttendanceProvider>()
                                .attendanceToday
                                .data[0]
                                .jamMasuk ==
                            '-'
                        ? showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            builder: (context) => const SizedBox(
                              height: 220,
                              child: PresensiRadioButton(),
                            ),
                          )
                        : context
                                    .read<AttendanceProvider>()
                                    .attendanceToday
                                    .data[0]
                                    .jamKeluar ==
                                '23.59'
                            ? context
                                .read<AttendanceProvider>()
                                .updateAttendance(paramss)
                                .then((value) => context
                                    .read<AttendanceProvider>()
                                    .getMyAttendanceToday(
                                        ID.idUser, ID.dateNow))
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                backgroundColor: primaryColor,
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Anda Sudah Absen Hari Ini',
                                ),
                              ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: double.infinity,
                    height: getProportionateScreenHeight(44),
                    decoration: BoxDecoration(
                        color: context
                                    .watch<AttendanceProvider>()
                                    .attendanceToday
                                    .data[0]
                                    .jamMasuk ==
                                '-'
                            ? secondaryColor
                            : context
                                        .watch<AttendanceProvider>()
                                        .attendanceToday
                                        .data[0]
                                        .jamKeluar ==
                                    '23.59'
                                ? secondaryColor
                                : greyColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        context
                                    .watch<AttendanceProvider>()
                                    .attendanceToday
                                    .data[0]
                                    .jamMasuk ==
                                '-'
                            ? "Presensi Masuk"
                            : context
                                        .watch<AttendanceProvider>()
                                        .attendanceToday
                                        .data[0]
                                        .jamKeluar ==
                                    '23.59'
                                ? 'Presensi Keluar'
                                : 'Presensi',
                        style: secondaryTextStyle.copyWith(
                            color: Colors.white,
                            letterSpacing: 0.28,
                            fontWeight: superBold),
                      ),
                    ),
                  ),
                );
        } else if (value.stateToday == ResultStateSchduleProvider.noData) {
          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Center(
              child: Text(
                value.messageToday,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: IconButton(
                onPressed: () =>
                    value.getMyScheduleToday(ID.idUser, ID.dateNow),
                icon: const Icon(
                  Icons.refresh,
                  color: secondaryColor,
                )),
          ),
        );
      },
    );
  }
}
