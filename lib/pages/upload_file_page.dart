import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bkkmobile/shared/variabel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UploadFile extends StatefulWidget {
  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  FilePickerResult fileResult; // untuk mengambil filenya
  File _file; // informasi Filenya
  String _namaFile;
  String _pathFile;

  String _fileNameSuratLamaran = '...';

  bool loading = false;

  void _ambilFile() async {
    try {
      setState(() {
        loading = true;
      });

      fileResult = await FilePicker.platform.pickFiles(type: FileType.any);
      _file = File(fileResult.files.single.path);
      _namaFile = fileResult.files.single.name;
      _pathFile = fileResult.files.single.path;

      log("File Name : $_namaFile");
      log("FIle Path : $_pathFile");

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _uploadFile(File file) async {
    var stream = http.ByteStream(file.openRead())..cast();
    var length = await file.length();
    var url = Uri.parse("$baseUrl/upload_file_post");

    var request = http.MultipartRequest("POST", url);
    var multiPartFile = http.MultipartFile("filesurat", stream, length,
        filename: basename(file.path));

    request.files.add(multiPartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      log("Status : File Berhasil Diupload!");
    } else {
      log("Status : File Gagal Diupload......!");
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
                        _ambilFile();
                      },
                      icon: Icon(Icons.upload_file_rounded))
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Widget daftarRiwayatUpload() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Daftar Riwayat',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(height: 12),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.only(left: 20, right: 5),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _fileNameSuratLamaran,
    //                 style: primaryTextStyle.copyWith(color: secondaryTextColor),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     _ambilFile();
    //                   },
    //                   icon: Icon(Icons.upload_file_rounded))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget fotoUpload() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Foto',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(height: 12),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.only(left: 20, right: 5),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _fileNameSuratLamaran,
    //                 style: primaryTextStyle.copyWith(color: secondaryTextColor),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     _ambilFile();
    //                   },
    //                   icon: Icon(Icons.upload_file_rounded))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget ktpUpload() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'KTP',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(height: 12),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.only(left: 20, right: 5),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _fileNameSuratLamaran,
    //                 style: primaryTextStyle.copyWith(color: secondaryTextColor),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     _ambilFile();
    //                   },
    //                   icon: Icon(Icons.upload_file_rounded))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget skckUpload() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'SKCK',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(height: 12),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.only(left: 20, right: 5),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _fileNameSuratLamaran,
    //                 style: primaryTextStyle.copyWith(color: secondaryTextColor),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     _ambilFile();
    //                   },
    //                   icon: Icon(Icons.upload_file_rounded))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget ijazahUpload() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Ijazah',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(height: 12),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.only(left: 20, right: 5),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _fileNameSuratLamaran,
    //                 style: primaryTextStyle.copyWith(color: secondaryTextColor),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     _ambilFile();
    //                   },
    //                   icon: Icon(Icons.upload_file_rounded))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // Widget sertifikatUpload() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Sertifikat',
    //           style: primaryTextStyle.copyWith(
    //             fontSize: 16,
    //             fontWeight: medium,
    //           ),
    //         ),
    //         SizedBox(height: 12),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.only(left: 20, right: 5),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _fileNameSuratLamaran,
    //                 style: primaryTextStyle.copyWith(color: secondaryTextColor),
    //               ),
    //               IconButton(
    //                   onPressed: () {
    //                     _ambilFile();
    //                   },
    //                   icon: Icon(Icons.upload_file_rounded))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget ubahButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: TextButton(
          onPressed: () async {
            _uploadFile(_file);
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
              // daftarRiwayatUpload(),
              // fotoUpload(),
              // ktpUpload(),
              // skckUpload(),
              // ijazahUpload(),
              // sertifikatUpload(),
              ubahButton(),
            ],
          ),
        ),
      ),
    );
  }
}
