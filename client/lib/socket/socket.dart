import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  IO.Socket socket;

  /// Подключаемся к socket io
  void socketConnect() {
    socket = IO.io('http://localhost:8080/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('connection', (_) => print('connection'));
    socket.on('connect_error', (_) => print('connect_error'));
    socket.on('disconnect', (_) => print('disconnect'));
  }

  /// Получаем данные совершенного действия
  void moveMade(Function callback) {
    socket.on("move.made", (data) => callback(data));
  }

  /// Получаем событие, когда игрок вышел
  void opponentLeft(Function callback) {
    socket.on("opponent.left", (_) => callback());
  }

  /// Получаем событие начала игры
  void gameBegin(Function callback) {
    socket.on("game.begin", (data) => callback(data['symbol']));
  }

  /// Создаем и отправляем событие хода игроком
  void makeMove(String symbol, int idx) {
    socket.emit("make.move", {
      'symbol': symbol,
      'position': idx
    });
  }

  /// Отключаемся от socket io
  void socketDisconnect() {
    socket.io.disconnect();
  }
}
