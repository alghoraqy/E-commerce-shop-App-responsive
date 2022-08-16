import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/states.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/models/usermodel.dart';
import 'package:practice_shop_app/modules/login_screen.dart';
import 'package:practice_shop_app/remote/cash_helper.dart';
import 'package:practice_shop_app/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitStates());
  static LoginCubit get(context) {
    return BlocProvider.of(context);
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool secure = true;
  var formkey = GlobalKey<FormState>();
  void changevisibility() {
    secure = !secure;
    emit(Changevisibility());
  }

  UserModel? userModel;

  void loginuser({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    DioHelper.postdata(url: login, lang: 'ar', data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = UserModel.fromjson(value.data);
      print(userModel!.message);
      emit(LoginSuccess(userModel!));
    }).catchError((error) {
      print('login error ${error.toString()}');
      emit(LoginError(error.toString()));
    });
  }

  Future signOut(context) {
    return CashHelper.removeData(key: 'token').then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    }).catchError((error) {
      print(error.toString());
    });
  }
}
