part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ChangeNavigationState extends ShopState {}

class LoadingProductsState extends ShopState {}

class SuccessProductsState extends ShopState {}

class FailedProductsState extends ShopState {}

class LoadingCategoryState extends ShopState {}

class SuccessCategoryState extends ShopState {}

class FailedCategoryState extends ShopState {}

class LoadingFavoritesState extends ShopState {}

class SuccessFavoritesState extends ShopState {}

class FailedFavoritesState extends ShopState {}

class SuccessChangeFavoriteState extends ShopState {
  final String message;
  final bool status;

  SuccessChangeFavoriteState(this.message,this.status);
}

class ChangingFavoriteState extends ShopState {}

class FailedChangeFavoriteState extends ShopState {}

class LoadingSettingsState extends ShopState {}

class SuccessSettingsState extends ShopState {}

class FailedSettingsState extends ShopState {}

class LoadingUpdateState extends ShopState {}

class SuccessUpdateState extends ShopState {
  final String message;
  SuccessUpdateState(this.message);
}

class FailedUpdateState extends ShopState {}
