import 'dart:developer';

import 'package:bkkmobile/main.dart';
import 'package:bkkmobile/models/berkas_model.dart';
import 'package:bkkmobile/shared/variabel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadFile extends StatefulWidget {
  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String idDetailLoker;
  FilePickerResult _filesUpload;

  String _nameFileSurat = 'Pilih File...';
  String _nameFileRiwayat = 'Pilih File...';
  String _nameFileFoto = 'Pilih File...';
  String _nameFileKtp = 'Pilih File...';
  String _nameFileSkck = 'Pilih File...';
  String _nameFileIjazah = 'Pilih File...';
  String _nameFileSertifikat = 'Pilih File...';

  bool _statusUploadSurat = false;
  bool _statusUploadRiwayat = false;
  bool _statusUploadFoto = false;
  bool _statusUploadKtp = false;
  bool _statusUploadSkck = false;
  bool _statusUploadIjazah = false;
  bool _statusUploadSertifikat = false;

  bool loading = true;

  @override
  void initState() {
    cekBerkas();
    super.initState();
  }

  cekBerkas() async {
    await BerkasModel.getBerkas().then((value) => validasiBerkas(value));
  }

  validasiBerkas(BerkasModel berkas) {
    if (berkas.suratLamaran != 'empty') {
      setState(() {
        _statusUploadSurat = true;
        _nameFileSurat = "Berkas sudah terupload!";
      });
    }

    if (berkas.daftarRiwayat != 'empty') {
      setState(() {
        _statusUploadRiwayat = true;
        _nameFileRiwayat = "Berkas sudah terupload!";
      });
    }

    if (berkas.foto != 'empty') {
      setState(() {
        _statusUploadFoto = true;
        _nameFileFoto = "Berkas sudah terupload!";
      });
    }

    if (berkas.ktp != 'empty') {
      setState(() {
        _statusUploadKtp = true;
        _nameFileKtp = "Berkas sudah terupload!";
      });
    }

    if (berkas.skck != 'empty') {
      setState(() {
        _statusUploadSkck = true;
        _nameFileSkck = "Berkas sudah terupload!";
      });
    }

    if (berkas.ijazah != 'empty') {
      setState(() {
        _statusUploadIjazah = true;
        _nameFileIjazah = "Berkas sudah terupload!";
      });
    }

    if (berkas.sertifikat != 'empty') {
      setState(() {
        _statusUploadSertifikat = true;
        _nameFileSertifikat = "Berkas sudah terupload!";
      });
    }

    setState(() {
      loading = false;
    });
  }

  void _ambilFile(String jenis) async {
    try {
      setState(() {
        loading = true;
      });

      _filesUpload = await FilePicker.platform.pickFiles(
          type: FileType.any, allowMultiple: false, allowedExtensions: null);

      switch (jenis) {
        case 'surat':
          _nameFileSurat = _filesUpload.files.first.name;
          break;
        case 'riwayat':
          _nameFileRiwayat = _filesUpload.files.first.name;
          break;
        case 'foto':
          _nameFileFoto = _filesUpload.files.first.name;
          break;
        case 'ktp':
          _nameFileKtp = _filesUpload.files.first.name;
          break;
        case 'skck':
          _nameFileSkck = _filesUpload.files.first.name;
          break;
        case 'ijazah':
          _nameFileIjazah = _filesUpload.files.first.name;
          break;
        default:
          _nameFileSertifikat = _filesUpload.files.first.name;
          break;
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _uploadFile(String jenis) async {
    setState(() {
      loading = true;
    });

    if (_filesUpload == null) {
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
                      "File Kosong!",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Silahkan pilih file dahulu."),
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
    } else {
      var uri = Uri.parse("$baseUrl/upload_file_post");
      var request = http.MultipartRequest('POST', uri);

      request.fields['idPelamar'] = idPelamarUser;
      request.fields['jenis'] = jenis;
      request.fields['fileName'] =
          idPelamarUser + '-' + _filesUpload.files.first.name;
      request.files.add(await http.MultipartFile.fromPath(
          'fileUpload', _filesUpload.files.first.path,
          contentType:
              new MediaType('application', 'jpg|jpeg|png|pdf|docx|doc')));

      var response = await request.send();
      if (response.statusCode == 200) {
        switch (jenis) {
          case 'surat':
            _statusUploadSurat = true;
            break;
          case 'riwayat':
            _statusUploadRiwayat = true;
            break;
          case 'foto':
            _statusUploadFoto = true;
            break;
          case 'ktp':
            _statusUploadKtp = true;
            break;
          case 'skck':
            _statusUploadSkck = true;
            break;
          case 'ijazah':
            _statusUploadIjazah = true;
            break;
          default:
            _statusUploadSertifikat = true;
            break;
        }

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
                        child: Image.asset("assets/images/approved.png",
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Berhasil Upload!",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("File berhasil terupload."),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          onPressed: () {
                            _filesUpload = null;
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"))
                    ],
                  ),
                ),
              );
            });

        print("Status : File Uploaded");
      } else {
        print("Status : File Failed Upload");
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg = (ModalRoute.of(context).settings.arguments ??
        <String, dynamic>{}) as Map;
    idDetailLoker = arg['idDetailLoker'];

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
            Text('Silahkan upload berkas satu persatu.',
                style: subtitleTextStyle),
            SizedBox(
              height: 20,
            ),
            Text(
                '*Pastikan berkas sudah terupload sebelum kembali ke halaman sebelumnya!',
                style: subtitleTextStyle.copyWith(color: Colors.red))
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
            _statusUploadSurat
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileSurat.length >= 35
                              ? _nameFileSurat.substring(0, 35) + '...'
                              : _nameFileSurat,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('surat');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileSurat.length >= 15
                                      ? _nameFileSurat.substring(0, 15) + '...'
                                      : _nameFileSurat,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('surat');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
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
            _statusUploadRiwayat
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileRiwayat.length >= 35
                              ? _nameFileRiwayat.substring(0, 35) + '...'
                              : _nameFileRiwayat,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('riwayat');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileRiwayat.length >= 15
                                      ? _nameFileRiwayat.substring(0, 15) +
                                          '...'
                                      : _nameFileRiwayat,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('riwayat');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
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
            _statusUploadFoto
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileFoto.length >= 35
                              ? _nameFileFoto.substring(0, 35) + '...'
                              : _nameFileFoto,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('foto');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileFoto.length >= 15
                                      ? _nameFileFoto.substring(0, 15) + '...'
                                      : _nameFileFoto,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('foto');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
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
            _statusUploadKtp
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileKtp.length >= 35
                              ? _nameFileKtp.substring(0, 35) + '...'
                              : _nameFileKtp,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('ktp');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileKtp.length >= 15
                                      ? _nameFileKtp.substring(0, 15) + '...'
                                      : _nameFileKtp,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('ktp');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
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
            _statusUploadSkck
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileSkck.length >= 35
                              ? _nameFileSkck.substring(0, 35) + '...'
                              : _nameFileSkck,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('skck');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileSkck.length >= 15
                                      ? _nameFileSkck.substring(0, 15) + '...'
                                      : _nameFileSkck,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('skck');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
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
            _statusUploadIjazah
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileIjazah.length >= 35
                              ? _nameFileIjazah.substring(0, 35) + '...'
                              : _nameFileIjazah,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('ijazah');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileIjazah.length >= 15
                                      ? _nameFileIjazah.substring(0, 15) + '...'
                                      : _nameFileIjazah,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('ijazah');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
          ],
        ),
      );
    }

    Widget sertifikatUpload() {
      return Container(
        margin: EdgeInsets.only(top: 20, bottom: 50),
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
            _statusUploadSertifikat
                ? Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _nameFileSertifikat.length >= 35
                              ? _nameFileSertifikat.substring(0, 35) + '...'
                              : _nameFileSertifikat,
                          style: primaryTextStyle.copyWith(
                              color: secondaryTextColor),
                        ),
                        Icon(Icons.document_scanner)
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _ambilFile('sertifikat');
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _nameFileSertifikat.length >= 15
                                      ? _nameFileSertifikat.substring(0, 15) +
                                          '...'
                                      : _nameFileSertifikat,
                                  style: primaryTextStyle.copyWith(
                                      color: secondaryTextColor),
                                ),
                                Icon(Icons.document_scanner)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _uploadFile('sertifikat');
                            },
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Upload",
                                  style: buttonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
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
          child: ListView(
            children: [
              header(),
              suratLamaranUpload(),
              daftarRiwayatUpload(),
              fotoUpload(),
              ktpUpload(),
              skckUpload(),
              ijazahUpload(),
              sertifikatUpload()
            ],
          ),
        ),
      ),
    );
  }
}
