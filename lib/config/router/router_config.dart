import 'package:cuenta/config/router/router_admin.dart';
import 'package:cuenta/presentation/admin/layout/layout.dart';
import 'package:cuenta/presentation/public/auth/auth_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const AuthScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => Layout(child: child),
      routes: [
        ...routerConfigAdmin
            .where((s) => s.inDrawer)
            .map(
              (screen) => GoRoute(
                path: screen.patch,
                builder: screen.screen,
                name: screen.name,
              ),
            ),
      ],
    ),
  ],
);
