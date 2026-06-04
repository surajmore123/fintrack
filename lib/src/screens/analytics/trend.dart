import 'package:fintrack/src/components/appbar.dart';
import 'package:fintrack/src/mainlayout.dart';
import 'package:fintrack/src/model/transaction_model.dart';
import 'package:fintrack/src/repository.dart/transaction_repo.dart';
import 'package:flutter/material.dart';

class Trend extends StatelessWidget {
  const Trend({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = TransactionRepository.transactions;

    return MainLayout(
      showFloatingActionButton: true,
      fabTitle: "Add Expense",
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
      ctx: 1,
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            AnalyticsSummaryCards(transactions: transactions),

            const SizedBox(height: 10),

            CategoryDistributionCard(transactions: transactions),
          ],
        ),
      ),
    );
  }
}

class AnalyticsSummaryCards extends StatelessWidget {
  final List<TransactionModel> transactions;

  const AnalyticsSummaryCards({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    double totalSpend = transactions.fold(0, (sum, item) => sum + item.amount);

    String topCategory = getTopCategory();

    return Column(
      children: [
        AnalyticsCard(
          title: "Total Spending",
          value: "₹${totalSpend.toStringAsFixed(0)}",
          icon: Icons.account_balance_wallet,
        ),

        const SizedBox(height: 10),

        AnalyticsCard(
          title: "Transactions",
          value: "${transactions.length}",
          icon: Icons.receipt_long,
        ),

        const SizedBox(height: 10),

        AnalyticsCard(
          title: "Top Category",
          value: topCategory,
          icon: Icons.category,
        ),
      ],
    );
  }

  String getTopCategory() {
    Map<String, double> totals = {};

    for (var transaction in transactions) {
      totals.update(
        transaction.category,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    if (totals.isEmpty) {
      return "N/A";
    }

    return totals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xff4F46E5).withOpacity(.1),
            child: Icon(icon, color: const Color(0xff4F46E5)),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[600])),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryDistributionCard extends StatelessWidget {
  final List<TransactionModel> transactions;

  const CategoryDistributionCard({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    Map<String, double> totals = {};

    for (var transaction in transactions) {
      totals.update(
        transaction.category,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    double totalAmount = totals.values.fold(0, (a, b) => a + b);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category Distribution",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          ...totals.entries.map((entry) {
            double percentage = entry.value / totalAmount;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text("${(percentage * 100).toStringAsFixed(0)}%"),
                    ],
                  ),

                  const SizedBox(height: 8),

                  LinearProgressIndicator(
                    value: percentage,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
