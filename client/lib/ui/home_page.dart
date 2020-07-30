import 'package:flutter/material.dart';
import 'package:client/ui/game_page.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(16),
              child: Text("Крестики-нолики",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
          ),
          Center(
            child: ButtonTheme(
              minWidth: 200,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage(widget.title))
                  );
                },
                child: Text("Новая игра", style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
