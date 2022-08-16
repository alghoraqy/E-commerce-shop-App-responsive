import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/bloc/shop/shop_states.dart';
import 'package:practice_shop_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar:
              myAppBar(context, name: 'Search', back: true, onpressback: () {
            Navigator.pop(context);
          }),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  formField(
                      text: 'Search',
                      controller: cubit.searchcontroller,
                      onsubmit: (string) {
                        cubit.getSearch(text: cubit.searchcontroller.text);
                      },
                      errortext: 'search error'),
                  SizedBox(
                    height: 20,
                  ),
                  if (cubit.searchmodel != null)
                    state is GetSearchLoading
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
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 5,
                            children: List.generate(
                                cubit.searchmodel!.data!.data.length, (index) {
                              return buildGridProduct(context,
                                  model: cubit.searchmodel!.data!.data[index]);
                            }))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
