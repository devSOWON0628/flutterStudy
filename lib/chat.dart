import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'chatData.dart';

final fb = FirebaseDatabase.instance;
final myController = TextEditingController();
final String myName = 'Me';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    savedData();
  }

  final List<ChatMessage> _messages = <ChatMessage>[];
  final FocusNode _focusNode = FocusNode();
  final ref = fb.reference();

  void savedData(){
    ref.once().then((DataSnapshot snapshot) {
      if(snapshot.value == null){
        print("no data");
        return ;
      }
      Map<String, dynamic> result = new Map<String, dynamic>.from(snapshot.value);

      List<ChatData> data = List<ChatData>();
      result.forEach((key, value) {
        DateTime format = DateTime.parse(value["time"]);
        data.add(new ChatData(
            message: value["message"].toString(),
            userName: value["name"].toString(),
            chatId: key,
            time: format
        ));
      });
      data.sort();
      data.forEach((element) {
        setMessage(element.message, element.userName);
      });
    });
  }

  void setMessage(String text, String name){
    ChatMessage message = new ChatMessage(
        text: text,
        name : name,
        animationController: new AnimationController(
          duration: new Duration(milliseconds: 700),
          vsync: this,
        )
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child:  Row(
        children: [
          Flexible(
            child: TextField(
              controller: myController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: const Icon(Icons.send,color: Colors.blue,),
                onPressed: () {
                  _handleSubmitted(myController.text);
                }),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String Text) {
    var uuid = new Uuid();
    final String currentDateTime = DateTime.now().toString();
    if(Text.isEmpty){
      return ;
    }
    myController.clear();
    ref.child(uuid.v4()).set({
      'name': myName,
      'message': Text,
      'time' : currentDateTime.toString()
    });
    setMessage(Text, myName);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Realtime', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue,),
        body: new Column(
            children: <Widget>[
              new Flexible(
                  child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => _messages[index],
                    itemCount: _messages.length,
                  )
              ),
              new Divider(height: 1.0),
              new Container(
                decoration: new BoxDecoration(
                    color: Theme.of(context).cardColor
                ),
                child: _buildTextComposer(),
              )
            ]
        )
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text,this.name, this.animationController});
  final String text;
  final String name;
  final AnimationController animationController;
  Widget myTextAlign(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Text(name, style: Theme.of(context).textTheme.subhead),
        new Container(
          margin: const EdgeInsets.only(top: 5.0),
          child: new Text(text),
          color: Colors.black12,
        ),
      ],
    );
  }
  Widget otherTextAlign(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(name, style: Theme.of(context).textTheme.subhead),
        new Container(
          margin: const EdgeInsets.only(top: 5.0),
          child: new Text(text),
          color: Colors.black12,
        ),
      ],
    );
  }
  Widget circle(String text){
    return  Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child:new Text(text))
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if(name != myName)circle(name),
              new Container(
                child: Expanded(
                    child: name == myName? myTextAlign(context):otherTextAlign(context)
                ), // crossAxisAlignment: CrossAxisAlignment.start
              ),
            ]
        )
    );
  }
}