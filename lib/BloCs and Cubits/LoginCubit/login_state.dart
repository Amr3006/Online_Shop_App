part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class loginInitialState extends LoginState {}

class changePasswordObsecurityState extends LoginState {}

class loadingLoginState extends LoginState {}

class successLoginState extends LoginState {
  final LoginData result;
  successLoginState(this.result);
}

class failedLoginState extends LoginState {
  final String error;
  failedLoginState(this.error);
}

class loadingRegisterState extends LoginState {}

class successRegisterState extends LoginState {
  final String message;
  final bool status;
  successRegisterState(this.message,this.status);
}

class failedRegisterState extends LoginState {
  final String error;
  failedRegisterState(this.error);
}
