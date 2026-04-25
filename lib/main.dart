import 'package:deadzon/core/router/app_router.dart';
import 'package:deadzon/core/theme/app_theme.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DeadzonThemeController>(create: (_) => createDeadzonThemeController()),
        ChangeNotifierProxyProvider<DeadzonThemeController, MountStudioController>(
          create: (context) => createMountStudioController(context.read<DeadzonThemeController>()),
          update: (context, themeController, controller) {
            controller ??= createMountStudioController(themeController);
            controller.updateThemeController(themeController);
            return controller;
          },
        ),
      ],
      child: const DeadzonApp(),
    ),
  );
}

class DeadzonApp extends StatelessWidget {
  const DeadzonApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<DeadzonThemeController>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DeadZone',
      theme: AppTheme.light(theme),
      darkTheme: AppTheme.dark(theme),
      themeMode: theme.themeMode,
      routerConfig: appRouter,
    );
  }
}
