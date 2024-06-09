
class CategoryData {
  int id=0;
  String name='';
  String image='';

  CategoryData.fromMap(Map<String, dynamic> map) {
    id=map["id"];
    name=map["name"];
    image=map["image"];
  }
}