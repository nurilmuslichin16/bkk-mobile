import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(0, 180, 216, 1),
        Color.fromRGBO(154, 220, 255, 1)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitCircle(
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Mohon menunggu...",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'roboto',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          )
        ],
      )),
    );
  }
}
