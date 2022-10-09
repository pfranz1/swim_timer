import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_practice_api/local_storage_practice_api.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swim_timer/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swim_timer/routing_information.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set default value so issues reading from empty shared preference
  // https://stackoverflow.com/q/50687801
  // SharedPreferences.setMockInitialValues({});

  final practiceApi =
      LocalStoragePracticeApi(plugin: await SharedPreferences.getInstance());

  final practiceRepository = PracticeRepository(practiceApi: practiceApi);

  BlocOverrides.runZoned(
    () {
      runApp(App(
        practiceRepository: practiceRepository,
      ));
    },
    blocObserver: MyGlobalObserver(),
  );
}

class App extends StatelessWidget {
  const App({super.key, required this.practiceRepository});

  final PracticeRepository practiceRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: practiceRepository,
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({super.key});

  final PracticeRepository? currentPracticeRepository = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RoutingInformation.myRouter,
      title: "Swim Timer",
    );
  }
}
