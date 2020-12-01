import 'package:flutter/material.dart';
import 'package:flutter_json/model/data.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MaterialColor> _color = [
    Colors.deepOrange,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.brown
  ];

  Future<List<Data>> getAllData() async {
    var api = "https://jsonplaceholder.typicode.com/photos";
    var data = await Http.get(api);
    var jsonData = json.decode(data.body);
    List<Data> listOf = [];
    for (var i in jsonData) {
      Data data = new Data(i["id"], i["url"], i["thumbnail"], i["title"]);
      listOf.add(data);
    }
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("json app"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), onPressed: () => print("search")),
          IconButton(icon: Icon(Icons.add), onPressed: () => print("add"))
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text("DrawerHeader"),
            decoration: BoxDecoration(color: Colors.deepOrange),
          ),
          ListTile(
            leading: Icon(Icons.search, color: Colors.orange),
            title: Text("First Page"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add, color: Colors.red),
            title: Text("Second Page"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.title, color: Colors.purple),
            title: Text("Third Page"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.green),
            title: Text("Forth Page"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            leading: Icon(Icons.close, color: Colors.red),
            title: Text("Close Page"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              height: 250,
              child: FutureBuilder(
                  future: getAllData(),
                  builder: (BuildContext c, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                          child: Container(child: Text("Loading...")));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext c, int index) {
                          MaterialColor _mcolor = _color[index % _color.length];
                          return Card(
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(snapshot.data[index].url,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover),
                                  SizedBox(height: 7),
                                  Container(
                                      margin: EdgeInsets.all(6),
                                      height: 50,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              child: CircleAvatar(
                                            child: Text(snapshot.data[index].id
                                                .toString()),
                                            backgroundColor: _mcolor,
                                            foregroundColor: Colors.white,
                                          )),
                                          SizedBox(width: 6),
                                          Container(
                                              width: 80,
                                              child: Text(
                                                snapshot.data[index].title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.deepOrange),
                                              )),
                                        ],
                                      ))
                                ],
                              ));
                        },
                      );
                    }
                  })),
          SizedBox(height: 7),
          Container(
            margin: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 7.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Image.network(
                                snapshot.data[index].url,
                                height: 100,
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
