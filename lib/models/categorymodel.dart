class CategoryModel {
  bool? status;
  CategoryData? categoryData;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoryData = CategoryData.fromJson(json['data']);
  }
}

class CategoryData {
  int? currentpage;
  List<Data> data = [];
  CategoryData.fromJson(Map<String, dynamic> json) {
    currentpage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
