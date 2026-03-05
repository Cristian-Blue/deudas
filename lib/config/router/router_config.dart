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
      builder: (context, state, child) {
        return Layout(
          child: child,
          title: state.topRoute?.name ?? 'Administrador',
        );
      },
      routes: [
        ...routerConfigAdmin.map((screen) {
          return GoRoute(
            path: screen.patch,
            builder: screen.screen,
            name: screen.name,
          );
        }),
      ],
    ),
  ],
);
