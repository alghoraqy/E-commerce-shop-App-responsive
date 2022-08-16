import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice_shop_app/bloc/cubit.dart';
import 'package:practice_shop_app/bloc/states.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/modules/home_screen.dart';
import 'package:practice_shop_app/modules/register_screen.dart';
import 'package:practice_shop_app/remote/cash_helper.dart';
import 'package:practice_shop_app/shared/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.model.status == true) {
              showtoast(message: state.model.message!, color: Colors.green);
              CashHelper.saveData(key: 'token', value: state.model.data!.token)
                  .then((value) {
                token = state.model.data!.token;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              }).catchError((error) {
                print(error.toString());
              });
            } else {
              showtoast(message: state.model.message!, color: Colors.red);
              ;
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.cyan,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: cubit.formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login to Our New Hot Products',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      formField(
                          text: 'E-mail',
                          controller: cubit.emailcontroller,
                          keyboardtype: TextInputType.emailAddress,
                          errortext: 'email must not be null'),
                      SizedBox(
                        height: 10,
                      ),
                      formField(
                          text: 'Password',
                          controller: cubit.passwordcontroller,
                          secure: cubit.secure,
                          suffixpress: () {
                            cubit.changevisibility();
                          },
                          suffix: cubit.secure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          errortext: 'password must not be null'),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Column(
                          children: [
                            state is LoginLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black),
                                  )
                                : button(
                                    name: 'login',
                                    onpressed: () {
                                      cubit.formkey.currentState!.validate()
                                          ? cubit.loginuser(
                                              email: cubit.emailcontroller.text,
                                              password:
                                                  cubit.passwordcontroller.text)
                                          : null;
                                    }),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t hve an account?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateto(context,
                                          screen: const RegisterScreen());
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.cyan,
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
