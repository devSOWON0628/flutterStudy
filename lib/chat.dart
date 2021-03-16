import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  Widget _buildTextComposer() {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child:  Row(
        children: [
          Flexible(
            child:  TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration:  InputDecoration.collapsed(
                  hintText: 'Send a message')
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: const Icon(Icons.send,color: Colors.blue,),
                onPressed: () => _handleSubmitted(_textController.text)),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String Text) {
    if(Text.isEmpty){
      return ;
    }
    _textController.clear();
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
    message.animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FriendlyChat', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue,),
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
const String _name = 'sowon';
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
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    )
                  ]
              )
            ]
        )
    );
  }
}