import 'package:client/game/game.dart';
import 'package:client/socket/socket.dart';

class GameController {
  Socket _socket;
  void Function(String symbol) gameBegin;
  void Function(int idx) showMoveOnUi;
  void Function() opponentLeft;
  void Function(Map data) moveMade;
  void Function(String winningPlayer, String full) showGameEnd;

  /// Инициализация и связь View с Socket
  GameController(this.gameBegin, this.opponentLeft, this.moveMade,
      this.showMoveOnUi, this.showGameEnd) {
    _socket = Socket();
    _socket.socketConnect();
    _socket.gameBegin(this.gameBegin);
    _socket.moveMade(this.moveMade);
    _socket.opponentLeft(this.opponentLeft);
  }

  /// Связь совершенного игроком действия с Socket
  void makeMoveCtrl(String symbol, int idx) {
    _socket.makeMove(symbol, idx);
  }

  /// Проверка состояния игры на доске (Победа, поражение или ничья)
  void boardCheck(List<dynamic> board) {
    String evaluate = Game.evaluateBoard(board);
    if (evaluate != Game.NO_WINNERS) {
      showGameEnd(evaluate, Game.FULL);
    }
  }

  /// Отключаемся от socket
  void disconnect() {
    _socket.socketDisconnect();
  }
}
