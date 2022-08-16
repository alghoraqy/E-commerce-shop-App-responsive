import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/shared/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'My Categories',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: cubit.categoryModel != null
              ? CategoryScreenList(cubit.categoryModel)
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
        );
      },
    );
  }
}
