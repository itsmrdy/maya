import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/application/injectors/injector.dart';
import 'package:maya/application/parameters/maya_transaction_parameters.dart';
import 'package:maya/application/usecase/maya_post_transactions_cubit.dart';
import 'package:maya/domain/model/entities/maya_user_entities.dart';
import 'package:maya/presentation/widgets/widgetbook/maya_text_button.dart';

import '../../domain/model/abstracts/cubits/app_state.dart';
import '../theme/themes.dart';
import '../widgets/widgetbook/maya_app_form_field.dart';
import '../widgets/widgetbook/maya_app_scaffold.dart';

base class MayaSendMoney extends StatefulWidget {
  const MayaSendMoney({
    super.key,
    required this.user,
  });

  final MayaUserEntities user;

  @override
  State<MayaSendMoney> createState() => _MayaSendMoneyState();
}

final class _MayaSendMoneyState extends State<MayaSendMoney> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MayaUserEntities? user;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<MayaPostTransactionsCubit>(),
      child: BlocListener<MayaPostTransactionsCubit, AppState>(
        listener: (context, listenerState) {
          if (listenerState is AppReturnFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Sorry we can't proceed on your request",
                ),
              ),
            );
          } else if (listenerState is AppReturnSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Request has been sent amounting: ${textEditingController.text}",
                ),
              ),
            );
            textEditingController.clear();
          }
        },
        child: Builder(
          builder: (context) {
            return MayaAppScaffold<MayaSendMoney>(
              child: Form(
                key: formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppTheme.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please enter the amount you'd like to send. Make sure \nthe value is correct before proceeding with the transaction.",
                        style: TextStyle(
                            fontSize: AppTheme.sm, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppTheme.sm),
                      MayaAppFormField(
                        controller: textEditingController,
                        labelText: 'Amount',
                        prefixText: '₱',
                        textInputType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatter: [_DecimalInputFormatter()],
                        maxLength: 11,
                      ),
                      const SizedBox(height: AppTheme.sm),
                      MayaTextButton(
                        buttonText: "Send Money",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (user != null) {
                              context
                                  .read<MayaPostTransactionsCubit>()
                                  .dispatch(param:
                                    MayaTransactionParameters(
                                      userId: user?.userid ?? 0,
                                      id: Random().nextInt(100),
                                      title: user?.username ?? "",
                                      body: textEditingController.text,
                                    ),
                                  );
                            }
                          }
                        },
                      ),
                      const Spacer(),
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

final class _DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Regular expression to allow digits and at most one decimal point
    String newText = newValue.text;

    // Check if the input has more than one decimal point
    if (newText.contains('.') && newText.split('.').length > 2) {
      newText = oldValue.text; // Revert to previous value if multiple decimals
    } else {
      newText = newText.replaceAll(
          RegExp(r'[^0-9.]'), ''); // Allow digits and one decimal
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
