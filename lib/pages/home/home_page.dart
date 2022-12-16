import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/loker_model.dart';
import 'package:bkkmobile/pages/widgets/loker_tile.dart';
import 'package:bkkmobile/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, $namaLengkapUser',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@$usernameUser',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      );
    }

    Widget newArivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Daftar Lowongan',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArivals() {
      return Expanded(
          child: FutureBuilder(
        future: LokerModel.getListLoker(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return LokerTile(
                    snapshot.data[index].idLoker,
                    snapshot.data[index].foto,
                    snapshot.data[index].namaPerusahaan,
                    snapshot.data[index].posisi,
                    snapshot.data[index].tanggalAkhir);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            return Loading();
          }
        },
      ));
    }

    return Column(
      children: [
        header(),
        newArivalsTitle(),
        newArivals(),
      ],
    );
  }
}
