import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop/Internet/DioHelper.dart';
import 'package:shop/Model%20Classes/LoginClasses.dart';
import 'package:shop/Shared/CacheHelper.dart';
import 'package:shop/Shared/Components.dart';
import 'package:shop/Shared/Ending%20Points.dart';

import '../../Shared/Constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(loginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool obscured = true;
  LoginData loginData=LoginData.fromMap({
    "status":false,
    "message":"",
  });

  late UserData userData;

  void changeObscured() {
    obscured = !obscured;
    emit(changePasswordObsecurityState());
  }

  void login(
      {required String email,
      required String password,
      Map<String, dynamic>? query}) {
    emit(loadingLoginState());
    dioHelper
        .postData(url: LOGIN,
        query: query,
        data: {
          "email" : email,
          "password" : password
        })
        .then((value) {
          print(value.data);
            loginData=LoginData.fromMap(value.data);
            if (value.data["data"]!=null) {
              userData=UserData.fromMap(value.data["data"]);
              cacheHelper.saveData(key: "token", value: userData.token);
              token = userData.token;
            }
      emit(successLoginState(loginData));
    }).catchError((error) {
      print(error.toString());
      emit(failedLoginState(error.toString()));
    });
  }
  
  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
}) {
    emit(loadingRegisterState());
    dioHelper.postData(
        data: {
          "name":name,
          "phone":phone,
          "email":email,
          "password":password,
        },
        url: REGISTER).then((value) {
          emit(successRegisterState(value.data["message"],value.data["status"]));
          if (value.data["status"]) {
            token = value.data["data"]["token"];
          }
    }).catchError((error) {
      emit(failedRegisterState(error.toString()));
    });
  }
}
