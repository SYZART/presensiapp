import 'package:flutter/material.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';

class Shift extends StatelessWidget {
  final int shiftId;
  const Shift({super.key, required this.shiftId});

  @override
  Widget build(BuildContext context) {
    Widget shift() {
      switch (shiftId) {
        case 1:
          return Container(
            width: 57,
            height: 22,
            decoration: BoxDecoration(
                color: grenColorTransparent,
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                'Shift 1',
                style: secondaryTextStyle.copyWith(
                    letterSpacing: 0.48,
                    fontSize: getProportionateScreenWidth(12),
                    color: grenColor),
              ),
            ),
          );
        case 2:
          return Container(
            width: 57,
            height: 22,
            decoration: BoxDecoration(
                color: blueColorTransparent,
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                'Shift 2',
                style: secondaryTextStyle.copyWith(
                    letterSpacing: 0.48,
                    fontSize: getProportionateScreenWidth(12),
                    color: blueColor),
              ),
            ),
          );

        case 3:
          return Container(
            width: 57,
            height: 22,
            decoration: BoxDecoration(
                color: orangeColorTransparent,
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                'Shift 3',
                style: secondaryTextStyle.copyWith(
                    letterSpacing: 0.48,
                    fontSize: getProportionateScreenWidth(12),
                    color: orangeColor),
              ),
            ),
          );
        default:
          return const Text('');
      }
    }

    return shift();
  }
}
