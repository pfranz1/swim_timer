import 'package:firebase_organization_api/firebase_organization_api.dart';
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
import 'package:firebase_practice_api/firebase_practice_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set default value so issues reading from empty shared preference
  // https://stackoverflow.com/q/50687801
  // SharedPreferences.setMockInitialValues({});

  //move to after login
  final organizationApi = FirebaseOrganizationApi(orgID: "Organization1");

  final practiceApi =
      LocalStoragePracticeApi(plugin: await SharedPreferences.getInstance());

  final practiceRepository = PracticeRepository(practiceApi: practiceApi);

  BlocOverrides.runZoned(
    () {
      runApp(App(
        practiceRepository: practiceRepository,
      ));
    },
    // blocObserver: MyGlobalObserver(),
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
      debugShowCheckedModeBanner: false,
      routerConfig: RoutingInformation.myRouter,
      title: "Swim Timer",
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF10465F),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          color: Color(0xFFE6F3F9),
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Color(0xFF10465F),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
