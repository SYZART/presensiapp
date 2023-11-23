import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/providers/location_provider.dart';
import 'package:presensiapp/services/attendance_service.dart';
import 'package:presensiapp/style.dart';
import 'package:provider/provider.dart';

enum SingingCharacter { masuk, cuti, izin }

class PresensiRadioButton extends StatelessWidget {
  const PresensiRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(
      builder: (context, value, child) => Column(
        children: [
          RadioListTile(
            activeColor: secondaryColor,
            title: Text(
              'Masuk',
              style: primayTextStyle,
            ),
            value: 'Masuk',
            groupValue: value.signinValue,
            onChanged: (val) {
              value.signinValueSet = val!;
            },
          ),
          RadioListTile(
            activeColor: secondaryColor,
            title: Text(
              'Izin',
              style: primayTextStyle,
            ),
            value: 'Izin',
            groupValue: value.signinValue,
            onChanged: (val) {
              value.signinValueSet = val!;
            },
          ),
          RadioListTile(
            activeColor: secondaryColor,
            title: Text(
              'Cuti',
              style: primayTextStyle,
            ),
            value: 'Cuti',
            groupValue: value.signinValue,
            onChanged: (val) {
              value.signinValueSet = val!;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                  onPressed: () {
                    Params param = Params();
                    param.idUser = ID.idUser;
                    param.alamat = context.read<LocationProvider>().addres;
                    param.dateTime = ID.dateNow;
                    param.jamMasuk = DateFormat.Hm().format(DateTime.now());
                    param.status = value.signinValue;
                    value.createAttendance(param).whenComplete(() =>
                        value.getMyAttendanceToday(ID.idUser, ID.dateNow));
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: primayTextStyle,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
