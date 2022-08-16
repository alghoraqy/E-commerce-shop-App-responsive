import 'package:practice_shop_app/models/usermodel.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterSuccess extends RegisterStates {
  final UserModel model;
  RegisterSuccess(this.model);
}

class RegisterError extends RegisterStates {}

class RegisterLoading extends RegisterStates {}
