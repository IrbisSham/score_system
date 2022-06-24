class Prize{
  final int id;
  final String name;
  final String desc;
  final double sum;

  Prize({required this.id, required this.name, required this.desc, required this.sum});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "desc" : desc,
      "sum" : sum,
    };
  }
}
