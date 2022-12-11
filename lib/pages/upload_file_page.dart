import 'dart:developer';
import 'dart:io';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/ubah_pass_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UploadFile extends StatefulWidget {
  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  FilePickerResult result;
  String _fileName;
  PlatformFile pickedFile;
  File fileToDisplay;

  final _passwordLamaController = TextEditingController();

  bool loading = false;

  void ambilFile() async {
    try {
      setState(() {
        loading = true;
      });

      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);

      if (result != null) {
        _fileName = result.files.first.name;
        pickedFile = result.files.first;
        fileToDisplay = File(pickedFile.path.toString());

        print("File Name : $_fileName");
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
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

    Widget ubahButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 50),
        child: TextButton(
          onPressed: () async {
            ambilFile();
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
              ubahButton(),
            ],
          ),
        ),
      ),
    );
  }
}
