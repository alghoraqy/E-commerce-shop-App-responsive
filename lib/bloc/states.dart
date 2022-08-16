import 'package:practice_shop_app/models/usermodel.dart';

abstract class LoginStates {}

class InitStates extends LoginStates {}

class Changevisibility extends LoginStates {}

class LoginSuccess extends LoginStates {
  final UserModel model;
  LoginSuccess(this.model);
}

class LoginLoading extends LoginStates {}

class LoginError extends LoginStates {
  final String error;
  LoginError(this.error);
}
