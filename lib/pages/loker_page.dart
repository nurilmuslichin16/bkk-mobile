import 'package:bkkmobile/models/detail_loker_model.dart';
import 'package:bkkmobile/services/loker_service.dart';
import 'package:bkkmobile/shared/loading.dart';
import 'package:bkkmobile/shared/variabel.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter_html/flutter_html.dart';

class LokerPage extends StatefulWidget {
  @override
  _LokerPageState createState() => _LokerPageState();
}

class _LokerPageState extends State<LokerPage> {
  DetailLokerModel detailLoker;
  LokerService service = LokerService();
  bool loading = true;
  String idLoker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataLoker();
    });
  }

  getDataLoker() async {
    detailLoker = await service.getDetailLoker(idLoker);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg = (ModalRoute.of(context).settings.arguments ??
        <String, dynamic>{}) as Map;
    idLoker = arg['idLoker'];

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, color: primaryTextColor),
                    ),
                  ),
                  Image.asset(
                    'assets/images/icon_success.png',
                    width: 100,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Selamat :)',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Anda berhasil mendaftar loker ini',
                    style: secoundaryTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat history',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget header() {
      return Stack(
        children: [
          ClipRRect(
            child: Image.network(
              '$baseUrlImage/perusahaan/logo-stmik-wp.png',
              width: MediaQuery.of(context).size.width,
              height: 380,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            // NOTE HEADER
            Container(
              margin: EdgeInsets.only(
                  top: defaultMargin,
                  left: defaultMargin,
                  right: defaultMargin),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detailLoker.namaPerusahaan,
                          style: primaryTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold),
                        ),
                        Text(
                          detailLoker.posisi,
                          style: secoundaryTextStyle.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NOTE GAJI
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  top: 20, left: defaultMargin, right: defaultMargin),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gaji',
                    style: primaryTextStyle,
                  ),
                  Text(
                    'Rp. ' + detailLoker.gaji,
                    style: priceTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  )
                ],
              ),
            ),

            // NOTE PRICE
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  top: 20, left: defaultMargin, right: defaultMargin),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terakhir Pendaftaran',
                    style: primaryTextStyle,
                  ),
                  Text(
                    detailLoker.tanggalAkhir,
                    style: priceTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  )
                ],
              ),
            ),

            // NOTE DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  Html(data: detailLoker.deskripsi)
                ],
              ),
            ),
            SizedBox(height: 30),
            //NOTE BUTTON
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 54,
                      child: TextButton(
                        onPressed: () {
                          showSuccessDialog();
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: primaryColor),
                        child: Text(
                          'Daftar loker ini sekarang',
                          style: buttonTextStyle.copyWith(
                              fontSize: 16, fontWeight: semiBold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      body: loading
          ? Loading()
          : ListView(
              children: [
                header(),
                content(),
              ],
            ),
    );
  }
}
