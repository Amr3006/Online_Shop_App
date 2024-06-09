import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/BloCs%20and%20Cubits/ShopCubit/shop_cubit.dart';
import 'package:shop/Model%20Classes/CategoryClass.dart';
import 'package:shop/Shared/Components.dart';

import '../../Model Classes/ShopClasses.dart';
import '../../Shared/Constants.dart';
import '../../Shared/Variables.dart';

class productsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is SuccessChangeFavoriteState) {
          if (!state.status) {
            snackMessage(context: context, text: state.message);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: categories.isNotEmpty&&banners.isNotEmpty&&products.isNotEmpty,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => pageBuilder(context));
      },
    );
  }

  Widget pageBuilder(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15,),
            CarouselSlider(
                items: banners.map((e) => Image(
                          image: NetworkImage("${e.image}"),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    height: 250,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayInterval: const Duration(seconds: 5),
                    scrollDirection: Axis.horizontal,
                    reverse: false)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>listBuilder(context: context,data: categories[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 20,),
                  itemCount: categories.length),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.66,
                  children: List.generate(
                      products.length, (index) => gridBuilder(products[index],context))),
            )
          ],
        ),
  );

  Widget gridBuilder(Products product, BuildContext context) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage("${product.image}"),
              height: 200,
              width: double.infinity,
              fit: BoxFit.scaleDown,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${product.name}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.5),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Text(
                    "${product.price.round()} L.E",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.pink,fontSize: 20),),
                ),
                const Spacer(),
                IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavourites(product.id);
                    },
                    icon: Icon(
                      ShopCubit.get(context).favorites[product.id]==true ? Icons.favorite_rounded : Icons.favorite_border_outlined,
                      color: ShopCubit.get(context).favorites[product.id]==true ? Colors.pink : Colors.black,
                      size: 25,))
              ],
            )
          ],
        ),
      );

  Widget listBuilder({
    required BuildContext context,
    required CategoryData data
}) =>Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  Image(
  height: 100,
  width: 100,
  fit: BoxFit.cover,
  image: NetworkImage(data.image)),
  SizedBox(height: 10,),
  Container(
    width: 130,
    child: Text(data.name.toUpperCase(),
    textAlign: TextAlign.center,
    style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.1),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,),
  )
  ],
  );
}


