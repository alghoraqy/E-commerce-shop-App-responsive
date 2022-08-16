import 'package:flutter/material.dart';
import 'package:practice_shop_app/modules/login_screen.dart';
import 'package:practice_shop_app/remote/cash_helper.dart';

const login = 'login';
const Home = 'home';
String? token;
const category = 'categories';
const favourite = 'favorites';
const profile = 'profile';
const updata = 'update-profile';
const Register = 'register';
const Search = 'products/search';

Future signOut(context) {
  return CashHelper.removeData(key: 'token').then((value) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }).catchError((error) {
    print(error.toString());
  });
}
