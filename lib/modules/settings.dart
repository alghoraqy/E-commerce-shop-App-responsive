import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/constant.dart';
import 'package:practice_shop_app/shared/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        if (cubit.user != null) {
          cubit.namecontroller.text = cubit.user!.data!.name!;
          cubit.emailcontroller.text = cubit.user!.data!.email!;
          cubit.phonecontroller.text = cubit.user!.data!.phone!;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: myAppBar(context, name: 'Settings'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: cubit.user != null
                ? Column(
                    children: [
                      formField(
                          text: 'name',
                          controller: cubit.namecontroller,
                          onsubmit: (string) {
                            cubit.updateData(
                                name: cubit.namecontroller.text,
                                email: cubit.emailcontroller.text,
                                phone: cubit.phonecontroller.text);
                          },
                          errortext: 'name must not be empty'),
                      SizedBox(
                        height: 20,
                      ),
                      formField(
                          text: 'email',
                          controller: cubit.emailcontroller,
                          onsubmit: (string) {
                            cubit.updateData(
                                name: cubit.namecontroller.text,
                                email: cubit.emailcontroller.text,
                                phone: cubit.phonecontroller.text);
                          },
                          errortext: 'name must not be empty'),
                      SizedBox(
                        height: 20,
                      ),
                      formField(
                          text: 'phone',
                          controller: cubit.phonecontroller,
                          onsubmit: (string) {
                            cubit.updateData(
                                name: cubit.namecontroller.text,
                                email: cubit.emailcontroller.text,
                                phone: cubit.phonecontroller.text);
                          },
                          errortext: 'name must not be empty'),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      state is UpdataDataLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : button(
                              name: 'Update',
                              onpressed: () {
                                cubit.updateData(
                                    name: cubit.namecontroller.text,
                                    email: cubit.emailcontroller.text,
                                    phone: cubit.phonecontroller.text);
                              }),
                      SizedBox(
                        height: 20,
                      ),
                      button(
                          name: 'Logout',
                          onpressed: () {
                            signOut(context);
                          }),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
