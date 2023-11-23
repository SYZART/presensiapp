import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/auth_provider.dart';
import 'package:presensiapp/providers/location_provider.dart';
import 'package:presensiapp/providers/schedule_provider.dart';
import 'package:presensiapp/services/attendance_service.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/widgets/attendance_list.dart';
import 'package:presensiapp/widgets/presensi_radio_button.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    final name = context.select(
        (AuthProvider authProvider) => authProvider.usersModel.data[0].name);
    SizeConfig().init(context);
    return SafeArea(
      child: Consumer<LocationProvider>(
        builder: (context, value, child) {
          if (value.stateLocation == ResultStateLocationProvider.loading) {
            return Scaffold(
              body: Image.asset(
                'assets/images/presensi.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          } else if (value.stateLocation ==
              ResultStateLocationProvider.hasData) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: defaultPadding,
                  top: defaultPadding,
                  right: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        maxRadius: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context
                                  .read<AuthProvider>()
                                  .usersModel
                                  .data[0]
                                  .name,
                              overflow: TextOverflow.ellipsis,
                              style: primayTextStyle,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              context
                                  .read<AuthProvider>()
                                  .usersModel
                                  .data[0]
                                  .jabatan,
                              overflow: TextOverflow.ellipsis,
                              style: primayTextStyle.copyWith(
                                  fontWeight: bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Iconsax.notification)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(name),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => value.getLocs(),
                      child: Text(
                        'Refresh Lokasi',
                        style: primayTextStyle.copyWith(color: secondaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.addres,
                          style: thirdyTextStyle.copyWith(
                              fontSize: 12, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Consumer<AttendanceProvider>(
                              builder: (context, value, child) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        style: TextStyle(
                                            fontWeight: superBold,
                                            color: Colors.white),
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
                                        value.attendanceToday.data[0]
                                                    .jamKeluar ==
                                                '23.59'
                                            ? '-'
                                            : value.attendanceToday.data[0]
                                                .jamKeluar,
                                        style: TextStyle(
                                            fontWeight: superBold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Consumer<ScheduleTodayProvider>(
                          builder: (context, value, child) {
                            if (value.stateToday ==
                                ResultStateSchduleProvider.loading) {
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
                            } else if (value.stateToday ==
                                ResultStateSchduleProvider.hasData) {
                              return InkWell(
                                onTap: () {
                                  Params paramss = Params();
                                  paramss.idUser = ID.idUser;
                                  paramss.dateTime =
                                      DateTime.now().toString().split(' ')[0];
                                  paramss.jamKeluar =
                                      DateFormat.Hm().format(DateTime.now());
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                                      .watch<
                                                          AttendanceProvider>()
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
                                                      .watch<
                                                          AttendanceProvider>()
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
                            } else if (value.stateToday ==
                                ResultStateSchduleProvider.noData) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Center(
                                  child: Text(
                                    'Belum Ada Jadwal ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: IconButton(
                                    onPressed: () => value.getMyScheduleToday(
                                        ID.idUser, ID.dateNow),
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: secondaryColor,
                                    )),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Rekap Presensi',
                    style: primayTextStyle.copyWith(fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Consumer<AttendanceProvider>(
                    builder: (context, value, child) {
                      if (value.stateMyAttendance ==
                          ResultStateAttendanceProvider
                              .getMyAttendanceLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (value.stateMyAttendance ==
                          ResultStateAttendanceProvider.getMyAttendanceEmpty) {
                        return const Center(
                          child: Text('No Data'),
                        );
                      } else if (value.stateMyAttendance ==
                          ResultStateAttendanceProvider
                              .getMyAttendanceHasData) {
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.attendanceModel.data.length,
                              itemBuilder: (context, index) {
                                final data = value.attendanceModel.data[index];

                                return AttendanceList(
                                    date: data.date,
                                    jamKeluar: data.jamKeluar,
                                    jamMasuk: data.jamMasuk,
                                    address: data.alamat);
                              }),
                        );
                      }
                      return Center(
                        child: IconButton(
                            onPressed: () => value.getMyAttendance(ID.idUser),
                            icon: const Icon(Iconsax.refresh_right_square)),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (value.stateLocation == ResultStateLocationProvider.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => value.getLocs(),
                    icon: const Icon(Icons.refresh),
                    padding: EdgeInsets.zero,
                  ),
                  Text(
                    'Terjadi Kesalahan',
                    style: primayTextStyle,
                  ),
                ],
              ),
            );
          }
          return Center(
            child: IconButton(
                onPressed: () => value.getLocs(),
                icon: const Icon(Iconsax.refresh_right_square)),
          );
        },
      ),
    );
  }
}
