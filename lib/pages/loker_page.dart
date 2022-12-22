import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/cek_loker_model.dart';
import 'package:bkkmobile/models/daftar_loker_model.dart';
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
  CekLokerModel statusLoker;
  LokerService service = LokerService();
  bool loading = true;
  String idLoker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataLoker();
      getStatusLoker();

      setState(() {
        loading = false;
      });
    });
  }

  getDataLoker() async {
    detailLoker = await service.getDetailLoker(idLoker);
    setState(() {});
  }

  getStatusLoker() async {
    statusLoker = await service.getStatusLoker(idLoker, idPelamarUser);
    print("Status : Terdaftar Loker ini ${statusLoker.status}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final arg = (ModalRoute.of(context).settings.arguments ??
        <String, dynamic>{}) as Map;
    idLoker = arg['idLoker'];

    Widget header() {
      return Stack(
        children: [
          ClipRRect(
            child: Image.network(
              '$baseUrlFotoPerusahaan' + detailLoker.foto,
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
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          await DaftarLokerModel.postDaftar(
                                  idLoker, idPelamarUser)
                              .then((value) => Navigator.pushNamed(
                                  context, '/upload-file',
                                  arguments: {'idLoker': idLoker}));

                          setState(() {
                            loading = false;
                          });
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
