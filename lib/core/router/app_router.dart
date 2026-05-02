import 'package:deadzon/core/widgets/deadzon_shell.dart';
import 'package:deadzon/features/call/presentation/call_screen.dart';
import 'package:deadzon/features/control_center/presentation/control_center_screen.dart';
import 'package:deadzon/features/home/presentation/home_screen.dart';
import 'package:deadzon/features/hub/presentation/additional_pages.dart';
import 'package:deadzon/features/lock_screen/presentation/lock_screen_screen.dart';
import 'package:deadzon/features/mount/presentation/mount_screen.dart';
import 'package:deadzon/features/settings/presentation/settings_screen.dart';
import 'package:deadzon/features/statusbar/presentation/statusbar_screen.dart';
import 'package:deadzon/features/toolbox/presentation/toolbox_screen.dart';
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
    GoRoute(path: '/control-center', builder: (context, state) => const ControlCenterScreen()),
    GoRoute(path: '/statusbar', builder: (context, state) => const StatusbarScreen()),
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
    GoRoute(path: '/lock-screen', builder: (context, state) => const LockScreenScreen()),
    GoRoute(path: '/call', builder: (context, state) => const CallScreen()),
    GoRoute(path: '/gaming', builder: (context, state) => const GamingScreen()),
    GoRoute(path: '/other-favorite', builder: (context, state) => const OtherFavoriteScreen()),
    GoRoute(path: '/toolbox', builder: (context, state) => const ToolboxScreen()),
  ],
);
