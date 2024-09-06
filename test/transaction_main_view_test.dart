import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/app/animations/waves.dart';
import 'package:obviously_test_final/app/widgets/balance_text.dart';
import 'package:obviously_test_final/app/widgets/loading_widget.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_bloc.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_state.dart';
import 'package:obviously_test_final/features/transactions/models/transaction_model.dart';
import 'package:obviously_test_final/features/transactions/view/transactions_main_view.dart';
import 'package:obviously_test_final/features/transactions/widgets/action_card.dart';
import 'package:obviously_test_final/features/transactions/widgets/activity_list.dart';
import 'package:obviously_test_final/features/transactions/widgets/transactions_header.dart';

import 'transaction_main_view_test.mocks.dart';

// Generate Mocks
@GenerateMocks([TransactionBloc])
void main() {
  late MockTransactionBloc mockBloc;

  setUp(() {
    mockBloc = MockTransactionBloc();
  });

  testWidgets('TransactionsMainView shows loading when transactions are being fetched',
      (WidgetTester tester) async {
    // Mock the initial state
    final initialState = TransactionState(
      transactionsFetching: false,
      isLoading: true,
      allTransactions: [],
      currentBalance: 0,
    );

    // Mock the bloc's behavior
    when(mockBloc.state).thenReturn(initialState);
    when(mockBloc.stream).thenAnswer((_) => Stream.value(initialState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TransactionBloc>.value(
          value: mockBloc,
          child: const TransactionsMainView(),
        ),
      ),
    );

    // Verify that the loading widget is shown
    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets(
      'TransactionsMainView shows the transactions list when transactions are fetched successfully',
      (WidgetTester tester) async {
    // Mock the state where transactions have been fetched
    final mockTransactions = [
      TransactionModel(id: '', amount: 100.0, date: DateTime.now(), type: TransactionType.sentPayment), // Example transaction data
      TransactionModel(id: '', amount: 200.0, date: DateTime.now(), type: TransactionType.sentPayment),
    ];

    final fetchedState = TransactionState(
      transactionsFetching: true,
      isLoading: false,
      allTransactions: mockTransactions,
      currentBalance: 300.0, // Example balance
    );

    // Mock the bloc's behavior
    when(mockBloc.state).thenReturn(fetchedState);
    when(mockBloc.stream).thenAnswer((_) => Stream.value(fetchedState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TransactionBloc>.value(
          value: mockBloc,
          child: const TransactionsMainView(),
        ),
      ),
    );

    // Verify that the TransactionsHeader is shown
    expect(find.byType(TransactionsHeader), findsOneWidget);

    // Verify that the ActivityList is shown
    expect(find.byType(ActivityList), findsOneWidget);

  });


    testWidgets(
      'TransactionsMainView shows Balance, WaveAnimation and Action Card',
      (WidgetTester tester) async {
    // Mock the state where transactions have been fetched
    final mockTransactions = [
      TransactionModel(id: '', amount: 100.0, date: DateTime.now(), type: TransactionType.sentPayment), // Example transaction data
      TransactionModel(id: '', amount: 200.0, date: DateTime.now(), type: TransactionType.sentPayment),
    ];

    final fetchedState = TransactionState(
      transactionsFetching: true,
      isLoading: false,
      allTransactions: mockTransactions,
      currentBalance: 300.0, // Example balance
    );

    // Mock the bloc's behavior
    when(mockBloc.state).thenReturn(fetchedState);
    when(mockBloc.stream).thenAnswer((_) => Stream.value(fetchedState));

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TransactionBloc>.value(
          value: mockBloc,
          child: const TransactionsMainView(),
        ),
      ),
    );

    // Verify that the TransactionsHeader is shown
    expect(find.byType(BalanceText), findsOneWidget);

    // Verify that the ActivityList is shown
    expect(find.byType(ActionCard), findsOneWidget);

     // Verify that the Wave Animation is shown
    expect(find.byType(WaveAnimation), findsOneWidget);

  });
}
