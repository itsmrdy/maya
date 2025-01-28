import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maya/domain/model/entities/maya_user_entities.dart';
import 'package:maya/presentation/pages/maya_auth_screen.dart';
import 'package:maya/presentation/pages/maya_history_screen.dart';
import 'package:maya/presentation/pages/maya_send_money.dart';
import 'package:maya/presentation/pages/maya_wallet_balance_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MayaAuthScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'wallet',
          builder: (BuildContext context, GoRouterState state) {
            return MayaWalletBalanceScreen(
              user: state.extra as MayaUserEntities,
            );
          },
        ),
        GoRoute(
          path: 'sendMoney',
          builder: (BuildContext context, GoRouterState state) {
            return MayaSendMoney(
              user: state.extra as MayaUserEntities,
            );
          },
        ),
        GoRoute(
          path: 'historyScreen',
          builder: (BuildContext context, GoRouterState state) {
            return MayaHistoryScreen(userid: state.extra as int);
          },
        ),
      ],
    ),
  ],
);
