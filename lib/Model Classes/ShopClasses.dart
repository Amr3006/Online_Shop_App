

class Banners {
  String? image;
  int? id;
  Banners.fromMap(Map<String,dynamic> map) {
    id=map["id"];
    image=map["image"];
  }
}

class Products {
  int? id;
  int? discount;
  dynamic price;
  dynamic oldPrice;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  Products.fromMap(Map<String,dynamic> map) {
    id = map["id"];
    discount = map["discount"];
    price = map["price"];
    oldPrice = map["old_price"];
    discount = map["discount"];
    name = map["name"];
    image = map["image"];
    inFavorites = map["in_favorites"];
    inCart = map["in_cart"];
  }
}