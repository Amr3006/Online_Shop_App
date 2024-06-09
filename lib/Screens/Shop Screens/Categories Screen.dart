import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/BloCs%20and%20Cubits/ShopCubit/shop_cubit.dart';
import 'package:shop/Model%20Classes/CategoryClass.dart';
import 'package:shop/Shared/Constants.dart';

import '../../Shared/Variables.dart';

class categoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: categories.isNotEmpty,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
                itemBuilder: (context, index) => listBuilder(
                    context: context, categoryData: categories[index]),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 4),
                      child: Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.pinkAccent.withOpacity(0.6),
                      ),
                    ),
                itemCount: categories.length),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget listBuilder(
    {required BuildContext context, required CategoryData categoryData}) {
  return Row(
    children: [
      Image(height: 120, width: 120, image: NetworkImage(categoryData.image)),
      Expanded(
        child: Text(
          categoryData.name.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          Icons.chevron_right,
          size: 50,
        ),
      )
    ],
  );
}
