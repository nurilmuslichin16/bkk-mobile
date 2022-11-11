import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';

class HistoryDaftar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 10, left: 12, bottom: 12, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor2,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/icon_user.png',
              width: 60,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PT. Berkah Jaya',
                  style: primaryTextStyle.copyWith(fontWeight: semiBold),
                ),
                Text(
                  'Administrator',
                  style: subtitleTextStyle,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Tanggal daftar : 15 Februari 2022',
                  style: subtitleTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
