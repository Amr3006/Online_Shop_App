class LoginData {
  bool? status;
  String? message;
  UserData? data;

  LoginData.fromMap(Map<String,dynamic> map) {
    status = map["status"];
    message = map["message"];
  }

}


class UserData {
  String email="";
  String name="";
  int id=0;
  String phone="";
  int credit=0;
  int points=0;
  String token="";
  String image="";

  UserData.fromMap(Map<String,dynamic> map){
    email=map["email"];
    id=map["id"];
    name=map["name"];
    phone=map["phone"];
    credit=map["credit"];
    points=map["points"];
    token=map["token"];
    image=map["image"];
  }
}