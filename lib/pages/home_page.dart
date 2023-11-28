import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/auth_provider.dart';
import 'package:presensiapp/providers/location_provider.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/widgets/attendance_list.dart';
import 'package:presensiapp/widgets/box_attendance.dart';
import 'package:presensiapp/widgets/attendance_button.dart';
import 'package:presensiapp/widgets/presensi_radio_button.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    debugPrint('build');
    final name = context.select(
        (AuthProvider authProvider) => authProvider.usersModel.data[0].name);
    SizeConfig().init(context);
    return SafeArea(
      key: _scaffoldKey,
      child: Consumer<LocationProvider>(
        builder: (context, value, child) {
          if (value.stateLocation == ResultStateLocationProvider.loading) {
            return const Center(child: CircularProgressIndicator());
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
                        BoxAttendance(),
                        AttendanceButton()
                      ],
                    ),
                  ),
                  Text(ID.idUser),
                  Text(ID.dateNow),
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
