import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_covid19/data_source.dart';
import 'package:flutter_covid19/localizations/localization_methods.dart';
import 'package:flutter_covid19/pages/country_page.dart';
import 'package:flutter_covid19/panels/info_panel.dart';
import 'package:flutter_covid19/panels/most_affected.dart';
import 'package:flutter_covid19/panels/world_wide_panel.dart';
import 'package:http/http.dart' as http;

import 'localizations/models.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
  fetchWorldWideData() async
  {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countriesData;
  fetchCountriesWideData() async
  {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
    });
  }

  Map historyData;

  fetchHistoryData() async
  {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/historical/all");
    setState(() {
      historyData = json.decode(response.body);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWorldWideData();
    fetchCountriesWideData();
    fetchHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(
        centerTitle: false,
        title: Text(getTranslated(context, 'COVID-19_Panel')),
        actions:
        [
          Padding
            (
            padding: EdgeInsets.all(8),
            child: DropdownButton
              (
              underline: SizedBox(),
              icon: Icon
                (
                Icons.language,
                color: Colors.white,
              ),
              items: Language.languageList().map<DropdownMenuItem<Language>>((lang) =>
                  DropdownMenuItem
                    (
                    value: lang,
                    child: Row
                      (
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                      [
                        Text
                          (
                          lang.flag,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(lang.name)
                      ],
                    ),
                  )
              ).toList(),
              onChanged: (Language lang)
              {
                _changeLanguage(lang);
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView
        (
        child: Column
          (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container
              (
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              color: Colors.orange[100],
              child: Text
                (
                getLangCode(context) == ARABIC ? DataSource.quoteAr : DataSource.quote,
                  style: TextStyle
                    (
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text(
                    getTranslated(context, 'Worldwide'),
                    style: TextStyle
                      (
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPage() ));
                    },
                    child: Container(
                      decoration: BoxDecoration
                        (
                        borderRadius: BorderRadius.circular(15),
                        color: primaryBlack
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        getTranslated(context, 'Regional'),
                        style: TextStyle
                          (
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null? CircularProgressIndicator() : WorldWidePanel(
              worldWide: worldData, historyData: historyData,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                getTranslated(context, 'Most_Affected'),
                style: TextStyle
                  (
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 10,),
            countriesData == null? Container() : MostAffectedPanel(countryData: countriesData,),
            SizedBox(height: 5,),
            InfoPanel(),
            SizedBox(height: 10,),
            Center(
              child: Text(getTranslated(context, 'WE_ARE_TOGETHER_IN_THIS'),
              style: TextStyle
                (
                color: primaryBlack,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }

  void _changeLanguage(Language lang) async
  {
    Locale _temp = await setLocale(lang.languageCode);
    MyApp.setLocale(context, _temp);
  }

}
