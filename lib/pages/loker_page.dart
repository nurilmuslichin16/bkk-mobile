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
  String idDetailLoker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getDataLoker();
      await getStatusLoker();

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
    setState(() {});
  }

  reloadData() {
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
                      child: statusLoker.status
                          ? TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: secondaryColor),
                              child: Text(
                                'Anda sudah terdaftar',
                                style: buttonTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              ),
                            )
                          : TextButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });

                                await DaftarLokerModel.postDaftar(
                                        idLoker, idPelamarUser)
                                    .then((value) => {
                                          if (value.status != false)
                                            {
                                              idDetailLoker =
                                                  value.idDetailLoker,
                                              showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) {
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                SizedBox(
                                                                  height: 100,
                                                                  width: 100,
                                                                  child: Image.asset(
                                                                      "assets/images/approved.png",
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Text(
                                                                  "Sukses!",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                    value.text),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            "OK"))
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      })
                                                  .then((value) =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/upload-file',
                                                          arguments: {
                                                            'idDetailLoker':
                                                                idDetailLoker
                                                          }))
                                                  .then((value) => reloadData())
                                            }
                                          else
                                            {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            SizedBox(
                                                              height: 100,
                                                              width: 100,
                                                              child: Image.asset(
                                                                  "assets/images/rejected.png",
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            const Text(
                                                              "Opss! Gagal",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(value.text),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "OK"))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                            }
                                        });

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
