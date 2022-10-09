import 'dart:js';

import 'package:swim_timer/pages/loading/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/create/create_page.dart';
import 'package:swim_timer/pages/home/home_page.dart';
import 'package:swim_timer/pages/join/join_page.dart';
import 'package:swim_timer/pages/practice/overview/overview_page.dart';
import 'package:swim_timer/pages/practice/practice_scaffold.dart';
import 'package:swim_timer/pages/practice/starter/starter_page.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_page.dart';
import 'package:swim_timer/pages/records/records_page.dart';
import 'package:go_router/go_router.dart';

class RoutingInformation {
  static final GoRouter myRouter = GoRouter(routes: [
    // Home
    GoRoute(
        path: '/',
        pageBuilder:
            makeSlideTransition(child: HomePage(), isRightToLeft: (_) => true)),

    // Join
    GoRoute(
        path: '/join',
        pageBuilder: makeBottomSlideUpTransition(const JoinPage())),

    // Create
    GoRoute(
        path: '/create',
        pageBuilder: makeBottomSlideUpTransition(const CreatePage())),

    // Records
    GoRoute(
        path: '/records',
        pageBuilder: makeBottomSlideUpTransition(const RecordsPage())),

    // Practice Not Found
    GoRoute(
      path: '/practice/:sessionId/not-found',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text("Practice not found")),
      ),
    ),

    // Loaded Practice
    ShellRoute(
      // Parent of practice sub-routes
      pageBuilder: (context, state, child) => makeBottomSlideUpTransition(
        PracticeScaffold(location: state.location, child: child),
      )(context, state),
      routes: [
        // Starter
        GoRoute(
          path: '/practice/:sessionID/starter',
          pageBuilder: makeSlideTransition(
              child: StarterPage(), isRightToLeft: (_) => false),
        ),

        // Stopper
        GoRoute(
          path: '/practice/:sessionID/stopper',
          pageBuilder: makeSlideTransition(
            child: StopperPage(),
            isRightToLeft: (state) {
              if (state.extra != null && state.extra.runtimeType == int) {
                int leaving = int.parse(state.extra.toString());
                return leaving < 1;
              }
              return false;
            },
          ),
        ),
        // Overview
        GoRoute(
          path: '/practice/:sessionID/overview',
          pageBuilder: makeSlideTransition(
              child: OverviewPage(), isRightToLeft: (_) => true),
        ),
      ],
    ),
    // Navigation to this route triggers a call to repository to change load pratice
    // then redirection
    GoRoute(
      path: "/practice/:sessionId/resolve",
      redirect: (context, state) async {
        final repository = context.read<PracticeRepository>();

        // If session isnt currently loaded
        if (state.params["sessionId"] != repository.sessionId) {
          // TODO: Actally update the repository in a meaningful way
          // I.E. the repository should provide data from a different session
          await Future.delayed(Duration(seconds: 2)).then(
              (value) => repository.sessionId = state.params["sessionId"]!);

          // TODO: Base this on if the change occured or not
          bool didFindSession = true;

          final baseLocation =
              state.location.substring(0, state.location.lastIndexOf("/"));

          // Redirect to starter if page found, else to /not-found
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
      pageBuilder: ((context, state) => makeBottomSlideUpTransition(LoadingPage(
          afterLoadingDisplay: (context) =>
              {context.go(state.location + '/resolve')}))(context, state)),
    )
  ]);
}

// Returns a delegate that can be used as a page builder that slide up
CustomTransitionPage<void> Function(BuildContext context, GoRouterState state)
    makeBottomSlideUpTransition(Widget child) {
  return (BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: Duration(milliseconds: 700),
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.fastLinearToSlowEaseIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  };
}

// Returns a delegate that can be used as a page builder that slides from the side
CustomTransitionPage<void> Function(BuildContext context, GoRouterState state)
    makeSlideTransition({
  bool Function(GoRouterState state)? isRightToLeft,
  required Widget child,
}) {
  return (context, state) {
    return CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: Duration(milliseconds: 500),
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          bool startOffsetRight =
              isRightToLeft != null ? isRightToLeft(state) : true;
          final begin =
              startOffsetRight ? const Offset(1.0, 0) : const Offset(-1.0, 0);

          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  };
}
