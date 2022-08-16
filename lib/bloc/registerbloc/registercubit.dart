import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/registerbloc/registerstates.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/models/usermodel.dart';
import 'package:practice_shop_app/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var formstate = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  UserModel? registerdata;
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoading());
    DioHelper.postdata(url: Register, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      registerdata = UserModel.fromjson(value.data);
      emit(RegisterSuccess(registerdata!));
    }).catchError((error) {
      emit(RegisterError());
    });
  }
}
