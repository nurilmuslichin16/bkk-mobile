import 'package:bkkmobile/pages/home/main_page.dart';
import 'package:bkkmobile/pages/loker_page.dart';
import 'package:bkkmobile/pages/sign_in_page.dart';
import 'package:bkkmobile/pages/sign_up_page.dart';
import 'package:bkkmobile/pages/splash_page.dart';
import 'package:bkkmobile/providers/loker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        },
      ),
    );
  }
}
