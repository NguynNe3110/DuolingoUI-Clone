import 'package:duolingo_ui_clone/features/main/call/call_screen.dart';
import 'package:duolingo_ui_clone/features/main/community/community_screen.dart';
import 'package:duolingo_ui_clone/features/main/mission/screens/mission_screen.dart';
import 'package:duolingo_ui_clone/features/main/practices/practices_screen.dart';
import 'package:duolingo_ui_clone/features/main/profile/profile_screen.dart';
import 'package:duolingo_ui_clone/features/main/pronounce/pronounce_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

import '../../features/main/leaderboard/screens/leaderboard_screen.dart';
import '../../features/mock_screen/MockScreen.dart';
import '../../features/main/home/screens/home_screen.dart';
import '../../features/main/main_shell.dart';
import '../../features/mock_screen/MockScreen2.dart';
import '../../features/mock_screen/MockScreen3.dart';
import '../../features/mock_screen/mock_home_screen.dart';
import '../../features/mock_screen/mock_home_screen1.dart';
import '../../features/mock_screen/ui_cheat_sheet_app.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/start/first/after_splash_screen.dart';
import '../../features/start/first/login_screen.dart';

final GoRouter MockScreenRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => LeaderboardScreen()),
  ],
);

// final GoRouter appRouter = GoRouter(
//   debugLogDiagnostics: true, // in ra log path cua gorouter
//   initialLocation: '/',
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => SplashScreen()),
//     // ...ProjectRoute.projectRoute,
//     // ...Stage1Route.stage1Route,
//     // ...Stage2Route.stage2Route,
//     // ...Stage3Route.stage3Route,
//     // ...Stage4Route.stage4Route,
//     // ...Stage5Route.stage5Route,
//     // ...Stage6Route.stage6Route,
//     // ...Stage7Route.stage7Route,
//     // ...Stage8Route.stage8Route,
//     // ...Stage9Route.stage9Route,
//     // ...TestRoute.testRoute,
//   ],
// );
final _homeRoute = GoRoute(path: '/home', name: 'home', builder: (_, _) => const HomeScreen());
final _missionRoute = GoRoute(path: '/mission', name: 'mission', builder: (_, _) => const MissionScreen());
final _leaderboardRoute = GoRoute(path: '/leaderboard', name: 'leaderboard', builder: (_, _) => const LeaderboardScreen());
final _communityRoute = GoRoute(path: '/community', name: 'community', builder: (_, _) => const CommunityScreen());
final _profileRoute = GoRoute(path: '/profile', name: 'profile', builder: (_, _) => const ProfileScreen());

final _moreRoute = GoRoute(
  path: '/more',
  redirect: (context, state) =>
  state.uri.path == '/more' ? '/more/pronounce' : null,
  // 👆 chỉ redirect khi đích đến ĐÚNG LÀ '/more',
  //    còn '/more/call', '/more/practices' thì đi thẳng vào route con
  routes: [
    GoRoute(path: 'pronounce', name: 'pronounce', builder: (_, _) => const PronounceScreen()),
    GoRoute(path: 'call', name: 'call', builder: (_, _) => const CallScreen()),
    GoRoute(path: 'practices', name: 'practices', builder: (_, _) => const PracticesScreen()),
  ],
);
final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()), // phai doi thanh splash
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
  ],
);


final GoRouter MockComponentRouter = GoRouter(
  debugLogDiagnostics: true, // in ra log path cua gorouter
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => Mockscreen3()),
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
  routes: [
    GoRoute(path: '/', builder: (context, state) => UiCheatSheetApp()),
  ],
);

