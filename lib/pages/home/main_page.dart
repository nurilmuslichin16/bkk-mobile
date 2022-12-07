import 'package:flutter/material.dart';
import 'package:bkkmobile/pages/home/cart_page.dart';
import 'package:bkkmobile/pages/home/home_page.dart';
import 'package:bkkmobile/theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          child: BottomNavigationBar(
            backgroundColor: backgroundColor2,
            currentIndex: currentIndex,
            onTap: (value) {
              print(value);
              setState(() {
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Icon(Icons.home,
                      color: currentIndex == 0 ? primaryColor : Colors.black),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Icon(Icons.history,
                      color: currentIndex == 1 ? primaryColor : Colors.black),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return CartPage();
          break;

        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
