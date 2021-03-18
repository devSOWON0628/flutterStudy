import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'chatData.dart';

final fb = FirebaseDatabase.instance;
final myController = TextEditingController();
String name = 'Me';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final FocusNode _focusNode = FocusNode();
  Widget _buildTextComposer() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child:  Row(
        children: [
          Flexible(
            child:  TextField(
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
    final ref = fb.reference();
    var uuid = new Uuid();
    final currentDateTime = DateTime.now();
    if(Text.isEmpty){
      return ;
    }
    myController.clear();
    ref.child(uuid.v1()).set({
      'name': name,
      'message': Text,
      'time' : currentDateTime.toString()
    });
    ChatMessage message = new ChatMessage(
        text: Text,
        animationController: new AnimationController(
          duration: new Duration(milliseconds: 700),
          vsync: this,
        )
    );

    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('자신에게 보내기', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue,),
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
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(name)),
              ),
              new Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(name, style: Theme.of(context).textTheme.subhead),
                      new Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: new Text(text),
                      )
                    ],
                  ),
              ), // crossAxisAlignment: CrossAxisAlignment.start
              ),
            ]
        )
    );
  }
}