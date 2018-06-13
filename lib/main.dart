import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:material_search/material_search.dart';

import 'package:intl/intl.dart';

void main() => runApp(const TohiKoleKatolika());

class Prayer {
  const Prayer(
      {this.nameTongan,
      this.nameEnglish,
      this.section,
      this.number,
      this.text});

  final String nameTongan, nameEnglish, section, text;
  final int number;
}

class TohiKoleKatolika extends StatelessWidget {
  const TohiKoleKatolika();

  @override
  Widget build(BuildContext context) {
    String s = "GO WORLD";
    print(s);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Vollkorn',
      ),
      home: PrayerList(prayers: new List<Prayer>()),
    );
  }
}

class PrayerList extends StatefulWidget {
  final List<Prayer> prayers;

  PrayerList({Key key, @required this.prayers}) : super(key: key);

  @override
  _PrayerListState createState() => new _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  List<Prayer> _prayers;

  Future<String> loadPrayers() async {
    return await rootBundle.loadString('assets/prayers.json');
  }

  void initState() {
    super.initState();
    loadPrayers().then((String contents) {
      print(contents);
      Map<String, dynamic> prayerJSON = JSON.decode(contents);
      List<Prayer> prayers = new List<Prayer>();
      print(prayerJSON);
      for (var prayer in prayerJSON['prayers']) {
        prayers.add(Prayer(
          nameTongan: prayer["name_tongan"],
          nameEnglish: prayer['name_english'],
          section: prayer['section'],
          number: prayer['number'],
          text: prayer['text'],
        ));
      }

      setState(() {
        _prayers = prayers;
      });
    });
  }

  Widget buildPrayerPage(BuildContext context, Prayer prayer) {
    return new SimpleDialog(
//      contentPadding: EdgeInsets.,
      title: new Text(prayer.nameTongan,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Vallkorn',
        fontSize: 18.0,
      )),
      children: [
//          Container(
//              padding: const EdgeInsets.only(bottom: 8.0),
//              child: new Text(prayer.nameTongan,
//                  style: new TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontFamily: 'Vollkorn',
//                    fontSize: 18.0,
//                  ))),
          // buttonSection,
          Container(
            padding: const EdgeInsets.all(16.0),
            child: new Text(
              prayer.text,
//              softWrap: false,
              style: new TextStyle(
                fontSize: 16.0,
                fontFamily: 'Vollkorn',
              ),
            ),
          ),
        ]
      );
  }

  Widget buildListTile(BuildContext context, Prayer prayer) {
    String subtitle;
    if (prayer.text.length >= 100) {
      subtitle = prayer.text.substring(0, 100) + "...";
    } else {
      subtitle = prayer.text + "...";
    }
    return new ListTile(
      title: new Text(prayer.nameTongan,
          style: new TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Vollkorn',
          )),
      subtitle: new Text(subtitle),
      onTap: () =>
          Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context) => new PrayerPopUpPage(prayer: prayer),
            fullscreenDialog: true,
          ))
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listTiles;
    // Ensure prayers have been read from JSON file.
    if (_prayers != null) {
      listTiles = _prayers.map((Prayer prayer) => buildListTile(context, prayer));
    }

    return new Scaffold(
//      key: new Key("1"),
      appBar: new AppBar(
          title: new Text("Tohi Kole Katolika",
              style: new TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: "Vollkorn",
                fontSize: 24.0,
                color: Colors.white,
              )),
          actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () =>
                  print('hi'),
              )
          ]),
      body:
         new Scrollbar(
        child: new ListView(
          padding: new EdgeInsets.symmetric(vertical: 4.0),
          children: listTiles != null ? listTiles.toList() : <Widget>[],
        ),
      ),
    );
  }
}

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class PrayerPopUpPage extends StatelessWidget {
  PrayerPopUpPage({this.prayer});

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
      ),
      body: new Container(
        child: new Column(
          children: [
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: new Text(
                prayer.nameTongan,
                style: new TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 32.0,
                )
              ),
              alignment: Alignment.centerLeft,
            ),
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: new Text(
                prayer.text,
                style: new TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                )
              )
            )
          ]
        )
      )
    );
  }
}
