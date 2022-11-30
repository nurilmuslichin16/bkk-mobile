import 'package:bkkmobile/providers/loker_provider.dart';
import 'package:bkkmobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() {
    // await Provider.of<LokerProdvider>(context, listen: false).getLokers();
    // Navigator.pushNamed(context, '/sign-in');
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/sign-in', (Route route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/SMKKESESI.png'),
            ),
          ),
        ),
      ),
    );
  }
}
