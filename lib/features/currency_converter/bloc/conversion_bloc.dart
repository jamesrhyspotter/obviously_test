import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_event.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_state.dart';
import 'package:obviously_test_final/features/currency_converter/data/currency_api_client.dart';
import 'package:obviously_test_final/features/currency_converter/models/conversion_model.dart';

class ConversionBloc extends Bloc<ConversionEvent, ConversionState> {
  ConversionBloc()
      : super(ConversionState(selectedCurrency: ConversionModel.fromEmpty())) {
    on<FetchConversions>((event, emit) async {
      Map<String, dynamic> data = await CurrencyApiClient().fetchConversions();
      Map<String, dynamic> finalData = {};
      emit(state.copyWith(initialised: true));

      try {
        finalData = data['rates'];
        finalData.remove('GBP');
      } catch (e) {
        debugPrint('Could not convert data');
      }

      emit(state.copyWith(
          initialised: true,
          conversionData: finalData,
          conversionDataSearchResults: finalData));
    });

    on<UpdateSelectedCurrency>((event, emit) {
      emit(state.copyWith(selectedCurrency: event.conversionModel));
    });

    on<UpdateInputAmount>((event, emit) {
      emit(state.copyWith(inputAmount: event.amount));
    });

    on<ToggleKeyboardVisible>((event, emit) {
      emit(state.copyWith(keyboardVisible: event.isVisible));
    });

    on<ResetBloc>((event, emit) {
      emit(state.copyWith(
          keyboardVisible: false,
          inputAmount: 0,
          selectedCurrency: ConversionModel.fromEmpty()));
    });
  }
}
