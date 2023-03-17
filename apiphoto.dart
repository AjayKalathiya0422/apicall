import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apiphoto extends StatefulWidget {
  const apiphoto({Key? key}) : super(key: key);

  @override
  State<apiphoto> createState() => _apiphotoState();
}

class _apiphotoState extends State<apiphoto> {
    List<myphotos> photoss = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    photodata();
  }

  Future<void> photodata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List ll = jsonDecode(response.body);
    for (int i = 0; i < ll.length; i++) {
      myphotos mm = myphotos.fromJson(ll[i]);
      setState(() {
        photoss.add(mm);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("API Photos")),
      ),
      body: ListView.builder(
        itemCount: photoss.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${photoss[index].title}"),
            subtitle: Text("${photoss[index].url}\n${photoss[index].albumId}"),
            leading: Image(image: NetworkImage("${photoss[index].thumbnailUrl}")),
            trailing: Text("${photoss[index].id}"),
          );
        },
      ),
    );
  }
}

class myphotos {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  myphotos({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  myphotos.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
