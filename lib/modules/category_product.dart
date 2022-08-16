import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/shared/components.dart';

class CategoryProduct extends StatelessWidget {
  String? category;
  CategoryProduct(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: myAppBar(context, name: 'Category Product', back: true,
                onpressback: () {
              cubit.categoryProductModel = null;
              Navigator.pop(context);
            }),
            body: cubit.categoryProductModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$category :',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 1 / 1.7,
                              crossAxisSpacing: 5,
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 5,
                              children: List.generate(
                                  cubit.categoryProductModel!.data!.data.length,
                                  (index) {
                                return buildGridProduct(context,
                                    model: cubit.categoryProductModel!.data!
                                        .data[index]);
                              })),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
