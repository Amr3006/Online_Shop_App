class Favorites {
  int? id;
  int? discount;
  dynamic price;
  dynamic oldPrice;
  String? image;
  String? name;

  Favorites.fromMap(Map<String,dynamic> map) {
    id = map["id"];
    discount = map["discount"];
    price = map["price"];
    oldPrice = map["old_price"];
    name = map["name"];
    image = map["image"];
  }
}