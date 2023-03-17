import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apilog2 extends StatefulWidget {
  const apilog2({Key? key}) : super(key: key);

  @override
  State<apilog2> createState() => _apilog2State();
}

class _apilog2State extends State<apilog2> {
  List<comment> mycomment = [];

  @override
   initState()  {
    // TODO: implement initState
    super.initState();
    coment();
  }
  Future<void> coment() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List ll = jsonDecode(response.body);
    for (int i = 0; i < ll.length; i++) {
      comment cc = comment.fromJson(ll[i]);
      setState(() {
        mycomment.add(cc);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Comments")),
      ),
      body: ListView.builder(itemCount: mycomment.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text("${mycomment[index].postId}"),
                subtitle: Text("${mycomment[index].body}"),
                leading: Text("${mycomment[index].id}"),
                trailing: Text("${mycomment[index].email}"),
                ),
            ],
          );
        },
      ),
    );
  }


}

class comment {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  comment({this.postId, this.id, this.name, this.email, this.body});

  comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}
