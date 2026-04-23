import 'package:deadzon/core/widgets/deadzon_shell.dart';
import 'package:deadzon/features/home/presentation/home_screen.dart';
import 'package:deadzon/features/hub/presentation/additional_pages.dart';
import 'package:deadzon/features/mount/presentation/mount_screen.dart';
import 'package:deadzon/features/settings/presentation/settings_screen.dart';
import 'package:deadzon/features/statusbar/presentation/statusbar_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => DeadzonShell(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(path: '/statusbar', builder: (context, state) => const StatusbarScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(path: '/mount', builder: (context, state) => const MountScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
          ],
        ),
      ],
    ),
    GoRoute(path: '/spoof-device', builder: (context, state) => const SpoofDeviceScreen()),
    GoRoute(path: '/control-center', builder: (context, state) => const ControlCenterScreen()),
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
    GoRoute(path: '/lockscreen', builder: (context, state) => const LockscreenScreen()),
    GoRoute(path: '/more-tools', builder: (context, state) => const MoreToolsScreen()),
  ],
);
