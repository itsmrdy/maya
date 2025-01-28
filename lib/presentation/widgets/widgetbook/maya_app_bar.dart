import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maya/application/injectors/injector.dart';
import 'package:maya/application/usecase/maya_auth_logout_cubit.dart';
import 'package:maya/domain/model/abstracts/cubits/app_state.dart';
import 'package:maya/domain/model/extensions/state_extensions.dart';
import 'package:maya/presentation/pages/maya_auth_screen.dart';
import 'package:maya/presentation/pages/maya_wallet_balance_screen.dart';

import '../../theme/themes.dart';

class MayaAppBar<T> extends StatelessWidget implements PreferredSizeWidget {
  const MayaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: T != MayaWalletBalanceScreen && T != MayaAuthScreen
          ? Padding(
              padding: const EdgeInsets.all(AppTheme.sm),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: FaIcon(FontAwesomeIcons.arrowLeft,
                    color: AppTheme.greyColor),
              ),
            )
          : null,
      title: SizedBox(
        height: 70,
        child: Image.asset('assets/images/maya_logo.jpg'),
      ),
      actions: T != MayaAuthScreen ? [_logoutbutton()] : null,
    );
  }

  Widget _logoutbutton() {
    return BlocProvider(
      create: (_) => serviceLocator<MayaAuthLogoutCubit>(),
      child: BlocListener<MayaAuthLogoutCubit, AppState>(
        listener: (context, state) {
          state.foldBloc<MayaAuthLogoutCubit, bool>(
            context: context,
            hasListened: (bool? hasLogout) => context.go('/'),
            hasFailure: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Sorry, please try again")),
              );
            },
          );
        },
        child: Builder(builder: (context) {
          return IconButton(
            onPressed: () =>
                context.read<MayaAuthLogoutCubit>()..dispatch(param: null),
            icon: FaIcon(
              Icons.logout,
              color: Colors.black,
            ),
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
