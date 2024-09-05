import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/app/helpers/navigation_helper.dart';
import 'package:obviously_test_final/app/widgets/balance_text.dart';
import 'package:obviously_test_final/app/widgets/fading_button.dart';
import 'package:obviously_test_final/app/widgets/loading_widget.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_bloc.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_event.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_state.dart';
import 'package:obviously_test_final/features/currency_converter/models/conversion_model.dart';
import 'package:obviously_test_final/features/currency_converter/widgets/conversion_row.dart';
import 'package:obviously_test_final/features/currency_converter/widgets/rate_row.dart';
import 'package:obviously_test_final/features/payment/widgets/recipient_text_field.dart';

class CurrencyConversionScreen extends StatelessWidget {
  const CurrencyConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Bloc bloc = context.read<ConversionBloc>();
    return BlocBuilder<ConversionBloc, ConversionState>(
      builder: (context, state) {
        if (!state.initialised) {
          bloc.add(FetchConversions());
          return const Scaffold(
            body: Center(
                child: LoadingWidget(
              label: 'Loading Conversion Data...',
            )),
          );
        }
        return Scaffold(
          backgroundColor: theme.primaryColor,
          appBar: AppBar(
            title: const DelayedDisplay(
                delay: Duration(milliseconds: 100),
                child: Text('Currency Converter')),
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  NavigationHelper.instance.back(context: context);

                  bloc.add(ResetBloc());
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BalanceText(
                        leading: state.selectedCurrency.key,
                        amount:
                            (state.inputAmount * state.selectedCurrency.rate)),
                    const SizedBox(
                      height: 30,
                    ),
                    ConversionRow(
                      onSearchItemTapped: (label) {
                        NavigationHelper.instance.back(context: context);

                        bloc.add(UpdateSelectedCurrency(
                            conversionModel: ConversionModel(
                                key: label,
                                rate: state.conversionData[label] ?? 1.0)));
                      },
                      listItems: state.conversionData.keys.toList(),
                      showSearchIcon: state.selectedCurrency.key == '',
                      selectedItem: state.selectedCurrency.key,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RateRow(
                      conversionSelected:
                          state.conversionData[state.selectedCurrency.key] !=
                              null,
                      rateString:
                          'x${state.conversionData[state.selectedCurrency.key] ?? 0.0}',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state.selectedCurrency.key != '')
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          'Enter GBP Amount:',
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                    if (state.selectedCurrency.key != '')
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 300),
                        // opacity: state.selectedCurrency.key != '' ? 1 : 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                                onTap: () {
                                  bloc.add(
                                      ToggleKeyboardVisible(isVisible: true));
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                onInput: (value) {
                                  try {
                                    bloc.add(UpdateInputAmount(
                                        amount: double.parse(value)));
                                  } catch (e) {
                                    bloc.add(UpdateInputAmount(amount: 0.0));
                                  }
                                }),
                          ],
                        ),
                      ),
                  ],
                ),
                if (Platform.isIOS)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FadingButton(
                      isVisible: state.keyboardVisible,
                      onTap: () {
                        bloc.add(ToggleKeyboardVisible(isVisible: false));
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
