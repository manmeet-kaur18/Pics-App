import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images=[];
  void fetchImage() async{
    counter++;
    final response=await get('https://jsonplaceholder.typicode.com/photos/$counter');
    final imagemodel= ImageModel.fromJson(json.decode(response.body));

    setState(() {
        images.add(imagemodel);
    });
  

  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue, title: Text("lets see the images")),

        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('android/assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Center(
                child:ImageList(images),
            )
          ],
        ),

        // LINEAR GRADIENT BACKGROUND
        /*body: Container(
      // Add box decoration
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
          ))),*/

        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onPressed: fetchImage,
        ),
        // title:Text("lets see the images"),
        // )
      ),
    );
  }
}
