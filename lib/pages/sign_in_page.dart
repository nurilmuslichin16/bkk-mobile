import 'dart:developer';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SharedPreferences preferences;

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool loading = false;

  Future setPreferenLogin(idPelamar, namaLengkap, username, alamat, nohp, email,
      tanggalLahir, kewarganegaraan, jurusan) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('idPelamar', idPelamar);
    preferences.setString('namaLengkap', namaLengkap);
    preferences.setString('username', username);
    preferences.setString('alamat', alamat);
    preferences.setString('nohp', nohp);
    preferences.setString('email', email);
    preferences.setString('tanggalLahir', tanggalLahir);
    preferences.setString('kewarganegaraan', kewarganegaraan);
    preferences.setString('jurusan', jurusan);
    setState(() {
      idPelamarUser = idPelamar;
      namaLengkapUser = namaLengkap;
      usernameUser = username;
      alamatUser = alamat;
      nohpUser = nohp;
      emailUser = email;
      tanggalLahirUser = tanggalLahir;
      kewarganegaraanUser = kewarganegaraan;
      jurusanUser = jurusan;
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
              'Login',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text('Masuk untuk menggunakan aplikasi', style: subtitleTextStyle)
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 70),
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
                          hintText: 'Masukan username anda',
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

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
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
                        controller: _passwordController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukan Password anda',
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

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 50),
        child: TextButton(
          onPressed: () async {
            // Navigator.pushNamed(context, '/home');
            var username = _usernameController.text;
            var password = _passwordController.text;

            setState(() {
              loading = true;
            });

            if (username != "" && password != "") {
              await LoginModel.postLogin(username, password).then((value) => {
                    if (value.status != false)
                      {
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
                                        child: Image.asset(
                                            "assets/images/approved.png",
                                            fit: BoxFit.cover),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        "Berhasil Login",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text("Selamat Anda berhasil login"),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setPreferenLogin(
                                                    value.idPelamar,
                                                    value.namaLengkap,
                                                    value.username,
                                                    value.alamat,
                                                    value.nohp,
                                                    value.email,
                                                    value.tanggalLahir,
                                                    value.kewarganegaraan,
                                                    value.jurusan)
                                                .whenComplete(() =>
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
                                '/home', (Route route) => false))
                      }
                    else
                      {
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
                              "Gagal Login",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text("Username dan Password tidak boleh kosong!"),
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
                  'Login',
                  style: buttonTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun ? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                'Register',
                style: priceTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
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
              usernameInput(),
              passwordInput(),
              signInButton(),
              Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
