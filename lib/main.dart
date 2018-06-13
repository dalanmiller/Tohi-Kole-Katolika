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
          Navigator.push(context, new MaterialPageRoute<DismissDialogAction>(
            builder: (BuildContext context) => new PrayerPopUpPage(prayer: prayer),
            fullscreenDialog: true,
          ))
//          showDialog(
//         context: context,
//         builder: (context) => buildPrayerPage(context, prayer),

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

//  Widget buildListTile(BuildContext context, String item) {
//    return new ListTile();
//    Widget secondary;
//    if (_itemType == _MaterialListType.twoLine) {
//      secondary = const Text('Additional item information.');
//    } else if (_itemType == _MaterialListType.threeLine) {
//      secondary = const Text(
//        'Even more additional list item information appears on line three.',
//      );
//    }
//    return new MergeSemantics(
//      child: new ListTile(
//        isThreeLine: _itemType == _MaterialListType.threeLine,
//        dense: _dense,
//        leading: _showAvatars ? new ExcludeSemantics(child: new CircleAvatar(child: new Text(item))) : null,
//        title: new Text('This item represents $item.'),
//        subtitle: secondary,
//        trailing: _showIcons ? new Icon(Icons.info, color: Theme.of(context).disabledColor) : null,
//      ),
//    );
//  }
//  Widget _listTileBuilder(BuildContext context, int index){
//    return new Container(
//      padding: const EdgeInsets.only(left:  16.0),
//      child: Text(_prayers[index].nameTongan,
//      style: Theme.of(context).textTheme.headline),
//    )
//  }
//
//  });
//
//  @override
//  Widget build(BuildContext context) {
//
//    return new Scaffold(
////      key: new Key("1"),
//      appBar: new AppBar(
//          title: new Text("Tohi Kole Katolika",
//              style: new TextStyle(
//                fontWeight: FontWeight.w800,
//                fontFamily: "Vollkorn",
//                fontSize: 32.0,
//                color: Colors.white,
//              )
//          )
//      ),
//      body: new Scrollbar(
//        child: new ListView(
//          padding: new EdgeInsets.symmetric(vertical: 4.0),
//          children: listTiles.toList(),
//        ),
//      ),
//    );
//  }
//}

