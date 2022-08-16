import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice_shop_app/bloc/shop/shop_cubit.dart';
import 'package:practice_shop_app/models/categorymodel.dart';
import 'package:practice_shop_app/models/homemodel.dart';
import 'package:practice_shop_app/modules/category_product.dart';

PreferredSizeWidget myAppBar(
  context, {
  required String name,
  bool? back,
  VoidCallback? onpressback,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    actions: actions,
    elevation: 0,
    leading: back == true
        ? IconButton(
            onPressed: onpressback,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ))
        : null,
    centerTitle: true,
    title: Text(
      name,
      style: Theme.of(context).textTheme.headline2,
    ),
  );
}

Future navigateto(
  context, {
  required Widget screen,
}) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Widget formField({
  required String text,
  required TextEditingController controller,
  required String errortext,
  TextInputType? keyboardtype,
  IconData? suffix,
  VoidCallback? suffixpress,
  Function(String)? onsubmit,
  Function(String)? onChange,
  VoidCallback? oneditcomplete,
  bool secure = false,
}) {
  return TextFormField(
    onEditingComplete: oneditcomplete,
    onFieldSubmitted: onsubmit,
    onChanged: onChange,
    keyboardType: keyboardtype,
    decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: suffixpress,
      ),
    ),
    controller: controller,
    obscureText: secure,
    validator: (string) {
      if (string!.isEmpty) {
        return errortext;
      }
    },
  );
}

Widget gridView(
  context, {
  required HomeModel model,
}) {
  return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1 / 1.7,
      crossAxisSpacing: 5,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 5,
      children: List.generate(model.data!.products.length, (index) {
        return buildGridProduct(
          context,
          model: model.data!.products[index],
        );
      }));
}

Widget buildGridProduct(
  context, {
  required ProductsModel model,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.shade300,
    ),
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(model.image!),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter)),
            ),
            if (model.discount != 0) discound(),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  height: .9,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor:
                        ShopCubit.get(context).inFavourite![model.id] == false
                            ? Colors.grey
                            : Colors.cyan,
                    child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavourite(productId: model.id!);
                        },
                        icon: Icon(
                          Icons.favorite_outline_outlined,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget discound() {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.red),
    child: Text(
      'Discount',
      style: TextStyle(
          fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Widget catergoryListItem({
  required Data model,
}) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(model.image!), fit: BoxFit.cover)),
      ),
      Container(
        height: 30,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Colors.black.withOpacity(.6)),
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      )
    ],
  );
}

Widget categoriesList({required CategoryModel model}) {
  return Container(
      height: 120,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              catergoryListItem(model: model.categoryData!.data[index]),
          separatorBuilder: (context, index) => SizedBox(
                width: 5,
              ),
          itemCount: model.categoryData!.data.length));
}

class CategoryScreenList extends StatelessWidget {
  CategoryModel? model;
  CategoryScreenList(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return categoryScreenitem(
              model: model!.categoryData!.data[index], context);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 5,
          );
        },
        itemCount: model!.categoryData!.data.length);
  }

  Widget categoryScreenitem(context, {required Data model}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(model.image!),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: 135,
                child: Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.cyan,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ShopCubit.get(context)
                        .getCategoryProduct(categoryId: model.id!);
                    navigateto(context,
                        screen: BlocProvider.value(
                            value: ShopCubit.get(context),
                            child: CategoryProduct(model.name)));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                    color: Colors.cyan,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showtoast({required String message, required Color color}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget button({
  required String name,
  required VoidCallback onpressed,
}) {
  return Container(
    width: 300,
    color: Colors.white,
    child: MaterialButton(
      height: 50,
      onPressed: onpressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          )),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.cyan,
        ),
      ),
    ),
  );
}
