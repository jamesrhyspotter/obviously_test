import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obviously_test_final/features/currency_converter/bloc/conversion_bloc.dart';
import 'package:obviously_test_final/features/payment/bloc/payment_bloc.dart';
import 'package:obviously_test_final/features/transactions/bloc/transaction_bloc.dart';
import 'package:obviously_test_final/features/transactions/view/transactions_main_view.dart';
import 'package:obviously_test_final/firebase_options.dart';
import 'package:obviously_test_final/themes/themes.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider(
          create: (context) => ConversionBloc(),
        ),
        BlocProvider(
          create: (context) => PaymentBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Obviously Money App',
        theme: Themes.mainTheme,
        home: SplashScreen.navigate(
          name: 'assets/rive/rive_logo.riv',
          next: (_) => const TransactionsMainView(),
          until: () => Future.delayed(const Duration(seconds: 1)),
          startAnimation: 'deactivated',
          endAnimation: 'activating',
          backgroundColor: Themes.mainTheme.highlightColor,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
