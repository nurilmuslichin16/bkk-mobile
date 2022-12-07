import 'package:bkkmobile/models/history_loker_model.dart';
import 'package:bkkmobile/pages/widgets/history_daftar.dart';
import 'package:bkkmobile/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor2,
        centerTitle: true,
        title: Text(
          'History Pendaftaran',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget wishlistEmpty() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: backgroundColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo-stmik-wp.png',
                width: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'You don\'t have a dream shoes?',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Lets find your favorite shoes',
                style: secoundaryTextStyle,
              ),
              SizedBox(height: 20),
              Container(
                height: 44,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Explorer Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
          child: FutureBuilder(
        future: HistoryLokerModel.getHistoryListLoker(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return HistoryDaftar(
                    snapshot.data[index].idLoker,
                    snapshot.data[index].namaPerusahaan,
                    snapshot.data[index].posisi,
                    snapshot.data[index].tanggalLamar,
                    snapshot.data[index].status);
              },
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            return Loading();
          }
        },
      ));
    }

    return Column(children: [
      header(),
      // wishlistEmpty(),
      content()
    ]);
  }
}
