import 'dart:developer';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/register_model.dart';
import 'package:bkkmobile/models/ubah_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UbahProfile extends StatefulWidget {
  @override
  State<UbahProfile> createState() => _UbahProfileState();
}

class _UbahProfileState extends State<UbahProfile> {
  SharedPreferences preferences;

  final _namaLengkapController = TextEditingController();
  final _usernameController = TextEditingController();
  final _alamatController = TextEditingController();
  final _nisnController = TextEditingController();
  final _noHpController = TextEditingController();
  final _emailController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  String _jurusanValue = '';
  String _jenisValue = '';

  bool loading = false;

  Future setPreferenProfile(namaLengkap, username, alamat, nisn, nohp, email,
      tanggalLahir, jurusan, jenis) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('namaLengkap', namaLengkap);
    preferences.setString('username', username);
    preferences.setString('alamat', alamat);
    preferences.setString('nohp', nohp);
    preferences.setString('email', email);
    preferences.setString('tanggalLahir', tanggalLahir);
    preferences.setString('nisn', nisn);
    preferences.setString('jurusan', jurusan);
    preferences.setString('jenis', jenis);
    setState(() {
      namaLengkapUser = namaLengkap;
      usernameUser = username;
      alamatUser = alamat;
      nohpUser = nohp;
      emailUser = email;
      tanggalLahirUser = tanggalLahir;
      nisnUser = nisn;
      jurusanUser = jurusan;
      jenisUser = jenis;
    });
  }

  @override
  void initState() {
    _namaLengkapController.text = namaLengkapUser;
    _usernameController.text = usernameUser;
    _alamatController.text = alamatUser;
    _nisnController.text = nisnUser;
    _noHpController.text = nohpUser;
    _emailController.text = emailUser;
    _tanggalLahirController.text = tanggalLahirUser;
    _jurusanValue = jurusanUser;
    _jenisValue = jenisUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Profile',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text('Silahkan ubah data profile dengan data terbaru.',
                style: subtitleTextStyle)
          ],
        ),
      );
    }

    Widget fullNameInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Lengkap',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _namaLengkapController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan nama lengkap anda',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _usernameController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Buat username anda',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget alamatInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _alamatController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan alamat anda',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget nisnInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NISN',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.flag,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _nisnController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan NISN anda',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget noHpInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomer HP',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.local_phone,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _noHpController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Nomer HP anda',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _emailController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan email anda',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget tanggalLahirInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Lahir',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: _tanggalLahirController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Tanggal Lahir anda',
                          hintStyle: subtitleTextStyle,
                        ),
                        onTap: () async {
                          DateTime pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1945),
                              lastDate: DateTime(2050));

                          if (pickDate != null) {
                            setState(() {
                              _tanggalLahirController.text =
                                  DateFormat('yyyy-MM-dd').format(pickDate);
                            });
                          } else {
                            return;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget jurusanInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jurusan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      children: [
                        Radio(
                          value: 'Akutansi',
                          groupValue: _jurusanValue,
                          onChanged: (value) {
                            setState(() {
                              _jurusanValue = value as String;
                            });
                          },
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Akutansi",
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Radio(
                          value: 'Multimedia',
                          groupValue: _jurusanValue,
                          onChanged: (value) {
                            setState(() {
                              _jurusanValue = value as String;
                            });
                          },
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Multimedia",
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget jenisInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      children: [
                        Radio(
                          value: 'Siswa',
                          groupValue: _jenisValue,
                          onChanged: (value) {
                            setState(() {
                              _jenisValue = value as String;
                            });
                          },
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Siswa",
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Radio(
                          value: 'Alumni',
                          groupValue: _jenisValue,
                          onChanged: (value) {
                            setState(() {
                              _jenisValue = value as String;
                            });
                          },
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Alumni",
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget ubahButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: TextButton(
          onPressed: () async {
            //Navigator.pushNamed(context, '/home');
            var namaLengkap = _namaLengkapController.text;
            var username = _usernameController.text;
            var alamat = _alamatController.text;
            var nisn = _nisnController.text;
            var nohp = _noHpController.text;
            var email = _emailController.text;
            var tanggalLahir = _tanggalLahirController.text;
            var jurusan = _jurusanValue;
            var jenis = _jenisValue;

            setState(() {
              loading = true;
            });

            if (namaLengkap != "" &&
                username != "" &&
                alamat != "" &&
                nisn != "" &&
                nohp != "" &&
                email != "" &&
                tanggalLahir != "" &&
                jurusan != "" &&
                jenis != "") {
              await UbahProfileModel.postUbahProfile(
                      idPelamarUser,
                      namaLengkap,
                      username,
                      alamat,
                      nisn,
                      nohp,
                      email,
                      tanggalLahir,
                      jurusan,
                      jenis)
                  .then((value) => {
                        if (value.status != false)
                          {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                                "assets/images/approved.png",
                                                fit: BoxFit.cover),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text(
                                            "Berhasil Mengubah Profile",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
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
                                                setPreferenProfile(
                                                        namaLengkap,
                                                        username,
                                                        alamat,
                                                        nisn,
                                                        nohp,
                                                        email,
                                                        tanggalLahir,
                                                        jurusan,
                                                        jenis)
                                                    .whenComplete(() =>
                                                        Navigator.of(context)
                                                            .pop());
                                              },
                                              child: const Text("OK"))
                                        ],
                                      ),
                                    ),
                                  );
                                }).then((value) => Navigator.of(context).pop())
                          }
                        else
                          {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                                "assets/images/rejected.png",
                                                fit: BoxFit.cover),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text(
                                            "Gagal Mengubah Profile",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
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
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"))
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          }
                      });
            } else {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/images/rejected.png",
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Gagal Login",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Form tidak boleh ada yang kosong!"),
                            const SizedBox(
                              height: 15,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"))
                          ],
                        ),
                      ),
                    );
                  });
            }

            setState(() {
              loading = false;
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: loading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 25.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Mohon menunggu...",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Text(
                  'Ubah Profile',
                  style: buttonTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: ListView(
            children: [
              header(),
              nisnInput(),
              fullNameInput(),
              usernameInput(),
              alamatInput(),
              noHpInput(),
              emailInput(),
              tanggalLahirInput(),
              jurusanInput(),
              jenisInput(),
              ubahButton()
            ],
          ),
        ),
      ),
    );
  }
}
