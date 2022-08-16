import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/shared/components.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

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
                'My Favourites',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            body: cubit.homeModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.getFavouriteModel != null
                    ? cubit.getFavouriteModel!.favouriteData!.data.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'there is no favourite yet !!',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Favourite :',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  state is GetFavouriteLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        )
                                      : GridView.count(
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          childAspectRatio: 1 / 1.7,
                                          crossAxisSpacing: 5,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          mainAxisSpacing: 5,
                                          children: List.generate(
                                              cubit
                                                  .getFavouriteModel!
                                                  .favouriteData!
                                                  .data
                                                  .length, (index) {
                                            return buildGridProduct(context,
                                                model: cubit
                                                    .getFavouriteModel!
                                                    .favouriteData!
                                                    .data[index]
                                                    .product!);
                                          })),
                                ],
                              ),
                            ),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      ));
      },
    );
  }
}
