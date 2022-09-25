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
import 'package:swim_timer/pages/loading/loading_page.dart';
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

  final PracticeRepository? currentPracticeRepository = null;

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

    // Practice Not Found
    GoRoute(
      path: '/practice/:sessionId/not-found',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text("Practice not found")),
      ),
    ),
    // Loaded Practice
    ShellRoute(
      // The parent object of all sub-routes
      builder: (context, state, child) {
        return PracticeScaffold(location: state.location, child: child);
      },
      routes: [
        // Starter
        GoRoute(
          path: '/practice/:sessionID/starter',
          builder: (context, state) {
            return StarterPage();
          },
        ),
        // Stopper
        GoRoute(
          path: '/practice/:sessionID/stopper',
          builder: (context, state) {
            return StopperPage();
          },
        ),
        // Overview
        GoRoute(
          path: '/practice/:sessionID/overview',
          builder: (context, state) {
            return OverviewPage();
          },
        ),
      ],
    ),
    // Route called to get repository to provide new session, then redirect to appropriate
    GoRoute(
      path: "/practice/:sessionId/resolve",
      redirect: (context, state) async {
        // Read in the repository
        final repository = context.read<PracticeRepository>();
        // IF the sessionId i want to have isnt the one in repository
        if (state.params["sessionId"] != repository.sessionId) {
          // TODO: Actally update the repository in a meaningful way
          // I.E. the repository should provide data from a different session
          await Future.delayed(Duration(seconds: 5)).then(
              (value) => repository.sessionId = state.params["sessionId"]!);

          // TODO: Base this on if the change occured or not
          bool didFindSession = true;

          final baseLocation =
              state.location.substring(0, state.location.lastIndexOf("/"));
          // If a session was redirect to starter of that session
          // Otherwise redirect to the page-not-found page
          return didFindSession
              ? baseLocation + "/starter"
              : baseLocation + "/not-found";
        } else {
          // If the repository already is providing from the session I want
          final baseLocation =
              state.location.substring(0, state.location.lastIndexOf("/"));
          return baseLocation + "/starter";
        }
      },
    ),
    // Loading screen that initiates redirect call
    GoRoute(
      path: "/practice/:sessionId",
      builder: (context, state) {
        // As soon as this page loads and displays a loading icon
        // It calls to go to the /resolve route which is actually
        // a redirection that is responsible for telling the repository
        // to load the session of sessionId
        return LoadingPage(
            afterLoadingDisplay: (context) =>
                {context.go(state.location + '/resolve')});
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
