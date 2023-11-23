import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/widgets/shift_widget.dart';

class ScheduleList extends StatelessWidget {
  final int shifID;
  final DateTime date;
  const ScheduleList({super.key, required this.shifID, required this.date});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String formattedDate = DateFormat('EEEE, d MMMM, yyyy', 'id').format(date);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: greyColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Text(
              formattedDate,
              style: primayTextStyle.copyWith(
                  fontSize: getProportionateScreenWidth(12), fontWeight: bold),
            ),
            const Spacer(),
            Shift(shiftId: shifID)
          ],
        ),
      ),
    );
  }
}
