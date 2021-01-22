import 'package:MethodChannel/classes/CardClass.dart';
import 'package:MethodChannel/classes/loginClass.dart';
import 'package:MethodChannel/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SPHHome extends StatefulWidget {
  static String tag = 'map';

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<SPHHome> {
  List items = [];
  @override
  void initState() {
    // TODO: implement initState
    _getCardListing();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SPHHome'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
                onPressed: () {
                  _logoutFunction();
                }),
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext ctxt, int index) =>
                buildBody(ctxt, index),
          ),
        ),
      ),
    );
  }

  // A Separate Function called from itemBuilder
  Widget buildBody(BuildContext ctxt, int index) {
    // return Text("fuck you ${index}");

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: new Text(items[index]["title"]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              items[index]["description"],
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Image.network(items[index]["image"])
        ],
      ),
    );
  }

  static List getDummyList() {
    List list = List.generate(5, (i) {
      return "Item dsfjdlskf sdf dsf dsf ds fsd fds f dsf dsf sdf ds fds fds f sdf sdf dsf dsf ds fds fds f dsf dsf sdf dsf dsf ds fsd f${i + 1}";
    });
    print(list);
    return list;
  }

  _getCardListing() async {
    String data = await CardClass.getCardListing();
    final response = json.decode(data);
    print("_getCardListing");
    print(response["movies"]);
    setState(() {
      items = response["movies"];
    });
  }

  _logoutFunction() async {
    final bool status = await SignInSignUpClass.logoutUser();
    if (status) {
      Navigator.of(context).pushNamed(Login.tag);
    }
  }
}
