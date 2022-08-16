import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/modules/category_product.dart';
import 'package:practice_shop_app/modules/home_screen.dart';
import 'package:practice_shop_app/modules/login_screen.dart';
import 'package:practice_shop_app/remote/cash_helper.dart';
import 'package:practice_shop_app/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  DioHelper.init();

  token = CashHelper.getData(key: 'token');
  Widget? startwidget;
  if (token != null) {
    startwidget = const HomeScreen();
  } else {
    startwidget = const LoginScreen();
  }
  runApp(MyApp(
    widget: startwidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? widget;
  MyApp({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.cyan.shade800),
            headline2: TextStyle(
                fontSize: 25, color: Colors.cyan, fontWeight: FontWeight.w600)),
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      home: widget,
    );
  }
}
