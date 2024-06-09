import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/BloCs%20and%20Cubits/ShopCubit/shop_cubit.dart';


class ShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
      ..getProducts()
      ..getCategories()
      ..getFavorites()
      ..getProfile(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Salla",style: Theme.of(context).textTheme.bodyMedium,),
                Text("Go",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.pink),),
              ],
            ),),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: IconThemeData(
                  color: Colors.pink,
                  size: 40
              ),
              unselectedIconTheme: IconThemeData(
                  color: Colors.grey
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.shopping_cart),
                    ),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.apps),
                    ),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.favorite),
                    ),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.settings),
                    ),
                    label: ""
                )
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}