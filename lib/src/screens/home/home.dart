import 'package:fintrack/src/components/appbar.dart';
import 'package:fintrack/src/mainlayout.dart';
import 'package:fintrack/src/model/transaction_model.dart';
import 'package:fintrack/src/repository.dart/transaction_repo.dart';
import 'package:fintrack/src/screens/home/home_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await TransactionRepository.loadTransactions();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showFloatingActionButton: true,
      fabTitle: "Add Expense",
      onFabTap: () async {
        final result = await Navigator.pushNamed(context, '/add-expense');

        if (result is TransactionModel) {
          TransactionRepository.transactions.insert(0, result);

          setState(() {});
        }
      },
      appBar: FinTrackAppBar(
        title: "FinTrack",
        onProfileTap: () {
          // Navigate to profile
        },
        onNotificationTap: () {
          // Open notifications
        },
      ),
      showDefaultBottom: true,
      ctx: 0,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : HomeBody(transactions: TransactionRepository.transactions),
    );
  }
}
