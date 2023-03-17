import 'dart:convert';
import 'package:apicalling/apialbum.dart';
import 'package:apicalling/apilog2.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ReadJSONfrombelowAPI.dart';
import 'apiphoto.dart';
import 'apiproducts.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home:apiproducts() ,
  ));
}
class apicalling extends StatefulWidget {
  @override
  State<apicalling> createState() => _apicallingState();
}
class _apicallingState extends State<apicalling> {
  List<apicall> mydata = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apilog();
  }

  Future<void> apilog() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await  http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
   // debugPrint("${response.body}");
    List mm = jsonDecode(response.body);
    for (int i = 0; i < mm.length; i++) {
      apicall aa = apicall.fromJson(mm[i]);

        setState(() {
          mydata.add(aa);
        });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("API Calling")),),
      body: ListView.builder(
        itemCount: mydata.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${mydata[index].title}"),
            subtitle: Text("${mydata[index].body}"),
            leading: Text("${mydata[index].id}"),
            trailing: Text("${mydata[index].userId}"),
          );
        },
      ),
    );
  }
}

class apicall {
  int? userId;
  int? id;
  String? title;
  String? body;

  apicall({this.userId, this.id, this.title, this.body});

  apicall.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
