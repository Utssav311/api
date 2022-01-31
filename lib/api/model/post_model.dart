class PostModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostModel({this.userId, this.id, this.body, this.title});

  PostModel.fromJson(Map<String, dynamic>map){
    userId = map["userId"];
    id = map["id"];
    title = map["title"];
    body = map["body"];
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> map ={};
    map["userId"]=userId;
    map["id"]=id;
    map["title"]=title;
    map["body"]=body;
    return map;
  }
}
