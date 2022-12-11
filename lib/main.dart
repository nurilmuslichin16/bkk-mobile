import 'package:bkkmobile/pages/home/main_page.dart';
import 'package:bkkmobile/pages/loker_page.dart';
import 'package:bkkmobile/pages/profile_page%20.dart';
import 'package:bkkmobile/pages/sign_in_page.dart';
import 'package:bkkmobile/pages/sign_up_page.dart';
import 'package:bkkmobile/pages/splash_page.dart';
import 'package:bkkmobile/pages/ubah_pass_page.dart';
import 'package:bkkmobile/pages/ubah_profile_page.dart';
import 'package:bkkmobile/pages/upload_file_page.dart';
import 'package:bkkmobile/providers/loker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

String idPelamarUser;
String namaLengkapUser;
String usernameUser;
String alamatUser;
String nohpUser;
String emailUser;
String tanggalLahirUser;
String kewarganegaraanUser;
String jurusanUser;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getPreferen();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LokerProdvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignIn(),
          '/sign-up': (context) => SignUp(),
          '/home': (context) => MainPage(),
          '/loker': (context) => LokerPage(),
          '/upload-file': (context) => UploadFile(),
          '/profile': (context) => ProfilePage(),
          '/ubah-profile': (context) => UbahProfile(),
          '/ubah-pass': (context) => UbahPassword(),
        },
      ),
    );
  }

  Future getPreferen() async {
    preferences = await SharedPreferences.getInstance();
    var getidPelamar = preferences.getString('idPelamar');
    var getnamaLengkap = preferences.getString('namaLengkap');
    var getusername = preferences.getString('username');
    var getalamat = preferences.getString('alamat');
    var getnohp = preferences.getString('nohp');
    var getemail = preferences.getString('email');
    var gettanggalLahir = preferences.getString('tanggalLahir');
    var getkewarganegaraan = preferences.getString('kewarganegaraan');
    var getjurusan = preferences.getString('jurusan');
    setState(() {
      idPelamarUser = getidPelamar;
      namaLengkapUser = getnamaLengkap;
      usernameUser = getusername;
      alamatUser = getalamat;
      nohpUser = getnohp;
      emailUser = getemail;
      tanggalLahirUser = gettanggalLahir;
      kewarganegaraanUser = getkewarganegaraan;
      jurusanUser = getjurusan;
    });
  }
}
