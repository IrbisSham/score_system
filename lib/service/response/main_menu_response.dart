import 'dart:async';
import 'package:score_system/model/board.dart';
import 'package:score_system/data/query/board_control.dart';

class MainMenuRequest {
  BoardControl con = new BoardControl();
  Future<int> createBoard(Board board) {
    var result = con.add(board);
    return result;
  }
  Future<List<Board>> getBoard() {
    var result = con.getAll();
    return result;
  }
  Future<int> deleteBoard(int board) {
    var result = con.delete(board);
    return result;
  }
}

abstract class CreateBoardCallBack {
  void onCreateBoardSuccess(int board);
  void onCreateBoardError(String error);
}
abstract class GetBoardCallBack {
  void onGetBoardSuccess(List<Board> board);
  void onGetBoardError(String error);
}
abstract class DeleteBoardCallBack {
  void onDeleteBoardSuccess(int board);
  void onDeleteBoardError(String error);
}
class CreateBoardResponse {
  CreateBoardCallBack _callBackCreate;
  MainMenuRequest boardRequest = new MainMenuRequest();
  CreateBoardResponse(this._callBackCreate);
  doCreate(String fio, String activity, String prize, double sum) {
    var board = Board(fio, activity, prize, sum);
    boardRequest
        .createBoard(board)
        .then((board) => _callBackCreate.onCreateBoardSuccess(board))
        .catchError((onError) => _callBackCreate.onCreateBoardError(onError.toString()));
  }
}
class GetBoardResponse {
  GetBoardCallBack _callBackGet;
  MainMenuRequest boardRequest = new MainMenuRequest();
  GetBoardResponse(this._callBackGet);
  doGet() {
    boardRequest
        .getBoard()
        .then((board) => _callBackGet.onGetBoardSuccess(board))
        .catchError((onError) => _callBackGet.onGetBoardError(onError.toString()));
  }
}
class DeleteBoardResponse {
  DeleteBoardCallBack _callBackDelete;
  MainMenuRequest boardRequest = new MainMenuRequest();
  DeleteBoardResponse(this._callBackDelete);
  doDelete(int id) {

    boardRequest
        .deleteBoard(id)
        .then((board) => _callBackDelete.onDeleteBoardSuccess(board))
        .catchError((onError) => _callBackDelete.onDeleteBoardError(onError.toString()));
  }
}
