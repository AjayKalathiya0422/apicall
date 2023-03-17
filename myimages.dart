import 'package:flutter/material.dart';

class myimages extends StatefulWidget {
  List<String>? images;

  myimages(List<String>? this.images);

  @override
  State<myimages> createState() => _myimagesState();
}

class _myimagesState extends State<myimages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("MY IMAGE"))),
        body: PageView.builder(
          itemCount: widget.images!.length,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.all(10),
              child: Image(image: NetworkImage("${widget.images![index]}")),
            );
          },
        ),

    );

  }
}
