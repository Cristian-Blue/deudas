import 'package:cuenta/config/router/router_admin.dart';
import 'package:cuenta/presentation/admin/layout/layout.dart';
import 'package:cuenta/presentation/public/auth/auth_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final storage = FlutterSecureStorage();
final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final token = await storage.read(key: 'token');

    final isLoginRoute = state.matchedLocation == '/';

    if (token == null) {
      return isLoginRoute ? null : '/';
    }

    if (token.isNotEmpty && isLoginRoute) {
      return '/admin/deuda';
    }

    return null;
  },
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
