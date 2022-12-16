import 'dart:developer';
import 'dart:io';

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
  PlatformFile pickedFile;
  File fileToDisplay;

  String _fileNameSuratLamaran = '...';

  bool loading = false;

  void ambilFile() async {
    try {
      setState(() {
        loading = true;
      });

      result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);

      if (result != null) {
        _fileNameSuratLamaran = result.files.first.name;
        pickedFile = result.files.first;
        fileToDisplay = File(pickedFile.path.toString());

        print("File Name : $_fileNameSuratLamaran");
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
              'Upload Berkas Lamaran',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text('Silahkan upload berkas yang dibutuhkan.',
                style: subtitleTextStyle)
          ],
        ),
      );
    }

    Widget suratLamaranUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Surat Lamaran',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget daftarRiwayatUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Riwayat',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget fotoUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget ktpUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KTP',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget skckUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SKCK',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget ijazahUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ijazah',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget sertifikatUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sertifikat',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fileNameSuratLamaran,
                    style: primaryTextStyle.copyWith(color: secondaryTextColor),
                  ),
                  IconButton(
                      onPressed: () {
                        ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
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
                  'Upload Berkas',
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
              suratLamaranUpload(),
              daftarRiwayatUpload(),
              fotoUpload(),
              ktpUpload(),
              skckUpload(),
              ijazahUpload(),
              sertifikatUpload(),
              ubahButton(),
            ],
          ),
        ),
      ),
    );
  }
}
