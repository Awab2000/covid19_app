import 'package:flutter/material.dart';
import 'package:flutter_covid19/data_source.dart';
import 'package:flutter_covid19/localizations/localization_methods.dart';
import 'package:flutter_covid19/pages/faq.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container
      (
      child: Column
        (
        children:
        [
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage() ));
            },
            child: Container
              (
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: primaryBlack,
              child: Row
                (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text
                    (
                    getTranslated(context, 'FAQ'),
                    style: TextStyle
                      (
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Icon
                    (
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()
            {
              launch('https://covid19responsefund.org/');
            },
            child: Container
              (
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: primaryBlack,
              child: Row
                (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text
                    (
                    getTranslated(context, 'DONATE'),
                    style: TextStyle
                      (
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Icon
                    (
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()
            {
              launch('https://www.who.int/indonesia/news/novel-coronavirus/mythbusters');
            },
            child: Container
              (
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: primaryBlack,
              child: Row
                (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text
                    (
                    getTranslated(context, 'MYTH_BUSTERS'),
                    style: TextStyle
                      (
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Icon
                    (
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
