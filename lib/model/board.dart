class Board{
  late int _id;
  late String _fio;
  late String _activity;
  late String _prize;
  late double _sum;

  Board(this._fio, this._activity, this._prize, this._sum);

  String get fio => _fio;
  String get activity => _activity;
  String get prize => _prize;
  double get sum => _sum;
  int get id => _id;

  Board.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._fio = obj['fio'];
    this._activity = obj['activity'];
    this._prize = obj['prize'];
    this._sum = obj['sum'];
  }

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : _id,
      "fio" : _fio,
      "activity" : _activity,
      "prize" : _prize,
      "sum" : _sum,
    };
  }
}
