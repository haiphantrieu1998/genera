import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geneexpert/screen/favorite/favorite_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


import 'auth/apprepository.dart';
import 'auth/bloc.dart';
import 'base/const.dart';
import 'page/generator/model/recent_model.dart';
import 'navigation.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint('SimpleBlocDelegate onEvent $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('SimpleBlocDelegate onTransition $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugPrint('SimpleBlocDelegate onError $error');
  }
}
// const String favoriteName = "favorites";

void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: Const.appId);

 var appDocDirectory = await getApplicationDocumentsDirectory();
 Directory directory = await Directory(appDocDirectory.path + '/' + 'dir')
     .create(recursive: true);
 Hive
   ..init(directory.path)
   ..registerAdapter(FavoriteModelAdapter())
   ..registerAdapter(RecentModelAdapter());
//    ..registerAdapter(UserModelAdapter());
 final AppRepository userRep = AppRepository();
 BlocSupervisor.delegate = SimpleBlocDelegate();
runApp(
    RepositoryProvider(
      create: (context) => userRep,
      child: BlocProvider(
        create: (context) => AuthBloc(userRep)..add(AppStarted()),
        child: MyApp(),
      ),
    ),
  );
}
