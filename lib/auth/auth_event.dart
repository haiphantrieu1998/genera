import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => null;
}

class AppStarted extends AuthEvent {
  @override
  String toString() {
    return 'AppStarted';
  }
}

class CoinChangeEvent extends AuthEvent {
  final int coin; // trừ là âm, cộng thì dương => cộng coin ở app reposity

  CoinChangeEvent(this.coin);

  @override
  List<Object> get props => [coin];

  @override
  String toString() {
    return 'CoinChangeEvent';
  }
}
