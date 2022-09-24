import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_practice_api/local_storage_practice_api.dart';
import 'package:practice_api/practice_api.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swim_timer/bloc_observer.dart';
import 'package:swim_timer/lane/lane.dart';
import 'package:swim_timer/pages/create/create_page.dart';
import 'package:swim_timer/pages/home/home_page.dart';
import 'package:swim_timer/pages/join/join_page.dart';
import 'package:swim_timer/pages/practice/overview/overview_page.dart';
import 'package:swim_timer/pages/practice/practice_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swim_timer/pages/practice/practice_scaffold.dart';
import 'package:swim_timer/pages/practice/starter/starter_page.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_page.dart';
import 'package:swim_timer/pages/records/records_page.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

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

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/join',
      builder: (context, state) {
        return const JoinPage();
      },
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) {
        return const CreatePage();
      },
    ),
    GoRoute(
      path: '/records',
      builder: (context, state) {
        return const RecordsPage();
      },
    ),
    ShellRoute(
        builder: (context, state, child) {
          print(
              "Full path ${state.location.split("/").reversed.skip(1).take(1).first}");

          final locationValues = state.location.split("/").sublist(1);

          final role = locationValues.elementAt(2);
          final sessionId = locationValues.elementAt(1);

          print("role $role sessionId $sessionId");

          // context
          //     .read<PracticeRepository>()
          //     .addSwimmer(Swimmer(name: "ROUTING SWIMMER!"));
          return PracticeScaffold(location: state.location, child: child);
        },
        routes: [
          GoRoute(
            path: '/practice/:sessionID/starter',
            builder: (context, state) {
              print("Session ID Lower: ${state.params["sessionID"]}");

              return StarterPage();
            },
          ),
          GoRoute(
            path: '/practice/:sessionID/stopper',
            builder: (context, state) {
              return StopperPage();
            },
          ),
          GoRoute(
            path: '/practice/:sessionID/overview',
            builder: (context, state) {
              return OverviewPage();
            },
          ),
        ]),
    GoRoute(
      path: '/practice/:sessionId',
      builder: (context, state) {
        final sessionId = state.params['sessionId'];
        print(sessionId);
        return const PracticePage();
      },
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Swim Timer",
    );
  }
}
