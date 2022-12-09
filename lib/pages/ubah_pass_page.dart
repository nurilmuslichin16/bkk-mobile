import 'dart:developer';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/login_model.dart';
import 'package:bkkmobile/models/ubah_pass_model.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UbahPassword extends StatefulWidget {
  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  SharedPreferences preferences;

  final _passwordLamaController = TextEditingController();

  final _passwordBaruController = TextEditingController();

  final _passwordKonfirmController = TextEditingController();

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
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ubah Password',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text('Silahkan masukkan password lama dan terbaru.',
                style: subtitleTextStyle)
          ],
        ),
      );
    }

    Widget passwordLamaInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Lama',
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
                      Icons.lock,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        obscureText: true,
                        controller: _passwordLamaController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Password lama anda',
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

    Widget passwordBaruInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Baru',
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
                      Icons.lock,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        obscureText: true,
                        controller: _passwordBaruController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Password baru anda',
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

    Widget passwordBaruKonfirmInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konfirmasi Password Baru',
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
                      Icons.lock,
                      size: 20.0,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        obscureText: true,
                        controller: _passwordKonfirmController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Ulangi Password baru anda',
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

    Widget ubahButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 50),
        child: TextButton(
          onPressed: () async {
            // Navigator.pushNamed(context, '/home');
            var passLama = _passwordLamaController.text;
            var passBaru = _passwordBaruController.text;
            var passKonfirm = _passwordKonfirmController.text;

            setState(() {
              loading = true;
            });

            if (passBaru == passKonfirm) {
              if (passLama != "" && passBaru != "" && passKonfirm != "") {
                await UbahPassModel.postUbahPassword(
                        usernameUser, passLama, passBaru)
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
                                              "Berhasil Update",
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
                                                  logout().whenComplete(() =>
                                                      Navigator.of(context)
                                                          .pop());
                                                },
                                                child: const Text("OK"))
                                          ],
                                        ),
                                      ),
                                    );
                                  }).then((value) => Navigator.of(
                                      context)
                                  .pushNamedAndRemoveUntil(
                                      '/sign-in', (Route route) => false))
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
                                              "Gagal Login",
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
                                "Gagal Mengubah Password",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "Password Lama dan Password Baru tidak boleh kosong!"),
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
                              "Gagal Mengubah Password",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Password Lama dan Password Baru tidak sama!"),
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
                  'Ubah Password',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              passwordLamaInput(),
              passwordBaruInput(),
              passwordBaruKonfirmInput(),
              ubahButton(),
            ],
          ),
        ),
      ),
    );
  }
}
