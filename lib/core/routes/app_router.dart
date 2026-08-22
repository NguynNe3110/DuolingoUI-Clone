import 'package:duolingo_ui_clone/features/main/call/call_screen.dart';
import 'package:duolingo_ui_clone/features/main/mission/screens/mission_screen.dart';
import 'package:duolingo_ui_clone/features/main/practices/practices_screen.dart';
import 'package:duolingo_ui_clone/features/main/profile/screens/profile_screen.dart';
import 'package:duolingo_ui_clone/features/main/pronounce/pronounce_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/main/leaderboard/screens/leaderboard_screen.dart';
import '../../features/main/lesson/screens/lesson_result_screen.dart';
import '../../features/main/lesson/screens/lesson_screen.dart';
import '../../features/main/lesson/screens/loading_screen.dart';
import '../../features/main/newsfeed/screens/news_feed_screen.dart';
import '../../features/mock_screen/MockScreen.dart';
import '../../features/main/home/screens/home_screen.dart';
import '../../features/main/main_shell.dart';
import '../../features/mock_screen/ui_cheat_sheet_app.dart';
import '../../features/mock_screen/ui_property_reference.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/start/login/login_screen.dart';
import '../../features/start/first/after_splash_screen.dart';

final GoRouter MockScreenRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/lesson-loading',
  routes: [
    GoRoute(
      path: '/lesson-loading',
      builder: (context, state) => LoadingScreen(
        nextPath: state.uri.queryParameters['next'] ?? '/lesson-result',
      ),
    ),
    GoRoute(path: '/lesson', builder: (context, state) => const LessonScreen()),
    GoRoute(
      path: '/lesson-result',
      builder: (context, state) => const LessonResultScreen(),
    ),
  ],
);

final _homeRoute = GoRoute(
  path: '/home',
  name: 'home',
  builder: (_, _) => const HomeScreen(),
);
final _missionRoute = GoRoute(
  path: '/mission',
  name: 'mission',
  builder: (_, _) => const MissionScreen(),
);
final _leaderboardRoute = GoRoute(
  path: '/leaderboard',
  name: 'leaderboard',
  builder: (_, _) => const LeaderboardScreen(),
);
final _communityRoute = GoRoute(
  path: '/newsfeed',
  name: 'newsfeed',
  builder: (_, _) => NewsFeedScreen(),
);
final _profileRoute = GoRoute(
  path: '/profile',
  name: 'profile',
  builder: (_, _) => const ProfileScreen(),
);

final _moreRoute = GoRoute(
  path: '/more',
  redirect: (context, state) =>
      state.uri.path == '/more' ? '/more/pronounce' : null,
  // 👆 chỉ redirect khi đích đến ĐÚNG LÀ '/more',
  //    còn '/more/call', '/more/practices' thì đi thẳng vào route con
  routes: [
    GoRoute(
      path: 'pronounce',
      name: 'pronounce',
      builder: (_, _) => const PronounceScreen(),
    ),
    GoRoute(path: 'call', name: 'call', builder: (_, _) => const CallScreen()),
    GoRoute(
      path: 'practices',
      name: 'practices',
      builder: (_, _) => const PracticesScreen(),
    ),
  ],
);
final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ), // phai doi thanh splash
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/after-splash',
      name: 'after-splash',
      builder: (context, state) => AfterSplashScreen(),
    ),
    GoRoute(
      path: '/lesson-loading',
      builder: (context, state) => LoadingScreen(
        nextPath: state.uri.queryParameters['next'] ?? '/lesson-result',
      ),
      name: 'lesson-loading'
    ),
    GoRoute(path: '/lesson', builder: (context, state) => const LessonScreen()),
    GoRoute(
      path: '/lesson-result',
      builder: (context, state) => const LessonResultScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [_homeRoute]),
        StatefulShellBranch(routes: [_missionRoute]),
        StatefulShellBranch(routes: [_leaderboardRoute]),
        StatefulShellBranch(routes: [_communityRoute]),
        StatefulShellBranch(routes: [_profileRoute]),
        StatefulShellBranch(routes: [_moreRoute]),
      ],
    ),

    GoRoute(
      path: '/lesson-result',
      builder: (context, state) => const LessonResultScreen(),
    ),

  ],
);

final GoRouter MockComponentRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => Mockscreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [_homeRoute]),
        StatefulShellBranch(routes: [_missionRoute]),
        StatefulShellBranch(routes: [_leaderboardRoute]),
        StatefulShellBranch(routes: [_communityRoute]),
        StatefulShellBranch(routes: [_profileRoute]),
      ],
    ),
  ],
);

final GoRouter UiCheatRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => UiCheatSheetApp())],
);

/// Router cho "TỪ ĐIỂN THUỘC TÍNH FLUTTER" (file ui_property_reference.dart).
/// Mở bằng cách đổi main.dart:  routerConfig: UiPropertyReferenceRouter,
final GoRouter UiPropertyReferenceRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const UiPropertyReferenceApp(),
    ),
  ],
);
