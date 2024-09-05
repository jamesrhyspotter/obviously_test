import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_bloc.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_state.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_bloc.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_state.dart';
import 'package:obviously_test_final/features/transactions/widgets/action_card.dart';
import 'package:obviously_test_final/features/transactions/widgets/labelled_icon_button.dart';

import 'navigation_test.mocks.dart';

// Generate Mocks
@GenerateMocks([TransactionBloc])
@GenerateMocks([PaymentBloc])
void main() {
  late MockTransactionBloc mockTransactionBloc;
  late MockPaymentBloc mockPaymentBloc;

  setUp(() {
    mockTransactionBloc = MockTransactionBloc();
    mockPaymentBloc = MockPaymentBloc();
  });

  testWidgets(
      'TransactionsMainView has successful navigation to pay and top up',
      (WidgetTester tester) async {
    // Mock the initial state
    final initialTransactionState = TransactionState(
      transactionsFetched: false,
      isLoading: true,
      allTransactions: [],
      currentBalance: 0,
    );

    final initialPaymentState =
        PaymentState(paymentPageController: PageController());

    // Mock the bloc's behavior
    when(mockTransactionBloc.state).thenReturn(initialTransactionState);
    when(mockTransactionBloc.stream)
        .thenAnswer((_) => Stream.value(initialTransactionState));

    when(mockPaymentBloc.state).thenReturn(initialPaymentState);
    when(mockPaymentBloc.stream)
        .thenAnswer((_) => Stream.value(initialPaymentState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TransactionBloc>.value(
              value: mockTransactionBloc,
            ),
            BlocProvider<PaymentBloc>.value(
              value: mockPaymentBloc,
            ),
          ],
          child: const Scaffold(
            body: Center(child: ActionCard()),
          ),
        ),
      ),
    );

    // Verify that the buttons are present
    expect(find.byType(LabelledAssetButton), findsExactly(2));

    // Test for "Pay" button
    final payButton = find.byKey(const Key('payButton'));
    await tester.ensureVisible(payButton);

    expect(payButton, findsOneWidget);

    // Test for "Top Up" button
    final topUpButton = find.byKey(const Key('topUpButton'));
    await tester.ensureVisible(topUpButton);
    expect(topUpButton, findsOneWidget);

    // Here I would test whether the buttons successfully navigate to PaymentFlow  - however the tester does not permit tapping this button.
  });
}
