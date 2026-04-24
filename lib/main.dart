import 'package:deadzon/core/router/app_router.dart';
import 'package:deadzon/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: DeadzonApp()));
}

class DeadzonApp extends ConsumerWidget {
  const DeadzonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final accent = ref.watch(globalAccentProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Deadzon',
      theme: AppTheme.light(accent),
      darkTheme: AppTheme.dark(accent),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}