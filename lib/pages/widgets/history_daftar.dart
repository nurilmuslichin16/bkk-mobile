import 'package:bkkmobile/shared/variabel.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';

class HistoryDaftar extends StatefulWidget {
  final String idLoker;
  final String perusahaan;
  final String posisi;
  final String tanggalLamar;
  final String status;

  HistoryDaftar(this.idLoker, this.perusahaan, this.posisi, this.tanggalLamar,
      this.status);

  @override
  State<HistoryDaftar> createState() => _HistoryDaftarState();
}

class _HistoryDaftarState extends State<HistoryDaftar> {
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
            child: Image.network(
              '$baseUrlImage/perusahaan/logo-stmik-wp.png',
              width: 80,
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
                  widget.perusahaan,
                  style: primaryTextStyle.copyWith(fontWeight: semiBold),
                ),
                Text(
                  widget.posisi,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: subtitleColor,
                      fontSize: 10),
                ),
                SizedBox(
                  height: 6,
                ),
                widget.status == "0"
                    ? Text(
                        "Dalam Proses",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold),
                      )
                    : widget.status == "1"
                        ? Text(
                            "Diterima",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Ditolak",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold),
                          ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Tanggal daftar : ' + widget.tanggalLamar,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: subtitleColor,
                      fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
