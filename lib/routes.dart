import 'package:currency_exchange/ui/main/main_screen.dart';
import 'package:currency_exchange/ui/main/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'di/di_setup.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
          create: (BuildContext context) {
            return getIt<MainViewModel>();
          }, child: MainScreen()),
    ),
  ],
);
