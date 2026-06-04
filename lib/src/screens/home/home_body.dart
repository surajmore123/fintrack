import 'package:fintrack/src/model/transaction_model.dart';
import 'package:fintrack/src/screens/transaction/transaction_detail.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final List<TransactionModel> transactions;
  const HomeBody({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
  
          SizedBox(height: 10),
          SpendSummaryCard(transactions: transactions),
          SizedBox(height: 10),

          CategorySection(transactions: transactions),
          SizedBox(height: 10),

          TransactionSection(transactions: transactions),
          SizedBox(height: 10),

          SavingsCard(),
          SizedBox(height: 10),

          SmartTipCard(),

          // SizedBox(height: 100),
        ],
      ),
    );
  }
}

class SpendSummaryCard extends StatelessWidget {
  final List<TransactionModel> transactions;
  const SpendSummaryCard({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    double totalSpend = transactions.fold(0, (sum, item) => sum + item.amount);
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff4F46E5), Color(0xff6D5DFE)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Spend • June 2026",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),

          const SizedBox(height: 12),

          Text(
            "₹${totalSpend.toStringAsFixed(0)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "↗ +12.5% from last month",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<TransactionModel> transactions;
  const CategorySection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    Map<String, double> categoryTotals = {};
    for (var transaction in transactions) {
      categoryTotals.update(
        transaction.category,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: const Text(
                "By Category",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(onPressed: () {}, child: const Text("View Details")),
          ],
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categoryTotals.entries.map((entry) {
              return CategoryCard(
                title: entry.key,
                amount: "₹${entry.value.toStringAsFixed(0)}",
                icon: Icons.shopping_bag,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon),
          ),

          const Spacer(),

          Text(title),

          const SizedBox(height: 8),

          Text(
            amount,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final recentTransactions = transactions.take(5).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: const Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transactions');
              },
              child: const Text("Show All"),
            ),
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentTransactions.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, index) {
            final transaction = recentTransactions[index];
            return ListTile(
              onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => TransactionDetailsScreen(
        transaction: transaction,
      ),
    ),
  );
},
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade50,
                child: const Icon(Icons.shopping_bag),
              ),

              title: Text(transaction.title),

              subtitle: Text("${transaction.category} • ${transaction.date}"),

              trailing: Text(
                "- ₹${transaction.amount}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SavingsCard extends StatelessWidget {
  const SavingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xff66E4AE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Savings",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text("Target: ₹10,000"),

          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("75% achieved"), Text("₹7,500")],
          ),

          const SizedBox(height: 15),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(value: 0.75, minHeight: 10),
          ),
        ],
      ),
    );
  }
}

class SmartTipCard extends StatelessWidget {
  const SmartTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Smart Tip",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  "You spent 20% more on food this week compared to your average.",
                ),
              ],
            ),
          ),
        ),

        // CircleAvatar(
        //   radius: 30,
        //   child: Icon(Icons.lightbulb),
        // ),
      ],
    );
  }
}
