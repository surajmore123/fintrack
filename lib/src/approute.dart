import 'package:fintrack/src/screens/analytics/trend.dart';
import 'package:fintrack/src/screens/home/add_expense.dart';
import 'package:fintrack/src/screens/home/home.dart';
import 'package:fintrack/src/screens/profile/profile.dart';
import 'package:fintrack/src/screens/transaction/transactions.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/analytics':
        return MaterialPageRoute(builder: (_) => const Trend());

      case '/transactions':
        return MaterialPageRoute(builder: (_) => const TransactionsScreen());

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case '/add-expense':
        return MaterialPageRoute(builder: (_) => const AddExpenseScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
