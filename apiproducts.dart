import 'dart:convert';

import 'package:apicalling/myimages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apiproducts extends StatefulWidget {
  const apiproducts({Key? key}) : super(key: key);

  @override
  State<apiproducts> createState() => _apiproductsState();
}

class _apiproductsState extends State<apiproducts> {
  myproduct? mp;
  bool status = false;

  dynamic isVertical;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      product();

    });

  }

  Future<void> product() async {
    var url = Uri.parse('https://dummyjson.com/products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var pp = jsonDecode(response.body);
      setState(() {
        mp = myproduct.fromJson(pp);
        mp!.products!.toList();
        mp!.products!.sort((a, b) => a.price!.compareTo(b.price!));
        mp!.products!.forEach((print) );
        status = true;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Products")),
        ),
        body: status
            ? ListView.builder(
                itemCount: mp!.products!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Card(
                            child: InkWell(
                              onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return myimages(mp!.products![index].images);
                                  },));
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Image(
                                    image: NetworkImage(
                                        "${mp!.products![index].thumbnail}")),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ListTile(
                              title: Text(
                                "${mp!.products![index].title} | ${mp!.products![index].brand} | ${mp!.products![index].rating}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                children: [
                                  Text(
                                    "${mp!.products![index].description}\n${mp!.products![index].category} ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                    "Price:${mp!.products![index].price}",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold,fontSize: 20),
                                  ))
                                ],
                              ),
                            ),
                          ),
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

class myproduct {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  myproduct({this.products, this.total, this.skip, this.limit});

  myproduct.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  dynamic? discountPercentage;
  dynamic? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