//class PrayerPage extends StatefulWidget {
//    const PrayerPage({ Key key }) : super(key: key);
//
//    @override
//    _PrayerPageState createState() => new _PrayerPageState();
//}
//
//class _PrayerPageState extends State<PrayerPage>{
//
//  bool isFavorite = false;
//
//  void _toggleFavorite(){
//    setState((){
//      isFavorite = !isFavorite;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Widget prayerSection = new Container(
//        padding: const EdgeInsets.all(16.0),
//        child: new Row(
//            children: [
//              new Expanded(
//                  child: new Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        new Container(
//                            padding: const EdgeInsets.only(bottom: 8.0),
//                            child: new Text(
//                                "Ndavwana ndi Ada Achiuta Mulengi / The Apostles' Creed / Credo",
//                                style: new TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  fontFamily: 'Vollkorn',
//                                  fontSize: 18.0,
//                                )
//                            )
//                        )
//                      ])
//              ),
//              new FloatingActionButton(
//                child: new Icon(
//                  isFavorite ? Icons.favorite : Icons.favorite_border,
//                  color: Colors.white,
//                ),
//                onPressed: _toggleFavorite,
//                backgroundColor: Colors.red,
//              )
//            ]
//        )
//    );
//
//    Column buildButtonColumn(IconData icon, String label) {
//      Color color = Theme
//          .of(context)
//          .primaryColor;
//
//      return new Column(
//        mainAxisSize: MainAxisSize.min,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          new Icon(icon, color: color),
//          new Container(
//            margin: const EdgeInsets.only(top: 8.0),
//            child: new Text(
//              label,
//              style: new TextStyle(
//                fontSize: 12.0,
//                fontWeight: FontWeight.w400,
//                color: color,
//              ),
//            ),
//          ),
//        ],
//      );
//    }
//  }
//
//    Widget navBarBottom = new BottomNavigationBar(
//      items: const <BottomNavigationBarItem>[
//        const BottomNavigationBarItem(
//          icon: const Icon(Icons.menu),
//          title: const Text("Menu"),
//        ),
//        const BottomNavigationBarItem(
//          icon: const Icon(Icons.menu),
//          title: const Text("Menu"),
//        )
//      ]
//    );
//
//    Widget textSection = new Container(
//      padding: const EdgeInsets.all(32.0),
//      child: new Text(
//        '''
//Ndavwana ndi Ada Achiuta
//Mulengi wakuchanya ndi charu chapasi
//Ndi Mwaku Yesu Kristu, Mwana waki yija wada widu
//Kuziya mwa muzimu utuwa,
//wanguwa mwa ku Maria
//Wangusuzgika ndi Apolinto Pilato,
//wangukhomeka pa mpinjika,
//wangufwa ndikuwikika mu muwunda ndi kuja ndiwakufwa
//Zuwa lachitatu wanguwuka ku wakufwa
//Wakuluta KuChanya,
//Ndikuja kujanja la Maryi la KuChiuta Ada wantazi yosi
//Kutuwiya kuchanya wazengu kwajeluzga wamoyo ndi wakufwa
//Ndigomezga mu mzimu utuwa
//Ndigomezga tchalichi la Katolika
//watuwa ndi wumoza wawu wa wangelo
//Kugowokereka Mpulupulu
//Kuuka Kwa Wakufwa
//Kuja ndi Umoyo wambura kumala. Amen.
//        ''',
//        softWrap: false,
//        style: new TextStyle(
//          fontSize: 16.0,
//          fontFamily: 'Vollkorn',
//        ),
//      ),
//    );
//
//    return new MaterialApp(
//      title: 'Tohi Kole Katolika',
//      theme: new ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.lightBlue,
//      ),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Tohi Kole Katolika",
//            style: new TextStyle(
//              fontWeight: FontWeight.w800,
//              fontFamily: "Vollkorn",
//              fontSize: 32.0,
//              color: Colors.white,
//            )
//          )
//        ),
//        body: new ListView(children: [
//          prayerSection,
//          // buttonSection,
//          textSection,
//        ],),
//        bottomNavigationBar: navBarBottom,
//      ),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return new Scaffold(
//      appBar: new AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: new Text(widget.title),
//      ),
//      body: new Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: new Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug paint" (press "p" in the console where you ran
//          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
//          // window in IntelliJ) to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            new Text(
//              'You have pushed the button this many times:',
//            ),
//            new Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.threesixty),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
//
//class Prayers extends StatelessWidget{
//
//  @override
//  Widget build(BuildContext context) {
//    // final wordPair = new WordPair.random();
//    // return new Text(wordPair.asPascalCase);
//    return new Scaffold (
//      appBar: new AppBar(
//        title: new Text("Tongan Prayers"),
//      )
//    );
//  }
//
//  // Widget _buildSuggestions() {
//  //   return new ListView.builder(
//  //     padding: const EdgeInsets.all(16.0),
//  //     // The itemBuilder callback is called once per suggested word pairing,
//  //     // and places each suggestion into a ListTile row.
//  //     // For even rows, the function adds a ListTile row for the word pairing.
//  //     // For odd rows, the function adds a Divider widget to visually
//  //     // separate the entries. Note that the divider may be difficult
//  //     // to see on smaller devices.
//  //     itemBuilder: (context, i) {
//  //       // Add a one-pixel-high divider widget before each row in theListView.
//  //       if (i.isOdd) return new Divider();
//
//  //       // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
//  //       // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
//  //       // This calculates the actual number of word pairings in the ListView,
//  //       // minus the divider widgets.
//  //       final index = i ~/ 2;
//  //       // If you've reached the end of the available word pairings...
//  //       if (index >= _suggestions.length) {
//  //         // ...then generate 10 more and add them to the suggestions list.
//  //         _suggestions.addAll(generateWordPairs().take(10));
//  //       }
//  //       return _buildRow(_suggestions[index]);
//  //     }
//  //   );
//  // }
//}
//
//class NavigationIconView {
//  NavigationIconView({
//    Widget icon,
//    String title,
//    Color color,
//    TickerProvider vsync,
//  }) : _icon = icon,
//       _color = color,
//       _title = title,
//       item = new BottomNavigationBarItem(
//         icon: icon,
//         title: new Text(title),
//         backgroundColor: color,
//       ),
//       controller = new AnimationController(
//         duration: kThemeAnimationDuration,
//         vsync: vsync,
//       ) {
//  }
//
//  final Widget _icon;
//  final Color _color;
//  final String _title;
//  final BottomNavigationBarItem item;
//  final AnimationController controller;
//
//}
//
//class CustomIcon extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final IconThemeData iconTheme = IconTheme.of(context);
//    return new Container(
//      margin: const EdgeInsets.all(4.0),
//      width: iconTheme.size - 8.0,
//      height: iconTheme.size - 8.0,
//      color: iconTheme.color,
//    );
//  }
//}
//
//class BottomNavigationDemo extends StatefulWidget {
//  static const String routeName = '/material/bottom_navigation';
//
//  @override
//  _BottomNavigationDemoState createState() => new _BottomNavigationDemoState();
//}
//
//class _BottomNavigationDemoState extends State<BottomNavigationDemo>
//    with TickerProviderStateMixin {
//  int _currentIndex = 0;
//  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
//  List<NavigationIconView> _navigationViews;
//
//  @override
//  void initState() {
//    super.initState();
//    _navigationViews = <NavigationIconView>[
//      new NavigationIconView(
//        icon: const Icon(Icons.access_alarm),
//        title: 'Alarm',
//        color: Colors.deepPurple,
//        vsync: this,
//      ),
//      new NavigationIconView(
//        icon: new CustomIcon(),
//        title: 'Box',
//        color: Colors.deepOrange,
//        vsync: this,
//      ),
//      new NavigationIconView(
//        icon: const Icon(Icons.cloud),
//        title: 'Cloud',
//        color: Colors.teal,
//        vsync: this,
//      ),
//      new NavigationIconView(
//        icon: const Icon(Icons.favorite),
//        title: 'Favorites',
//        color: Colors.indigo,
//        vsync: this,
//      ),
//      new NavigationIconView(
//        icon: const Icon(Icons.event_available),
//        title: 'Event',
//        color: Colors.pink,
//        vsync: this,
//      )
//    ];
//
//    for (NavigationIconView view in _navigationViews)
//      view.controller.addListener(_rebuild);
//
//    _navigationViews[_currentIndex].controller.value = 1.0;
//  }
//
//  @override
//  void dispose() {
//    for (NavigationIconView view in _navigationViews)
//      view.controller.dispose();
//    super.dispose();
//  }
//
//  void _rebuild() {
//    setState(() {
//      // Rebuild in order to animate views.
//    });
//  }
//
//  Widget _buildTransitionsStack() {
//    final List<FadeTransition> transitions = <FadeTransition>[];
//
//    // for (NavigationIconView view in _navigationViews)
//    //   transitions.add(view.transition(_type, context));
//
//    // We want to have the newly animating (fading in) views on top.
//    transitions.sort((FadeTransition a, FadeTransition b) {
//      final Animation<double> aAnimation = a.opacity;
//      final Animation<double> bAnimation = b.opacity;
//      final double aValue = aAnimation.value;
//      final double bValue = bAnimation.value;
//      return aValue.compareTo(bValue);
//    });
//
//    return new Stack(children: transitions);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final BottomNavigationBar botNavBar = new BottomNavigationBar(
//      items: _navigationViews
//          .map((NavigationIconView navigationView) => navigationView.item)
//          .toList(),
//      currentIndex: _currentIndex,
//      type: _type,
//      onTap: (int index) {
//        setState(() {
//          _navigationViews[_currentIndex].controller.reverse();
//          _currentIndex = index;
//          _navigationViews[_currentIndex].controller.forward();
//        });
//      },
//    );
//
//    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text('Bottom navigation'),
//        actions: <Widget>[
//          new PopupMenuButton<BottomNavigationBarType>(
//            onSelected: (BottomNavigationBarType value) {
//              setState(() {
//                _type = value;
//              });
//            },
//            itemBuilder: (BuildContext context) => <PopupMenuItem<BottomNavigationBarType>>[
//              const PopupMenuItem<BottomNavigationBarType>(
//                value: BottomNavigationBarType.fixed,
//                child: const Text('Fixed'),
//              ),
//              const PopupMenuItem<BottomNavigationBarType>(
//                value: BottomNavigationBarType.shifting,
//                child: const Text('Shifting'),
//              )
//            ],
//          )
//        ],
//      ),
//      body: new Center(
//        child: _buildTransitionsStack()
//      ),
//      bottomNavigationBar: botNavBar,
//    );
//  }
//}
enum DismissDialogAction {
  cancel,
  discard,
  save,
}

