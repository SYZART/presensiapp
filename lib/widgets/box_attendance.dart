import 'package:flutter/material.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/style.dart';
import 'package:provider/provider.dart';

class BoxAttendance extends StatelessWidget {
  const BoxAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    Widget box(AttendanceProvider value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Jam Masuk',
                style: thirdyTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                value.attendanceToday.data[0].jamMasuk,
                style: TextStyle(fontWeight: superBold, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 37,
            child: VerticalDivider(
              thickness: 1,
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Text(
                'Jam Keluar',
                style: thirdyTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                value.attendanceToday.data[0].jamKeluar == '23.59'
                    ? '-'
                    : value.attendanceToday.data[0].jamKeluar,
                style: TextStyle(fontWeight: superBold, color: Colors.white),
              ),
            ],
          )
        ],
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Consumer<AttendanceProvider>(builder: (context, value, child) {
          if (value.statAttendanceToday ==
              ResultStateAttendanceProvider.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (value.statAttendanceToday ==
              ResultStateAttendanceProvider.noData) {
            return box(value);
          } else if (value.statAttendanceToday ==
                  ResultStateAttendanceProvider.success &&
              value.attendanceToday.data[0].status == 'Izin') {
            return Center(
                child: Text(
              'Izin',
              style: TextStyle(color: Colors.white),
            ));
          } else if (value.statAttendanceToday ==
              ResultStateAttendanceProvider.success) {
            return box(value);
          }
          return const Center(
            child: Text('Terjadi Kesalahan'),
          );
        }),
      ),
    );
  }
}




//  Consumer<AttendanceProvider>(
//                             builder: (context, value, child) {
//                           if (value.statAttendanceToday ==
//                               ResultStateAttendanceProvider.loading) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           } else if (value.statAttendanceToday ==
//                               ResultStateAttendanceProvider.noData) {
//                             return BoxAttendance();
//                           } else if (value.statAttendanceToday ==
//                               ResultStateAttendanceProvider.success) {
//                             return Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: secondaryColor,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 16, horizontal: 8),
//                                 child: Consumer<AttendanceProvider>(
//                                   builder: (context, value, child) => Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Column(
//                                         children: [
//                                           Text(
//                                             'Jam Masuk',
//                                             style: thirdyTextStyle.copyWith(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           Text(
//                                             value.attendanceToday.data[0]
//                                                 .jamMasuk,
//                                             style: TextStyle(
//                                                 fontWeight: superBold,
//                                                 color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 37,
//                                         child: VerticalDivider(
//                                           thickness: 1,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(
//                                             'Jam Keluar',
//                                             style: thirdyTextStyle.copyWith(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           Text(
//                                             value.attendanceToday.data[0]
//                                                         .jamKeluar ==
//                                                     '23.59'
//                                                 ? '-'
//                                                 : value.attendanceToday.data[0]
//                                                     .jamKeluar,
//                                             style: TextStyle(
//                                                 fontWeight: superBold,
//                                                 color: Colors.white),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }

//                           return const Center(
//                               child: Text(
//                             'Terjadi Kesalahan',
//                             style: TextStyle(color: Colors.white),
//                           ));
//                         }),