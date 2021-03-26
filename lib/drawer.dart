import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Album {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Album({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl']
    );
  }
}

Future<List<Album>> fetchAlbum() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/photos');
  var resSet = jsonDecode(response.body);
  List<Album> result = List();
  for(var i = 0 ; i<resSet.length ; i++){
    result.add(Album.fromJson(resSet[i]));
  }
  if (response.statusCode == 200) {
     return result;
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp2 extends StatefulWidget {
  MyApp2({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  Future<List<Album>> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DATA'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var result = snapshot.data;
                return Container(
                  color: Colors.white,
                  child: GridView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.network(result[index].thumbnailUrl, fit:BoxFit.fill,),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(result[index].id.toString()),
                                subtitle: Text(result[index].title, style: TextStyle(fontSize: 15),),
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );
  }
}