//Widget buildFullScreenPrayer(BuildContext context, Prayer prayer) {
//  return
//}

class PrayerPopUpPage extends StatelessWidget {
  PrayerPopUpPage({this.prayer});

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
//          title: new Text(prayer.nameTongan),
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

//class FullScreenDialogDemoState extends State<FullScreenDialogDemo> {
//  DateTime _fromDateTime = new DateTime.now();
//  DateTime _toDateTime = new DateTime.now();
//  bool _allDayValue = false;
//  bool _saveNeeded = false;
//  bool _hasLocation = false;
//  bool _hasName = false;
//  String _eventName;
//
//  Future<bool> _onWillPop() async {
//    _saveNeeded = _hasLocation || _hasName || _saveNeeded;
//    if (!_saveNeeded)
//      return true;
//
//    final ThemeData theme = Theme.of(context);
//    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);
//
//    return await showDialog<bool>(
//      context: context,
//      builder: (BuildContext context) {
//        return new AlertDialog(
//          content: new Text(
//              'Discard new event?',
//              style: dialogTextStyle
//          ),
//          actions: <Widget>[
//            new FlatButton(
//                child: const Text('CANCEL'),
//                onPressed: () {
//                  Navigator.of(context).pop(false); // Pops the confirmation dialog but not the page.
//                }
//            ),
//            new FlatButton(
//                child: const Text('DISCARD'),
//                onPressed: () {
//                  Navigator.of(context).pop(true); // Returning true to _onWillPop will pop again.
//                }
//            )
//          ],
//        );
//      },
//    ) ?? false;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//
//    return new Scaffold(
//      appBar: new AppBar(
//          title: new Text(_hasName ? _eventName : 'Event Name TBD'),
//          actions: <Widget> [
//            new FlatButton(
//                child: new Text('SAVE', style: theme.textTheme.body1.copyWith(color: Colors.white)),
//                onPressed: () {
//                  Navigator.pop(context, DismissDialogAction.save);
//                }
//            )
//          ]
//      ),
//      body: new Form(
//          onWillPop: _onWillPop,
//          child: new ListView(
//              padding: const EdgeInsets.all(16.0),
//              children: <Widget>[
//                new Container(
//                    padding: const EdgeInsets.symmetric(vertical: 8.0),
//                    alignment: Alignment.bottomLeft,
//                    child: new TextField(
//                        decoration: const InputDecoration(
//                            labelText: 'Event name',
//                            filled: true
//                        ),
//                        style: theme.textTheme.headline,
//                        onChanged: (String value) {
//                          setState(() {
//                            _hasName = value.isNotEmpty;
//                            if (_hasName) {
//                              _eventName = value;
//                            }
//                          });
//                        }
//                    )
//                ),
//                new Container(
//                    padding: const EdgeInsets.symmetric(vertical: 8.0),
//                    alignment: Alignment.bottomLeft,
//                    child: new TextField(
//                        decoration: const InputDecoration(
//                            labelText: 'Location',
//                            hintText: 'Where is the event?',
//                            filled: true
//                        ),
//                        onChanged: (String value) {
//                          setState(() {
//                            _hasLocation = value.isNotEmpty;
//                          });
//                        }
//                    )
//                ),
////                new Column(
////                    crossAxisAlignment: CrossAxisAlignment.start,
////                    children: <Widget>[
////                      new Text('From', style: theme.textTheme.caption),
////                      new DateTimeItem(
////                          dateTime: _fromDateTime,
////                          onChanged: (DateTime value) {
////                            setState(() {
////                              _fromDateTime = value;
////                              _saveNeeded = true;
////                            });
////                          }
////                      )
////                    ]
////                ),
////                new Column(
////                    crossAxisAlignment: CrossAxisAlignment.start,
////                    children: <Widget>[
////                      new Text('To', style: theme.textTheme.caption),
////                      new DateTimeItem(
////                          dateTime: _toDateTime,
////                          onChanged: (DateTime value) {
////                            setState(() {
////                              _toDateTime = value;
////                              _saveNeeded = true;
////                            });
////                          }
////                      ),
////                      const Text('All-day'),
////                    ]
////                ),
////                new Container(
////                    decoration: new BoxDecoration(
////                        border: new Border(bottom: new BorderSide(color: theme.dividerColor))
////                    ),
////                    child: new Row(
////                        children: <Widget> [
////                          new Checkbox(
////                              value: _allDayValue,
////                              onChanged: (bool value) {
////                                setState(() {
////                                  _allDayValue = value;
////                                  _saveNeeded = true;
////                                });
////                              }
////                          ),
////                          const Text('All-day'),
////                        ]
////                    )
////                )
//              ]
//                  .map((Widget child) {
//                return new Container(
//                    padding: const EdgeInsets.symmetric(vertical: 8.0),
//                    height: 96.0,
//                    child: child
//                );
//              })
//                  .toList()
//          )
//      ),
//    );
//  }
//}