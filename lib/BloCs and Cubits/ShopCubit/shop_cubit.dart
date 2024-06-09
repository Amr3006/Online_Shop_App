import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Internet/DioHelper.dart';
import 'package:shop/Model%20Classes/FavoritesClass.dart';
import 'package:shop/Model%20Classes/ProfileClass.dart';
import 'package:shop/Screens/Shop%20Screens/Categories%20Screen.dart';
import 'package:shop/Screens/Shop%20Screens/Favourites%20Screen.dart';
import 'package:shop/Screens/Shop%20Screens/Products%20Screen.dart';
import 'package:shop/Screens/Shop%20Screens/Settings%20Screen.dart';
import 'package:shop/Shared/Components.dart';

import '../../Model Classes/CategoryClass.dart';
import '../../Model Classes/ShopClasses.dart';
import '../../Shared/Constants.dart';
import '../../Shared/Ending Points.dart';
import '../../Shared/Variables.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool? status;
  List<dynamic> temporaryBanners = [];
  List<dynamic> temporaryProducts = [];
  List<dynamic> temporaryCategories = [];
  List<dynamic> temporaryFavorites = [];
  List<Favorites> favoritesList = [];

  Map<int?, bool?> favorites = {};

  profileData? profile_data;

  void getProducts() {
    emit(LoadingProductsState());
    dioHelper.getData(url: HOME, token: token).then((value) {
      status = value.data["status"];
      if (status == true) {
        temporaryBanners = value.data["data"]["banners"];
        temporaryProducts = value.data["data"]["products"];
        temporaryBanners.forEach((element) {
          banners.add(Banners.fromMap(element));
        });
        temporaryProducts.forEach((element) {
          products.add(Products.fromMap(element));
        });
      }
      for (var element in products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(SuccessProductsState());
    }).catchError((error) {
      emit(FailedProductsState());
    });
  }

  void getCategories() {
    emit(LoadingCategoryState());
    dioHelper.getData(url: CATEGORIES).then((value) {
      temporaryCategories = value.data["data"]["data"];
      temporaryCategories.forEach((element) {
        categories.add(CategoryData.fromMap(element));
      });
      emit(SuccessCategoryState());
    }).catchError((error) {
      emit(FailedCategoryState());
      print("Error : ${error.toString()}");
    });
  }

  void changeFavourites(int? id) {
    favoritesList = [];
    favorites[id] = !favorites[id]!;
    emit(ChangingFavoriteState());
    dioHelper.postData(
        url: FAVORITES, token: token, data: {"product_id": id}).then((value) {
      if (!value.data["status"]) {
        favorites[id] = !favorites[id]!;
      } else {
        getFavorites();
      }
      emit(SuccessChangeFavoriteState(
          value.data["message"], value.data["status"]));
    }).catchError((error) {
      favorites[id] = !favorites[id]!;
      emit(FailedChangeFavoriteState());
    });
  }

  void getFavorites() {
    favoritesList = [];
    emit(LoadingFavoritesState());
    dioHelper.getData(url: FAVORITES, token: token).then((value) {
      emit(SuccessFavoritesState());
      if (value.data["status"] == true) {
        temporaryFavorites = value.data["data"]["data"];
        temporaryFavorites.forEach((element) {
          favoritesList.add(Favorites.fromMap(element["product"]));
        });
      }
    }).catchError((error) {
      emit(FailedFavoritesState());
      print(error.toString());
    });
  }

  void getProfile() {
    emit(LoadingSettingsState());
    dioHelper.getData(url: PROFILE, token: token).then((value) {
      emit(SuccessSettingsState());
      profile_data = profileData.fromJson(value.data);
    }).catchError((error) {
      emit(FailedSettingsState());
      print(error.toString());
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
}) {
    emit(LoadingUpdateState());
    dioHelper.putData(
      token: token,
        data: {
          "name":name,
          "email":email,
          "phone":phone,
        },
        url: UPDATE_PROFILE).then((value) {
          emit(SuccessUpdateState(value.data["message"]));
          if (value.data["status"]) {
            getProfile();
          }
    }).catchError((error) {
      emit(FailedUpdateState());
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    productsScreen(),
    categoriesScreen(),
    favouritesScreen(),
    settingsScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavigationState());
  }
}
