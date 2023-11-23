import 'package:flutter/material.dart';
import 'package:presensiapp/models/schedule_model.dart';
import 'package:presensiapp/providers/schedule_provider.dart';
import 'package:presensiapp/style.dart';
import 'package:presensiapp/widgets/schedule_list.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, value, _) {
        if (value.state == ResultStateSchduleProvider.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.state == ResultStateSchduleProvider.hasData) {
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ListView.builder(
                itemCount: value.scheduleUserModel.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DataSchedule shceduleUserModel =
                      value.scheduleUserModel.data[index];
                  return ScheduleList(
                      date: shceduleUserModel.date,
                      shifID: shceduleUserModel.shiftId);
                }),
          );
        } else if (value.state == ResultStateSchduleProvider.noData) {
          return const Center(
            child: Text('Data Jadwal Kosong'),
          );
        } else if (value.state == ResultStateSchduleProvider.error) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => value.getMySchedule('001'),
            ),
          );
        }
        return const Text('sd');
      },
    );
  }
}
