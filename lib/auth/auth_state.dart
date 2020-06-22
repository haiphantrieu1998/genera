import 'package:equatable/equatable.dart';

 class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => null;
}

class Initialized extends AuthState {
 @override
  String toString() {
    return 'Initialized';
  }
}
class AppInited extends AuthState {
 @override
  String toString() {
    return 'AppInited';
  }
}

