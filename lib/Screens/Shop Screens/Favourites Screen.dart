import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/BloCs%20and%20Cubits/ShopCubit/shop_cubit.dart';
import 'package:shop/Model%20Classes/FavoritesClass.dart';
import 'package:shop/Shared/Variables.dart';

class favouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ChangingFavoriteState&&state is! LoadingFavoritesState,
            builder: (context) =>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                child: ListView.separated(
                    itemBuilder: (context, index) => listBuilder(
                        context: context, favorite: ShopCubit.get(context).favoritesList[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemCount: ShopCubit.get(context).favoritesList.length),
              ),
            ),
            fallback: (context) =>Center(child: CircularProgressIndicator(),));
      },
    );
  }

  Widget listBuilder(
          {required BuildContext context, required Favorites favorite}) =>
      Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 140,
              width: 140,
              color: Colors.white,
              child: Image(
                  fit: BoxFit.scaleDown,
                  image: NetworkImage("${favorite.image}")),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${favorite.name}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 25),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${favorite.price} L.E",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.pink),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.chevron_right,
                  size: 40,
                ),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavourites(favorite.id);
                  },
                  icon: Icon(
                    ShopCubit.get(context).favorites[favorite.id] == true
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_outlined,
                  ),
                  color: ShopCubit.get(context).favorites[favorite.id] == true
                      ? Colors.pink
                      : Colors.black,
                )
              ],
            )
          ],
        ),
      );
}
