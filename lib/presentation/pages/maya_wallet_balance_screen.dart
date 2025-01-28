import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:maya/application/injectors/injector.dart';
import 'package:maya/application/usecase/wallet_balance_cubit.dart';
import 'package:maya/domain/model/extensions/app_extensions.dart';
import 'package:maya/presentation/theme/themes.dart';
import 'package:maya/presentation/widgets/widgetbook/maya_text_button.dart';
import '../../domain/model/entities/maya_user_entities.dart';
import '../widgets/widgetbook/maya_app_scaffold.dart';

final class MayaWalletBalanceScreen extends StatelessWidget {
  MayaWalletBalanceScreen({
    super.key,
    required this.user,
  });

  final MayaUserEntities user;
  final List<String> imageCarouselList = [
    'https://theblueink.com/wp-content/uploads/images/Maya-Liza-Soberano-Dolly-De-Leon-01.jpg',
    'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/46/54/0b/46540b2b-cc82-95cc-4af4-6bfef261db0e/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/1200x600wa.png',
  ];

  @override
  Widget build(BuildContext context) {
    return MayaAppScaffold<MayaWalletBalanceScreen>(
      child: Container(
        margin: const EdgeInsets.all(AppTheme.sm),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .20,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppTheme.xs, right: AppTheme.xs, top: AppTheme.sm),
                  child: Column(
                    children: [
                      _TogglableWalletBalance(
                        balance: user.balance.toString(),
                      ),
                      const SizedBox(height: AppTheme.medium),
                      Row(
                        children: [
                          Expanded(
                            child: MayaTextButton(
                              buttonText: "Send",
                              fontSize: AppTheme.sm,
                              onPressed: () =>
                                  context.push('/sendMoney', extra: user),
                            ),
                          ),
                          const SizedBox(width: AppTheme.xs),
                          Expanded(
                            child: MayaTextButton(
                              buttonText: "View Transaction",
                              fontSize: AppTheme.sm,
                              onPressed: () => context.push("/historyScreen",
                                  extra: user.userid),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.large),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: imageCarouselList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        i,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _TogglableWalletBalance extends StatelessWidget {
  const _TogglableWalletBalance({required this.balance});

  final String balance;

  final String obscureBalance = '*********';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<WalletBalanceCubit>(),
      child: BlocBuilder<WalletBalanceCubit, bool>(
        builder: (context, hasToggle) {
          return ListTile(
            title: Text(
              hasToggle ? '₱ $obscureBalance' : '${balance.toNumberFormat()}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Wallet balance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              onPressed: () => context
                  .read<WalletBalanceCubit>()
                  .toggle(hasToggle = !hasToggle),
              icon: FaIcon(
                hasToggle ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              ),
            ),
          );
        },
      ),
    );
  }
}
