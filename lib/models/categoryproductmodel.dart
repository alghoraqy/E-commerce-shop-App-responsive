import 'package:practice_shop_app/models/homemodel.dart';

class CategoryProductModel {
  bool? status;
  CategoryProductdata? data;
  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryProductdata.fromJson(json['data']);
  }
}

class CategoryProductdata {
  List<ProductsModel> data = [];
  CategoryProductdata.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(ProductsModel.formJson(element));
    });
  }
}
