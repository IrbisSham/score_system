import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/model/activity.dart';
import 'package:score_system/model/board.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/service/response/board_response.dart';

class BoardPage extends StatefulWidget {

  final Activity _activity;

  BoardPage(this._activity);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> implements CreateBoardCallBack,GetBoardCallBack,DeleteBoardCallBack {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String _fio;
  late String _activity;
  late String _prize;
  late double _sum;
  late CreateBoardResponse _responseCreate;
  late GetBoardResponse _responseGet;
  late DeleteBoardResponse _responseDelete;
  late List<Board> listBoard;
  _BoardPageState() {
    _responseCreate = CreateBoardResponse(this);
    _responseGet = GetBoardResponse(this);
    _responseDelete = DeleteBoardResponse(this);
    listBoard = [];
    _responseGet.doGet();
  }
  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        form.save();
        _responseCreate.doCreate(_fio, _activity, _prize, _sum);
      });
    }
  }
  void _delete(int id) {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _responseDelete.doDelete(id);
      });
    }
  }
  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('ФИО')),
              DataColumn(label: Text('Деяние')),
              DataColumn(label: Text('Награда')),
              DataColumn(label: Text('Балы')),
              DataColumn(label: Text('Удалить?')),
            ],
            rows:
            listBoard // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(element.fio)),
                      DataCell(Text(element.activity)),
                      DataCell(Text(element.prize)),
                      DataCell(Text(element.sum.toString())),
                      DataCell( IconButton(
                        icon: const Icon(Icons.delete_forever,
                            color: const Color(0xFF167F67)),
                        onPressed: () => _delete(element.id),
                        alignment: Alignment.centerLeft,
                      )),
                    ],
                  )),
                )
                .toList(),
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    var loginBtn = OutlinedButton(
      onPressed: _submit,
      child: Text("Добавить"),
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.green),)
    );
    var boardForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: CURRENT_USER!.fio(),
                  onSaved: (val) => _fio = val!,
                  decoration: InputDecoration(labelText: "ФИО"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: widget._activity.name,
                  onSaved: (val) => _activity = val!,
                  decoration: InputDecoration(labelText: "Деяние"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _prize = val!,
                  decoration: InputDecoration(labelText: "Награда"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: widget._activity.sum.toString(),
                  onSaved: (val) => _sum = double.parse(val!),
                  decoration: InputDecoration(labelText: "Балы"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Реестр балов"),
      ),
      key: scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              boardForm,
              Flexible(
                child : dataBody(),
              ),
            ],
          )
        ),
      )
    );
  }
  @override
  void onCreateBoardError(String error) {
    // TODO: implement onSaveError
    _showSnackBar(error);
    setState(() {
    });
  }
  @override
  void onCreateBoardSuccess(int board) async {
    if (board > 0){
      // TODO: implement onSaveSuccess
      _responseGet.doGet();
      _showSnackBar("Данные были успешно сохранены");
      setState(() {
      });
    } else{
      // TODO: implement onSaveSuccess
      _showSnackBar("Неудачно, пожалуйста, проверьте вводимые данные");
      setState(() {
      });
    }

  }
  @override
  void onGetBoardError(String error) {
    // TODO: implement onSaveError
    _showSnackBar(error);
    setState(() {
    });
  }
  @override
  void onGetBoardSuccess(List<Board> board) async {
      // TODO: implement on get Success
      listBoard = board;
      setState(() {});
  }
  @override
  void onDeleteBoardError(String error) {
    // TODO: implement onDeleteError
    _showSnackBar(error);
    setState(() {
    });
  }
  @override
  void onDeleteBoardSuccess(int board) async {
    if(board > 0){
      _responseGet.doGet();
      // TODO: implement onSaveSuccess
      _showSnackBar("Данные были успешно удалены");
      setState(() {
      });
    }else{
      // TODO: implement onSaveSuccess
      _showSnackBar("Неудачно, пожалуйста, проверьте удаляемые данные");
      setState(() {
      });
    }

  }
}
