import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'chat.dart';
import 'data.dart';
import 'drawer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.age}) : super(key: key);
  final String title;
  final String age;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.chat_bubble_outline_rounded),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context){
                  return ChatScreen();
                }),
              );
            },
            label: 'Button 1',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.amber),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.assignment_outlined),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context){
                  return GetDataPage();
                }),
              );
            },
            label: 'Button 2',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.amber)
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title+":"+widget.age),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.print),
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context){
                    return MyApp2();
                  }),
                );
              },
              iconSize: 50,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20)),
            ListTile(
              title: Text("first Title", textAlign: TextAlign.center,),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("first Title", textAlign: TextAlign.center,),
              onTap: (){
                print("hello");
              },
            ),
            ListTile(
              title: Text("first Title", textAlign: TextAlign.center,),
              onTap: (){
                print("hello");
              },
            ),
            Padding(padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: (){
                    print("add button pressed");
                  },
                ),
                FloatingActionButton(
                  onPressed: (){
                    print("div button pressed");
                  },
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: (){
                    print("pressed button");
                  },
                  child: Icon(Icons.arrow_left),
                ),
                FloatingActionButton(
                  onPressed: (){
                    print("pressed button");
                  },
                  child: Icon(Icons.arrow_right),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _getFAB(),
    );
  }
}
