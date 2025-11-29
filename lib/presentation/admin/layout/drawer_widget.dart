import 'package:cuenta/config/router/router_admin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerRoutes = routerConfigAdmin
        .where((res) => res.inDrawer)
        .toList();
    final currentLocation = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.last.matchedLocation;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=3",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "03578 - Cristian Andres Afanador",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "caafanadord@ufpso.edu.co",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          ...drawerRoutes.where((res) => res.inDrawer).map((res) {
            final isSelected = currentLocation == res.patch;

            return ListTile(
              selected: isSelected,
              selectedTileColor: Colors.grey[300],
              title: Text(res.name),
              leading: Icon(res.icon),
              onTap: () {
                Navigator.pop(context);
                if (!isSelected) {
                  context.go(res.patch);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
