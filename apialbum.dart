import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apialbum extends StatefulWidget {
  const apialbum({Key? key}) : super(key: key);

  @override
  State<apialbum> createState() => _apialbumState();
}

class _apialbumState extends State<apialbum> {
  List<myalbum> albumm = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    albumdata();
  }

  Future<void> albumdata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List ll = jsonDecode(response.body);
    for (int i = 0; i < ll.length; i++) {
      myalbum mm = myalbum.fromJson(ll[i]);
      setState(() {
        albumm.add(mm);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Album")),),
      body: ListView.builder(itemCount: albumm.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${albumm[index].title}"),
            subtitle: Text("${albumm[index].id}"),
            leading: Text("${albumm[index].userId}"),
          );
        },
      ),
    );
  }
}

class myalbum {
  int? userId;
  int? id;
  String? title;

  myalbum({this.userId, this.id, this.title});

  myalbum.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
