import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maya/application/usecase/maya_check_session_cubit.dart';
import 'package:maya/domain/model/extensions/app_extensions.dart';
import 'package:maya/presentation/widgets/widgetbook/maya_app_scaffold.dart';
import '../../domain/model/entities/maya_user_entities.dart';
import '../../application/injectors/injector.dart';
import '../../application/parameters/maya_auth_parameters.dart';
import '../../application/usecase/auth_user_cubit.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';
import '../../domain/model/extensions/state_extensions.dart'
    as state_extensions;
import '../theme/themes.dart';
import '../widgets/widgetbook/maya_text_button.dart';

import '../widgets/widgetbook/maya_app_form_field.dart';

base class MayaAuthScreen extends StatefulWidget {
  const MayaAuthScreen({super.key});

  @override
  State<MayaAuthScreen> createState() => _MayaAuthScreenState();
}

final class _MayaAuthScreenState extends State<MayaAuthScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthUserCubit>()),
        BlocProvider(
          create: (_) =>
              serviceLocator<MayaCheckSessionCubit>()..dispatch(param: null),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthUserCubit, AppState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              state.foldBloc<AuthUserCubit, MayaUserEntities>(
                context: context,
                hasListened: (MayaUserEntities? user) {
                  if (user != null) {
                    context.pushReplacement("/wallet", extra: user);
                    return;
                  }
                  return;
                },
                hasFailure: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid username or password")),
                  );
                  return;
                },
              );
            },
          ),
          BlocListener<MayaCheckSessionCubit, AppState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              state.foldBloc<MayaCheckSessionCubit, String?>(
                context: context,
                hasListened: (String? user) {
                  if (user != null) {
                    context.pushReplacement("/wallet",
                        extra: user.toUserEntity());
                    return;
                  }
                  return;
                },
                hasFailure: () {},
              );
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return MayaAppScaffold<MayaAuthScreen>(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.sm),
                color: AppTheme.baseColor,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .15,
                        child: Image.asset('assets/images/maya_logo.jpg'),
                      ),
                      MayaAppFormField(
                        labelText: "Email address or mobile number",
                        onChanged: (String? uname) => username = uname,
                      ),
                      const SizedBox(height: AppTheme.sm),
                      MayaAppFormField(
                        labelText: "Password",
                        isPasswordField: true,
                        onChanged: (String? pword) => password = pword,
                      ),
                      const SizedBox(height: AppTheme.large),
                      MayaTextButton(
                        buttonText: "Login",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthUserCubit>(context).dispatch(
                              param: MayaAuthParameters(
                                username: username ?? "",
                                password: password ?? "",
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
