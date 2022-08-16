import 'package:practice_shop_app/models/homemodel.dart';

class GetFavouriteModel {
  bool? status;
  FavouriteData? favouriteData;
  GetFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    favouriteData = FavouriteData.fromJson(json['data']);
  }
}

class FavouriteData {
  List<InfavData> data = [];
  FavouriteData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(InfavData.fromJson(element));
    });
  }
}

class InfavData {
  int? id;
  ProductsModel? product;
  InfavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductsModel.formJson(json['product']);
  }
}
