import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/app/animations/waves.dart';
import 'package:obviously_test_final/app/helpers/navigation_helper.dart';
import 'package:obviously_test_final/app/screens/confirmation_screen.dart';
import 'package:obviously_test_final/app/widgets/keypad.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_bloc.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_event.dart';
import 'package:obviously_test_final/features/password_screen/bloc/password_state.dart';
import 'package:obviously_test_final/features/password_screen/widgets/password_indicator.dart';
import 'package:obviously_test_final/features/transactions/view/transactions_main_view.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state.authenticated) {
          return ConfirmationScreen(
            icon: const Icon(Icons.done_rounded),
            bypassFirstScreen: true,
            confirmationTitle: 'Password Correct',
            showActionButtons: false,
            onTap: () {
              NavigationHelper.instance
                  .offAll(context: context, page: const TransactionsMainView());
            },
          );
        }
        return Scaffold(
          backgroundColor: theme.primaryColor,
          body: Stack(
            children: [
              const Positioned(bottom: 0, child: WaveAnimation()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PasswordIndicator(
                    filledCircles: state.input.length,
                    filledColor: state.passError ? Colors.red : null,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  KeyPad(
                    handleInput: (input) {
                      context
                          .read<PasswordBloc>()
                          .add(HandlePassInput(input: input));
                    },
                    showDecimal: false,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
