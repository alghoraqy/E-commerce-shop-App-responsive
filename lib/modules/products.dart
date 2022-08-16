import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/modules/search.dart';
import 'package:practice_shop_app/shared/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, states) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: myAppBar(context, name: 'Shop App', actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {
                    navigateto(context,
                        screen: BlocProvider.value(
                            value: ShopCubit.get(context),
                            child: SearchScreen()));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.cyan,
                    size: 28,
                  )),
            )
          ]),
          body: cubit.homeModel != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          items: cubit.homeModel!.data!.banners.map((e) {
                            return Container(
                              height: 230,
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(e.image!),
                                    fit: BoxFit.cover,
                                  )),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 230,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 2),
                            autoPlayCurve: Curves.bounceInOut,
                            initialPage: 0,
                            reverse: false,
                            viewportFraction: 1.0,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        cubit.categoryModel != null
                            ? categoriesList(model: cubit.categoryModel!)
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'My Products :',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        gridView(model: cubit.homeModel!, context)
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
        );
      },
    );
  }
}
