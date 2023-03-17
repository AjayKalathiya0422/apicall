import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadJSONfrombelowAPI extends StatefulWidget {
  const ReadJSONfrombelowAPI({Key? key}) : super(key: key);

  @override
  State<ReadJSONfrombelowAPI> createState() => _ReadJSONfrombelowAPIState();
}

class _ReadJSONfrombelowAPIState extends State<ReadJSONfrombelowAPI> {
  myreaddata? mm;

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readjsondata();
  }

  Future<void> readjsondata() async {
    var url = Uri.parse('https://invicainfotech.com/apicall/mydata');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var rr = jsonDecode(response.body);
    setState(() {
      mm = myreaddata.fromJson(rr);
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("My Data List"))),
        body: status
            ? ListView.builder(
                itemCount: mm!.contacts!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${mm!.contacts![index].userimage}"))),
                            ),
                          ),
                         Container(
                             height: MediaQuery.of(context).size.height * 0.2,
                             width: MediaQuery.of(context).size.width * 0.6,
                             child: ListTile(title: Text("${mm!.contacts![index].name}" ),))
                        ],
                      ),
                      
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class myreaddata {
  List<Contacts>? contacts;

  myreaddata({this.contacts});

  myreaddata.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  String? id;
  String? name;
  String? email;
  String? userimage;
  String? address;
  String? gender;
  Phone? phone;

  Contacts(
      {this.id,
      this.name,
      this.email,
      this.userimage,
      this.address,
      this.gender,
      this.phone});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userimage = json['userimage'];
    address = json['address'];
    gender = json['gender'];
    phone = json['phone'] != null ? new Phone.fromJson(json['phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userimage'] = this.userimage;
    data['address'] = this.address;
    data['gender'] = this.gender;
    if (this.phone != null) {
      data['phone'] = this.phone!.toJson();
    }
    return data;
  }
}

class Phone {
  String? mobile;
  String? home;

  Phone({this.mobile, this.home});

  Phone.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    home = json['home'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['home'] = this.home;
    return data;
  }
}
