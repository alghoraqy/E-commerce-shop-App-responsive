import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/modules/login_screen.dart';
import 'package:practice_shop_app/remote/cash_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ShopCubit()
          ..getHomeData()
          ..getCategory()
          ..getFavourite()
          ..getprofile();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, states) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: cubit.screens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navitems,
              currentIndex: cubit.currentindex,
              onTap: (index) {
                cubit.changebottomnav(index);
              },
              backgroundColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: Colors.cyan,
              unselectedItemColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
