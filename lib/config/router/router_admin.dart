import 'package:cuenta/config/router/router_model.dart';
import 'package:cuenta/presentation/admin/screen_admin.dart';
import 'package:flutter/material.dart';

final routerConfigAdmin = <RouterModel>[
  RouterModel(
    name: 'adminDeuda',
    screen: (context, state) => const DeudaScreen(),
    title: 'Deuda',
    patch: '/admin/deuda',
    icon: Icons.shelves,
    description: '',
  ),
];
