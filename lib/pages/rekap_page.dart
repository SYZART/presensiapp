import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:presensiapp/models/attendance_model.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/user_info.dart';
import 'package:presensiapp/widgets/attendance_list.dart';
import 'package:provider/provider.dart';

class RekapPage extends StatelessWidget {
  const RekapPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: Consumer<AttendanceRange>(
          builder: (context, value, child) {
            if (value.statAttendanceRange ==
                ResultStateAttendanceProvider.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.statAttendanceRange ==
                ResultStateAttendanceProvider.success) {
              Iterable<Datum> izin = value.attendanceRange.data
                  .where((element) => element.status == 'Izin');
              Iterable<Datum> cuti = value.attendanceRange.data
                  .where((element) => element.status == 'Cuti');
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(getProportionateScreenHeight(127)),
                    child: Column(
                      children: [
                        Text(
                          'Rekap Absensi',
                          style: primayTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                              color: blackColor),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: DropdownButton(
                              underline: const SizedBox(),
                              icon: const Icon(Iconsax.arrow_down_14),
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: primayTextStyle.copyWith(
                                        color: blackColor),
                                  ),
                                );
                              }).toList(),
                              onChanged: (v) {
                                debugPrint(v);
                              }),
                        ),
                        TabBar(
                          padding: const EdgeInsets.only(bottom: 10),
                          indicatorWeight: 0,
                          labelStyle:
                              primayTextStyle.copyWith(fontWeight: semiBold),
                          unselectedLabelColor: blackColor,
                          unselectedLabelStyle: primayTextStyle.copyWith(
                              color: blackColor, fontSize: 12),
                          indicator: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          tabs: [
                            Tab(
                                icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Semua',
                                ),
                                Text(
                                  '${value.attendanceRange.data.length} Hari',
                                )
                              ],
                            )),
                            Tab(
                                icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Izin',
                                ),
                                Text('${izin.length} Hari')
                              ],
                            )),
                            Tab(
                                icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Cuti',
                                ),
                                Text('${cuti.length} Hari')
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      ListView(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        children: value.attendanceRange.data
                            .map(
                              (e) => AttendanceList(
                                  date: e.date,
                                  jamKeluar: e.jamKeluar,
                                  jamMasuk: e.jamMasuk,
                                  address: e.alamat),
                            )
                            .toList(),
                      ),
                      ListView(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          children: izin
                              .map((e) => AttendanceList(
                                  date: e.date,
                                  jamKeluar: e.jamKeluar,
                                  jamMasuk: e.jamMasuk,
                                  address: e.alamat))
                              .toList()),
                      ListView(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          children: cuti
                              .map((e) => AttendanceList(
                                  date: e.date,
                                  jamKeluar: e.jamKeluar,
                                  jamMasuk: e.jamMasuk,
                                  address: e.alamat))
                              .toList()),
                    ],
                  ),
                ),
              );
              // return Column(children: [
              //   Text('asd'),
              //   Expanded(
              //     child: ListView(
              //       physics: const ScrollPhysics(),
              //       shrinkWrap: true,
              //       children: value.attendanceRange.data
              //           .map(
              //             (e) => AttendanceList(
              //                 date: e.date,
              //                 jamKeluar: e.jamKeluar,
              //                 jamMasuk: e.jamMasuk,
              //                 address: e.alamat),
              //           )
              //           .toList(),
              //     ),
              //   )
              // ]);
            } else if (value.statAttendanceRange ==
                ResultStateAttendanceProvider.noData) {
              return const Center(
                child: Text('No Data'),
              );
            }

            return Center(
              child: IconButton(
                  onPressed: () =>
                      value.getAttendanceRangeDate(ID.idUser, '2023-11'),
                  icon: const Icon(Iconsax.refresh_right_square)),
            );
          },
        ),
      ),
    );
  }
}
