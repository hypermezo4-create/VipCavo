import 'package:deadzon/features/home/presentation/home_screen.dart';
import 'package:deadzon/features/mount/presentation/mount_screen.dart';
import 'package:deadzon/features/settings/presentation/settings_screen.dart';
import 'package:deadzon/features/statusbar/presentation/statusbar_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/statusbar',
      builder: (context, state) => const StatusbarScreen(),
    ),
    GoRoute(
      path: '/mount',
      builder: (context, state) => const MountScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);