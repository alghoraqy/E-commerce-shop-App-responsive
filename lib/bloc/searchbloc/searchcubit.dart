// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:practice_shop_app/bloc/searchbloc/searchstates.dart';
// import 'package:practice_shop_app/constant.dart';
// import 'package:practice_shop_app/models/categoryproductmodel.dart';
// import 'package:practice_shop_app/remote/dio_helper.dart';

// class SearchCubit extends Cubit<SearchStates> {
//   SearchCubit() : super(SearchInitState());
//   static SearchCubit get(context) => BlocProvider.of(context);

//   TextEditingController searchcontroller = TextEditingController();

//   CategoryProductModel? searchmodel;
//   void getSearch({required String text}) {
//     emit(GetSearchLoading());
//     DioHelper.postdata(url: Search, token: token, data: {'text': text})
//         .then((value) {
//       searchmodel = CategoryProductModel.fromJson(value.data);
//       emit(GetSearchSuccess());
//     }).catchError((error) {
//       print(error.toString());
//       emit(GetSearchError());
//     });
//   }
// }
