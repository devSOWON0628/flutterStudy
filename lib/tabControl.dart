import 'package:flutter/material.dart';

class Choice {
  Choice(this.text, this.icon);
  String text;
  IconData icon;
}
class MySecondHome extends StatefulWidget{
  @override
  _MySecondHomeState createState() => _MySecondHomeState();
}

class _MySecondHomeState extends State<MySecondHome>with SingleTickerProviderStateMixin {
  TabController controller;
  final choices = [
    Choice('기차',Icons.train)
    , Choice('비행기',Icons.airplanemode_active)
    , Choice('셔틀',Icons.airport_shuttle)
    , Choice('구름',Icons.cloud_queue_sharp)
    , Choice('파도',Icons.waves)
    , Choice('안국역',Icons.train_outlined)
    , Choice('컵', Icons.mark_chat_unread_rounded)];
  @override
  void initState(){
    super.initState();
    controller = TabController(vsync: this, length: choices.length);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('06/28', style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            tabs: choices.map((Choice choice) {
              return Tab(
                  child: Text(choice.text,style: TextStyle(color: Colors.white)),
                icon: Icon(choice.icon,color: Colors.white),
              );
            }).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return ChoiceCard(
              text: choice.text,
              icon: choice.icon,
            );
          }).toList(),
        ),
        bottomNavigationBar: Container(
          child: TabBar(
                controller: controller,
                tabs:choices.map((Choice choice) {
                  return Tab(
                    child: Text(choice.text,style: TextStyle(color: Colors.white)),
                    icon: Icon(choice.icon,color: Colors.white),
                  );
                }).toList(),
                isScrollable: true,
              ),
              color: Colors.lightBlue,
            ),
          )
  );
  }
}
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.text, this.icon}) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Icon(icon),
          Text(text),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }
}