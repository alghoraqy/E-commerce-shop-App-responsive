import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/registerbloc/registercubit.dart';
import 'package:practice_shop_app/bloc/registerbloc/registerstates.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/modules/home_screen.dart';
import 'package:practice_shop_app/remote/cash_helper.dart';
import 'package:practice_shop_app/shared/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
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
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: myAppBar(context, name: 'Register', back: true,
                onpressback: () {
              Navigator.pop(context);
            }),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Form(
                key: cubit.formstate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register Now',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    formField(
                        text: 'name',
                        controller: cubit.namecontroller,
                        keyboardtype: TextInputType.name,
                        errortext: 'name must not be empty'),
                    SizedBox(
                      height: 15,
                    ),
                    formField(
                        text: 'email',
                        controller: cubit.emailcontroller,
                        keyboardtype: TextInputType.emailAddress,
                        errortext: 'email must not be empty'),
                    SizedBox(
                      height: 15,
                    ),
                    formField(
                        text: 'phone',
                        controller: cubit.phonecontroller,
                        keyboardtype: TextInputType.phone,
                        errortext: 'phone must not be empty'),
                    SizedBox(
                      height: 15,
                    ),
                    formField(
                        text: 'password',
                        secure: true,
                        controller: cubit.passwordcontroller,
                        errortext: 'password must not be empty'),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Center(
                        child: state is RegisterLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : button(
                                name: 'Register',
                                onpressed: () {
                                  cubit.formstate.currentState!.validate()
                                      ? cubit.register(
                                          name: cubit.namecontroller.text,
                                          email: cubit.emailcontroller.text,
                                          phone: cubit.phonecontroller.text,
                                          password:
                                              cubit.passwordcontroller.text)
                                      : null;
                                })),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
