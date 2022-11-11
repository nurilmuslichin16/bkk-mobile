import 'package:bkkmobile/pages/widgets/loker_card.dart';
import 'package:bkkmobile/pages/widgets/loker_tile.dart';
import 'package:flutter/material.dart';
import 'package:bkkmobile/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, Indra',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@indra',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/icon_user.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Loker terbaru',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: [
                  LokerCard(),
                  LokerCard(),
                  LokerCard(),
                  LokerCard(),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget newArivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Daftar loker',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArivals() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: Column(
          children: [
            LokerTile(),
            LokerTile(),
            LokerTile(),
            LokerTile(),
            LokerTile(),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        popularProductsTitle(),
        popularProducts(),
        newArivalsTitle(),
        newArivals(),
      ],
    );
  }
}
