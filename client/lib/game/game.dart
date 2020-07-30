class Game {
  static const String EMPTY_SPACE = "";
  static const String FULL = "full";
  static const String NO_WINNERS = "no_winners";

  /// Выигрышные варианты заполнения доски
  static const WIN_CONDITIONS_LIST = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  /// Проверка доски на заполненность
  static bool isBoardFull(List<dynamic> board) {
    for (var val in board) {
      if (val == EMPTY_SPACE) return false;
    }
    return true;
  }

  /// Проверка состояния на доске (Победа, поражение, ничья)
  static String evaluateBoard(List<dynamic> board) {
    for (var list in WIN_CONDITIONS_LIST) {
      if (board[list[0]] != EMPTY_SPACE && // if a player has played here AND
          board[list[0]] == board[list[1]] && // if all three positions are of the same player
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }

    if (isBoardFull(board)) {
      return FULL;
    }
    return NO_WINNERS;
  }

}
