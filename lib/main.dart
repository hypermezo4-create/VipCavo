import 'package:deadzon/core/router/app_router.dart';
import 'package:deadzon/core/theme/app_theme.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: DeadzonApp()));
}

class DeadzonApp extends ConsumerWidget {
  const DeadzonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(deadzonThemeControllerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Deadzon',
      theme: AppTheme.light(theme),
      darkTheme: AppTheme.dark(theme),
      themeMode: theme.themeMode,
      routerConfig: appRouter,
    );
  }
}
