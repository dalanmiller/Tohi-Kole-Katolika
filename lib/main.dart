import 'package:flutter/material.dart';

void main() => runApp(new TohiKoleKatolika());

class TohiKoleKatolika extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => new TonganPrayerHome();
}


class TonganPrayerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const PrayerPage();
  }
}

class PrayerPage extends StatefulWidget {
    const PrayerPage({ Key key }) : super(key: key);

    @override
    _PrayerPageState createState() => new _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage>{

  bool isFavorite = false;

  void _toggleFavorite(){
    setState((){
      isFavorite = !isFavorite;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    Widget prayerSection = new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    "Ndavwana ndi Ada Achiuta Mulengi / The Apostles' Creed / Credo",   
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Vollkorn',
                      fontSize: 18.0,
                    )
                  )
                )
            ])
          ),
          new FloatingActionButton(
            child: new Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                    ),
            onPressed: _toggleFavorite,
            backgroundColor: Colors.red,
          )
        ]
      )
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget navBarBottom = new BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          title: const Text("Menu"),
        ), 
        const BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          title: const Text("Menu"),
        )
      ]
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Ndavwana ndi Ada Achiuta 
Mulengi wakuchanya ndi charu chapasi 
Ndi Mwaku Yesu Kristu, Mwana waki yija wada widu 
Kuziya mwa muzimu utuwa, 
wanguwa mwa ku Maria 
Wangusuzgika ndi Apolinto Pilato, 
wangukhomeka pa mpinjika, 
wangufwa ndikuwikika mu muwunda ndi kuja ndiwakufwa 
Zuwa lachitatu wanguwuka ku wakufwa 
Wakuluta KuChanya, 
Ndikuja kujanja la Maryi la KuChiuta Ada wantazi yosi 
Kutuwiya kuchanya wazengu kwajeluzga wamoyo ndi wakufwa 
Ndigomezga mu mzimu utuwa 
Ndigomezga tchalichi la Katolika 
watuwa ndi wumoza wawu wa wangelo 
Kugowokereka Mpulupulu 
Kuuka Kwa Wakufwa 
Kuja ndi Umoyo wambura kumala. Amen.
        ''',
        softWrap: false,
        style: new TextStyle(
          fontSize: 16.0,
          fontFamily: 'Vollkorn',
        ),
      ),
    );

    return new MaterialApp(
      title: 'Tohi Kole Katolika',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Tohi Kole Katolika",
            style: new TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: "Vollkorn",
              fontSize: 32.0,
              color: Colors.white,
            )
          )
        ),
        body: new ListView(children: [
          prayerSection,
          // buttonSection,
          textSection,
        ],),
        bottomNavigationBar: navBarBottom,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.threesixty),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Prayers extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new Scaffold (
      appBar: new AppBar(
        title: new Text("Tongan Prayers"),
      ) 
    );
  }

  // Widget _buildSuggestions() {
  //   return new ListView.builder(
  //     padding: const EdgeInsets.all(16.0),
  //     // The itemBuilder callback is called once per suggested word pairing,
  //     // and places each suggestion into a ListTile row.
  //     // For even rows, the function adds a ListTile row for the word pairing.
  //     // For odd rows, the function adds a Divider widget to visually
  //     // separate the entries. Note that the divider may be difficult
  //     // to see on smaller devices.
  //     itemBuilder: (context, i) {
  //       // Add a one-pixel-high divider widget before each row in theListView.
  //       if (i.isOdd) return new Divider();

  //       // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
  //       // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
  //       // This calculates the actual number of word pairings in the ListView,
  //       // minus the divider widgets.
  //       final index = i ~/ 2;
  //       // If you've reached the end of the available word pairings...
  //       if (index >= _suggestions.length) {
  //         // ...then generate 10 more and add them to the suggestions list.
  //         _suggestions.addAll(generateWordPairs().take(10));
  //       }
  //       return _buildRow(_suggestions[index]);
  //     }
  //   );
  // }
} 

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
       _color = color,
       _title = title,
       item = new BottomNavigationBarItem(
         icon: icon,
         title: new Text(title),
         backgroundColor: color,
       ),
       controller = new AnimationController(
         duration: kThemeAnimationDuration,
         vsync: vsync,
       ) {
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';

  @override
  _BottomNavigationDemoState createState() => new _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple,
        vsync: this,
      ),
      new NavigationIconView(
        icon: new CustomIcon(),
        title: 'Box',
        color: Colors.deepOrange,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.cloud),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: 'Favorites',
        color: Colors.indigo,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    // for (NavigationIconView view in _navigationViews)
    //   transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Bottom navigation'),
        actions: <Widget>[
          new PopupMenuButton<BottomNavigationBarType>(
            onSelected: (BottomNavigationBarType value) {
              setState(() {
                _type = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<BottomNavigationBarType>>[
              const PopupMenuItem<BottomNavigationBarType>(
                value: BottomNavigationBarType.fixed,
                child: const Text('Fixed'),
              ),
              const PopupMenuItem<BottomNavigationBarType>(
                value: BottomNavigationBarType.shifting,
                child: const Text('Shifting'),
              )
            ],
          )
        ],
      ),
      body: new Center(
        child: _buildTransitionsStack()
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}