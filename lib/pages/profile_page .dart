import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences preferences;
  bool loading = false;

  Future logout() async {
    preferences = await SharedPreferences.getInstance();
    preferences.remove('idPelamar');
    preferences.remove('namaLengkap');
    preferences.remove('username');
    preferences.remove('alamat');
    preferences.remove('nohp');
    preferences.remove('email');
    preferences.remove('tanggalLahir');
    preferences.remove('kewarganegaraan');
    preferences.remove('jurusan');
    setState(() {
      idPelamarUser = null;
      namaLengkapUser = null;
      usernameUser = null;
      alamatUser = null;
      nohpUser = null;
      emailUser = null;
      tanggalLahirUser = null;
      kewarganegaraanUser = null;
      jurusanUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    Widget footer() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: backgroundColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lock),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ubah Password",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                await logout().whenComplete(() => Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                        '/sign-in', (Route route) => false));
                setState(() {
                  loading = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: backgroundColor1,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget profile() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            // NOTE HEADER
            Container(
              margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: defaultMargin,
                  right: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Profil User",
                    style: primaryTextStyle.copyWith(
                        fontSize: 20, fontWeight: semiBold),
                  ),
                ],
              ),
            ),

            // NOTE NAMA
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nama Lengkap',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    namaLengkapUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE USERNAME
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Username',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    '@$usernameUser',
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE NO HP
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No HP',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    nohpUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE EMAIL
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    emailUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE TANGGAL LAHIR
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal Lahir',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    tanggalLahirUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE NEGARA
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Negara',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    kewarganegaraanUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE JURUSAN
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jurusan',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    jurusanUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // NOTE DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 10,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    alamatUser,
                    style: subtitleTextStyle.copyWith(fontWeight: light),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            //NOTE BUTTON
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          showSuccessDialog();
                        },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Ubah Profile',
                              style: buttonTextStyle.copyWith(
                                  fontWeight: semiBold),
                            ),
                          ],
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
                profile(),
                footer(),
              ],
            ),
    );
  }
}
