import 'package:fintrack/src/components/appbar.dart';
import 'package:fintrack/src/mainlayout.dart';
import 'package:fintrack/src/model/transaction_model.dart';
import 'package:fintrack/src/repository.dart/transaction_repo.dart';
import 'package:fintrack/src/screens/transaction/transaction_detail.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final transactions = TransactionRepository.transactions;

    return MainLayout(
        showFloatingActionButton: true,
      fabTitle: "Add Expense",
      appBar: FinTrackAppBar(
        title: "FinTrack",
        onProfileTap: () {
          Navigator.pop(context);
        },
      ),
      showDefaultBottom: true,
      ctx: 2,
      body: Padding(
         padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "All Transactions",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
        
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F46E5).withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${transactions.length} Records",
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
            const SizedBox(height: 10),
        
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
        
                  return TransactionTile(transaction: transaction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  IconData getCategoryIcon() {
    switch (transaction.category) {
      case "Food":
        return Icons.restaurant;

      case "Travel":
        return Icons.directions_car;

      case "Shopping":
        return Icons.shopping_bag;

      case "Entertainment":
        return Icons.movie;

      default:
        return Icons.payments;
    }
  }

  Color getCategoryColor() {
    switch (transaction.category) {
      case "Food":
        return Colors.orange;

      case "Travel":
        return Colors.blue;

      case "Shopping":
        return Colors.green;

      case "Entertainment":
        return Colors.purple;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getCategoryColor();

    return GestureDetector(
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(.15),
              child: Icon(getCategoryIcon(), color: color),
            ),
      
            const SizedBox(width: 12),
      
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
      
                  const SizedBox(height: 4),
      
                  Text(
                    transaction.category,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
      
                  const SizedBox(height: 2),
      
                  Text(
                    transaction.date.split('T').first,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${transaction.amount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
      
                const SizedBox(height: 4),
      
                if (transaction.note.isNotEmpty)
                  SizedBox(
                    width: 100,
                    child: Text(
                      transaction.note,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
