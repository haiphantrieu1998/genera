import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import './bloc.dart';
import 'apprepository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.userRes) {
    _init();
  }

  void _init() async {
    box = await Hive.openBox(_coinKey);
  }

  final AppRepository userRes;
  static final String _coinKey = 'coinKey';
  var box;

  @override
  AuthState get initialState => Initialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _handleStart();
    } else if (event is CoinChangeEvent) {
      yield* _handleCoin(event);
    }
  }

  Stream<AuthState> _handleStart() async* {
    box ??= await Hive.openBox(_coinKey);
    int value = box.get(_coinKey);
    userRes.coin = value ?? 20;
    yield AppInited();
  }

  Stream<AuthState> _handleCoin(CoinChangeEvent event) async* {
    int coin = event.coin;
    userRes.coin += coin;
    yield Initialized();
    yield AppInited();
    box ??= await Hive.openBox(_coinKey);
    box.put(_coinKey, userRes.coin);
  }
}
