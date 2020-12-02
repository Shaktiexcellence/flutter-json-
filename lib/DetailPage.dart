import 'package:flutter/material.dart';
import 'package:flutter_json/model/data.dart';

class Detail extends StatefulWidget {
  Data data;
  Detail(this.data);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail page'), backgroundColor: Colors.green),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                new Image.network(
                  widget.data.thumbnailUrl,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                new SizedBox(
                  height: 10.0,
                ),
                new Text(
                  widget.data.title,
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
