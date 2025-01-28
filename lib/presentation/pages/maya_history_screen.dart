import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/domain/model/extensions/state_extensions.dart';
import 'package:maya/presentation/theme/themes.dart';
import 'package:maya/presentation/widgets/widgetbook/maya_app_scaffold.dart';
import '../../application/parameters/maya_transaction_parameters.dart';
import '../../application/usecase/maya_fetch_transactions_cubit.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';

import '../../application/injectors/injector.dart';
import '../../domain/model/entities/maya_transactions_entities.dart';

final class MayaHistoryScreen extends StatelessWidget {
  const MayaHistoryScreen({
    super.key,
    required this.userid,
  });

  final int userid;

  @override
  Widget build(BuildContext context) {
    return MayaAppScaffold<MayaHistoryScreen>(
      child: BlocProvider(
        create: (_) => serviceLocator<MayaFetchTransactionsCubit>()
          ..dispatch(param: 
            MayaTransactionParameters(
              userId: userid,
            ),
          ),
        child: BlocBuilder<MayaFetchTransactionsCubit, AppState>(
          builder: (context, state) {
            return state.useBloc<MayaFetchTransactionsCubit,
                List<MayaTransactionsEntities>>(
              context: context,
              processing: () {
                return Center(child: CircularProgressIndicator());
              },
              loaded: (List<MayaTransactionsEntities>? transactions) {
                if (transactions!.isEmpty) return Text('No results found');

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: transactions.length + 1,
                  itemBuilder: (context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(left: AppTheme.sm),
                        child: Text(
                          'List of Transactions',
                          style: TextStyle(fontSize: AppTheme.medium),
                        ),
                      );
                    }
                    return ListTile(
                      title: Text("Amount Sent: ${transactions[index - 1].title ?? "-"}"),
                      subtitle: Text(transactions[index - 1].body ?? "-"),
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return Divider(color: Colors.black);
                  },
                );
              },
              loadFailed: () => Center(child: Text('An error occur')),
            );
          },
        ),
      ),
    );
  }
}
