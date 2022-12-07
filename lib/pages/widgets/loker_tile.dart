import 'package:bkkmobile/shared/variabel.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';

class LokerTile extends StatefulWidget {
  final String foto;
  final String perusahaan;
  final String posisi;
  final String tanggalAkhir;

  LokerTile(this.foto, this.perusahaan, this.posisi, this.tanggalAkhir);

  @override
  State<LokerTile> createState() => _LokerTileState();
}

class _LokerTileState extends State<LokerTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/loker');
      },
      child: Container(
        margin: EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, bottom: defaultMargin),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '$baseUrlImage/perusahaan/logo-stmik-wp.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
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
                    style: secoundaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.posisi,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Berlaku s.d ' + widget.tanggalAkhir,
                    style: priceTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
