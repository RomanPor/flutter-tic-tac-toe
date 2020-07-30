import 'package:client/ui/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:client/ui/field.dart';

class GamePage extends StatefulWidget {
  final String title;

  GamePage(this.title);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  GameController _controller;
  List board = List.generate(9, (idx) => '');
  String message = 'Ожидание противника';
  bool myTurn = false;
  String symbol = '';

  /// Инициируем контроллер
  GamePageState() {
    this._controller = GameController(
        _gameBegin, _opponentLeft, _moveMade, _makeMove, _onGameEnd);
  }

  /// Получаем символ на доске
  String getSymbol(int idx) {
    return board[idx];
  }

  /// Меняем сообщение хода
  void changeMessage() {
    myTurn ? message = 'Ваш ход' : message = 'Ход противника';
  }

  /// Состояние совершенного действия, отображение на доске, смена хода и сообщения
  void _moveMade(Map data) {
    setState(() {
      board[data['position']] = data['symbol'];
      myTurn = data['symbol'] != symbol;
      changeMessage();
      _controller.boardCheck(board);
    });
  }

  /// Состояние, когда противник вышел
  void _opponentLeft() {
    setState(() {
      message = 'Ваш противник спасся бегством!';
    });
  }

  /// Состояние начала игры
  void _gameBegin(String symbol) {
    setState(() {
      this.symbol = symbol;
      myTurn = symbol == "X";
      changeMessage();
    });
  }

  /// Совершение хода игроком
  void _makeMove(int idx) {
    setState(() {
      if (!myTurn) return;
      if (board[idx] != '') return;
      _controller.makeMoveCtrl(symbol, idx);
    });
  }

  /// Состояние окончания игры
  void _onGameEnd(String winner, String full) {
    String title;
    String content;
    if (winner == full) {
      title = "Ничья!";
      content = "Игра оказалась сильнее.";
    } else {
      switch (winner == symbol) {
        case (true):
          title = "Победа!";
          content = "Поздравляем, вы победили!";
          break;
        case (false):
          title = "Поражение!";
          content = "Да уж, а я на тебя ставил...";
          break;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                  _controller.disconnect();
                },
                child: Text("Exit"))
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(60),
                  child: Column(children: <Widget>[
                    Text(
                      message,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ])),
              Container(
                width: 300,
                height: 300,
                child: GridView.count(
                  crossAxisCount: 3,
                  // generate the widgets that will display the board
                  children: List.generate(9, (idx) {
                    return Field(
                        idx: idx,
                        onTap: _makeMove,
                        playerSymbol: getSymbol(idx));
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
