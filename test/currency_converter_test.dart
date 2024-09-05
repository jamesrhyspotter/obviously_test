import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:obviously_test_final/app/widgets/balance_text.dart';
import 'package:obviously_test_final/app/widgets/loading_widget.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_bloc.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_state.dart';
import 'package:obviously_test_final/features/currency_converter/models/conversion_model.dart';
import 'package:obviously_test_final/features/currency_converter/view/currency_conversion_screen.dart';
import 'package:obviously_test_final/features/currency_converter/widgets/conversion_row.dart';
import 'package:obviously_test_final/features/currency_converter/widgets/rate_row.dart';
import 'package:obviously_test_final/features/payment/widgets/recipient_text_field.dart';

import 'currency_converter_test.mocks.dart';

// Generate Mocks
@GenerateMocks([ConversionBloc])
void main() {
  late MockConversionBloc mockConversionBloc;

  setUp(() {
    mockConversionBloc = MockConversionBloc();
  });

  testWidgets('Currency Converter shows loading when not initialised',
      (WidgetTester tester) async {
    // Mock the initial state
    final initialConversionState = ConversionState(
      selectedCurrency: ConversionModel.fromEmpty(),
      initialised: false,
    );

    // Mock the bloc's behavior

    when(mockConversionBloc.state).thenReturn(initialConversionState);
    when(mockConversionBloc.stream)
        .thenAnswer((_) => Stream.value(initialConversionState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(providers: [
          BlocProvider<ConversionBloc>.value(
            value: mockConversionBloc,
          ),
        ], child: const CurrencyConversionScreen()),
      ),
    );

    // Verify that the buttons are present
    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets(
      'Currency Converter shows Balance text, convert row and rate when initalised',
      (WidgetTester tester) async {
    // Mock the initial state
    final initialConversionState = ConversionState(
      selectedCurrency: ConversionModel.fromEmpty(),
      initialised: true,
    );

    // Mock the bloc's behavior

    when(mockConversionBloc.state).thenReturn(initialConversionState);
    when(mockConversionBloc.stream)
        .thenAnswer((_) => Stream.value(initialConversionState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(providers: [
          BlocProvider<ConversionBloc>.value(
            value: mockConversionBloc,
          ),
        ], child: const CurrencyConversionScreen()),
      ),
    );

    // Verify that the widgets are present
    expect(find.byType(BalanceText), findsOneWidget);
    expect(find.byType(ConversionRow), findsOneWidget);
    expect(find.byType(RateRow), findsOneWidget);
  });

  testWidgets(
      'Tests when selected conversion model, text input is available',
      (WidgetTester tester) async {
    // Mock the initial state
    final initialConversionState = ConversionState(
      selectedCurrency: ConversionModel(rate: 2, key: 'XYZ'),
      initialised: true,
    );

    // Mock the bloc's behavior

    when(mockConversionBloc.state).thenReturn(initialConversionState);
    when(mockConversionBloc.stream)
        .thenAnswer((_) => Stream.value(initialConversionState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(providers: [
          BlocProvider<ConversionBloc>.value(
            value: mockConversionBloc,
          ),
        ], child: const CurrencyConversionScreen()),
      ),
    );

    final textInput = find.byType(CustomTextField);
    // Verify that the balance widget is present
    await tester.ensureVisible(textInput);
    expect(textInput, findsOneWidget);

    final internalTextField = find.descendant(
      of: textInput,
      matching: find.byType(TextField), // or TextFormField if that is used
    );

    expect(internalTextField, findsOneWidget);

  
  });
}
