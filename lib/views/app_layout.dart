/*
 * @LastEditors:  
 * @LastEditTime: 2021-07-05 10:01:22
 * @FilePath: /habit_app/lib/views/app_layout.dart
 */
/* import 'package:flutter/cupertino.dart';
class AppLayout extends StatefulWidget {
  AppLayout({Key? key}) : super(key: key);

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('1231'),
    );
  }
} */
import 'package:flutter/material.dart';
import 'package:habit_app/views/notes_screen.dart';
import 'package:habit_app/views/work_screen.dart';
class AppLayout extends StatefulWidget {
  AppLayout({Key? key}) : super(key: key);

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _counter = 0;

  int _index = 0;

  final Color _selectColorAmber = Color(0xFFFDD835);
  // final Color _selectColorAmber = Color(0xFFfedfd7);
  Color _selectColor=Color(0xFFFDD835);
  // Color _selectColor=Color(0xFFFDD835);
  // Color _selectColor=Color(0xFF42A5F5);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

    });
    setState(() {
      _index = 4;
      _selectColor = Colors.white;
    });
  }

  final _colorBar = Colors.white;

  bool _state = true;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _index = index;
      _selectColor = _selectColorAmber;
      print('selectIndex----');
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenList = [
     /*  HomeTab(
        counter: _counter,
      ), */
      NotesScreen(),
      WorkScreen()
    ];
    /* List<Widget> titleList = [
      Text("昆仑量化"),
      Text("行情"),
      Text("排行榜"),
      Text("总收益"),
      Text("量化"),
    ]; */
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      /* appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: titleList[_index],
      ), */
      backgroundColor: Color(0xffe7e6e6),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: screenList[_index],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '添加内容',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*Icon(
              Icons.add,
              color: _colorBar,
            ),*/
            Text('+')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // This trailing comma makes auto-formatting nicer for build methods.
      /*bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            */ /*NavigateButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('1111'),
                  Text('222'),
                  Text('222'),
                  Text('222'),
                  Text('222'),
                  Text('222'),
                  Text('222'),
                  Text('222'),
                ],
              ),
              onChange: (bool newValue) {
                setState(() {
                  _state = newValue;
                });
              },
              active: _state,
            ),*/
      /*
            // IconButton(icon: Icon(Icons.home), color:_colorBar, onPressed: (){}),

            IconButton(
                icon: Icon(Icons.home), color: _colorBar, onPressed: () {}),
            IconButton(
                icon: Icon(Icons.home), color: _colorBar, onPressed: () {}),
            IconButton(
                icon: Icon(Icons.home), color: _colorBar, onPressed: () {}),
          ],
        ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '行情',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '排行',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '收益',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectColor,
        onTap: _onItemTapped,
      ),
    );
  }
}