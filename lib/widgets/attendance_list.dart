import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensiapp/size_config.dart';
import 'package:presensiapp/style.dart';

class AttendanceList extends StatelessWidget {
  final DateTime date;
  final String jamMasuk, jamKeluar, address;
  const AttendanceList({
    super.key,
    required this.date,
    required this.jamKeluar,
    required this.jamMasuk,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String formattedDate = DateFormat('EEEE, d MMMM, yyyy', 'id').format(date);
    String dateLocal = DateTime.now().toString().split(' ')[0];
    String dateDB = date.toString().split(' ')[0];

    Widget data() {
      if (dateLocal == dateDB && jamKeluar == '23.59') {
        return Text(
          '$jamMasuk  ',
          style: primayTextStyle.copyWith(
            fontSize: getProportionateScreenWidth(12),
          ),
        );
      }
      return Text(
        '$jamMasuk - $jamKeluar ',
        style: primayTextStyle.copyWith(
          fontSize: getProportionateScreenWidth(12),
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      formattedDate,
                      style: primayTextStyle.copyWith(
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: bold),
                    ),
                    const Spacer(),
                    data()
                    // if(dateLocal == dateDB || jamKeluar == '23.59'){
                    //   return Text("");
                    // },
                    // (dateLocal == dateDB)
                    //     ? Text(
                    //         '$jamMasuk  ',
                    //         style: primayTextStyle.copyWith(
                    //           fontSize: getProportionateScreenWidth(12),
                    //         ),
                    //       )
                    //     : Text(
                    //         '$jamMasuk - $jamKeluar ',
                    //         style: primayTextStyle.copyWith(
                    //           fontSize: getProportionateScreenWidth(12),
                    //         ),
                    //       )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: primayTextStyle.copyWith(
                    fontSize: getProportionateScreenWidth(12),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// child: ListView.builder(
//       shrinkWrap: true,
//       itemCount: itemCount,
//       itemBuilder: (context, index) => Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             decoration: BoxDecoration(
//               border: Border.all(color: greyColor),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         formattedDate,
//                         style: primayTextStyle.copyWith(
//                             fontSize: getProportionateScreenWidth(12),
//                             fontWeight: bold),
//                       ),
//                       const Spacer(),
//                       Text(
//                         ' $jamMasuk - $jamKeluar',
//                         style: primayTextStyle.copyWith(
//                           fontSize: getProportionateScreenWidth(12),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Text(
//                     address,
//                     style: primayTextStyle.copyWith(
//                       fontSize: getProportionateScreenWidth(12),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             decoration: BoxDecoration(
//               border: Border.all(color: greyColor),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Jumat, 10 September 2023',
//                         style: primayTextStyle.copyWith(
//                             fontSize: getProportionateScreenWidth(12),
//                             fontWeight: bold),
//                       ),
//                       const Spacer(),
//                       Text(
//                         '07:22 AM - 18:14 AM',
//                         style: primayTextStyle.copyWith(
//                           fontSize: getProportionateScreenWidth(12),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Text(
//                     'Jl. Dewi Sartika No.262, RT.7/RW.5, Cawang, Kec. Kramat Jati, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13630',
//                     style: primayTextStyle.copyWith(
//                       fontSize: getProportionateScreenWidth(12),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),

class FiturList extends StatelessWidget {
  const FiturList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryColor),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.place_outlined),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          'Presensi',
          style: secondaryTextStyle.copyWith(
              fontSize: 12, letterSpacing: 0.24, fontWeight: bold),
        ),
      ],
    );
  }
}
