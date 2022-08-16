import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/models/addfavouritemodel.dart';
import 'package:practice_shop_app/models/categorymodel.dart';
import 'package:practice_shop_app/models/categoryproductmodel.dart';
import 'package:practice_shop_app/models/getfavouritemodel.dart';
import 'package:practice_shop_app/models/homemodel.dart';
import 'package:practice_shop_app/models/usermodel.dart';
import 'package:practice_shop_app/modules/categories.dart';
import 'package:practice_shop_app/modules/favourite.dart';
import 'package:practice_shop_app/modules/products.dart';
import 'package:practice_shop_app/modules/settings.dart';
import 'package:practice_shop_app/remote/dio_helper.dart';
import 'package:practice_shop_app/shared/components.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) {
    return BlocProvider.of(context);
  }

  int currentindex = 0;

  void changebottomnav(int index) {
    currentindex = index;
    emit(ChangeBottomNav());
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  TextEditingController searchcontroller = TextEditingController();

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen()
  ];
  List<BottomNavigationBarItem> navitems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.production_quantity_limits_rounded,
        ),
        label: 'products'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.category,
        ),
        label: 'categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favourite'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'settings'),
  ];

  HomeModel? homeModel;
  Map<int, bool>? inFavourite = {};

  void getHomeData() {
    emit(GetHomeDataLoading());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach(
        (element) {
          inFavourite!.addAll({element.id!: element.inFavourite!});
        },
      );
      emit(GetHomeDataSuccess());
    }).catchError((error) {
      print('Get Data Error :  ${error.toString()}');
      emit(GetHomeDataError());
    });
  }

  CategoryModel? categoryModel;

  void getCategory() {
    DioHelper.getData(url: category, lang: 'en').then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel!.categoryData!.data[0].name);
      emit(GetCategoryDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataError());
    });
  }

  CategoryProductModel? categoryProductModel;
  Future<void> getCategoryProduct({
    required int categoryId,
  }) {
    emit(GetCategoryProductLoading());
    return DioHelper.getData(url: 'products', lang: 'en', token: token, query: {
      'category_id': categoryId,
    }).then((value) {
      categoryProductModel = CategoryProductModel.fromJson(value.data);
      emit(GetCategoryProductSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryProductError());
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;

  void changeFavourite({required int productId}) {
    inFavourite![productId] = !inFavourite![productId]!;
    emit(AddFavouriteSuccess());

    DioHelper.postdata(url: favourite, token: token, data: {
      'product_id': productId,
    }).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      if (changeFavouriteModel!.status == false) {
        inFavourite![productId] = !inFavourite![productId]!;
        showtoast(message: changeFavouriteModel!.message!, color: Colors.red);
        emit(ChangeFavouriteError());
      }
      if (changeFavouriteModel!.status == true) {
        getFavourite();
        showtoast(message: changeFavouriteModel!.message!, color: Colors.green);
      }
      print(changeFavouriteModel!.message);
    }).catchError((error) {
      print(error.toString());
      emit(AddFavouriteError());
    });
  }

  GetFavouriteModel? getFavouriteModel;
  void getFavourite() {
    emit(GetFavouriteLoading());
    DioHelper.getData(url: favourite, token: token).then((value) {
      getFavouriteModel = GetFavouriteModel.fromJson(value.data);
      emit(GetFavouriteSuccess());
    }).catchError((error) {
      print('get favourite error : ${error.toString()}');
      emit(GetFavouriteError());
    });
  }

  UserModel? user;
  void getprofile() {
    emit(GetProfileLoading());
    DioHelper.getData(url: profile, token: token).then((value) {
      user = UserModel.fromjson(value.data);
      print(user!.data!.name);
      emit(GetProfileSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileError());
    });
  }

  void updateData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdataDataLoading());
    DioHelper.putData(url: updata, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      user = UserModel.fromjson(value.data);
      emit(UpdataDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdataDataError());
    });
  }

  CategoryProductModel? searchmodel;
  void getSearch({required String text}) {
    emit(GetSearchLoading());
    DioHelper.postdata(
        url: Search,
        lang: 'en',
        token: token,
        data: {'text': text}).then((value) {
      searchmodel = CategoryProductModel.fromJson(value.data);
      emit(GetSearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchError());
    });
  }
}
