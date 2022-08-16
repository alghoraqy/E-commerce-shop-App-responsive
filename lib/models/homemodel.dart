class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.formJson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? discription;
  String? image;
  bool? inCart;
  bool? inFavourite;

  ProductsModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
