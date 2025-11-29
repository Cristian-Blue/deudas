import 'package:cuenta/config/router/router_model.dart';
import 'package:cuenta/presentation/admin/deuda/detail_screen.dart';
import 'package:cuenta/presentation/admin/profile/profile_screen.dart';
import 'package:cuenta/presentation/admin/screen_admin.dart';
import 'package:flutter/material.dart';

final routerConfigAdmin = <RouterModel>[
  RouterModel(
    name: 'Products',
    screen: (context, state) => const DeudaScreen(),
    title: 'Deuda',
    patch: '/admin/deuda',
    icon: Icons.shelves,
    description: '',
  ),
  RouterModel(
    name: 'Detail Products',
    screen: (context, state) =>
        DetailScreen(id: state.pathParameters['id'] ?? ''),
    title: 'Deuda',
    patch: '/admin/deuda/:id',
    icon: Icons.shelves,
    description: '',
    inDrawer: false,
  ),
  RouterModel(
    name: 'Profile',
    screen: (context, state) => ProfileScreen(),
    title: 'Deuda',
    patch: '/admin/profile',
    icon: Icons.person,
    description: '',
  ),
];
