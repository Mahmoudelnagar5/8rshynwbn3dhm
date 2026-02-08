class AuthState {}

class InitAuthState extends AuthState {}

class AuthSuccessState extends AuthState {}

class LoadingAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  String failMsg;
  FailureAuthState(this.failMsg);
}
