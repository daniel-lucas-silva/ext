import 'package:flutter/material.dart';

class FormsExample extends StatefulWidget {
  @override
  _FormsExampleState createState() => _FormsExampleState();
}

class _FormsExampleState extends State<FormsExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forms Example"),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text("Salvar"),
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(14),
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Teste",
            ),
          ),
          SizedBox(height: 14),
          RaisedButton(
            onPressed: () {},
            child: Text("RaisedButton"),
          ),
          OutlineButton(
            onPressed: () {},
            child: Text("OutlineButton"),
          ),
          FlatButton(
            onPressed: () {},
            child: Text("FlatButton"),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text("MaterialButton"),
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: Text("TextButton"),
          // ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text("ElevatedButton"),
          // ),
          // OutlinedButton(
          //   onPressed: () {},
          //   child: Text("OutlinedButton"),
          // ),
        ],
      ),
    );
  }
}
