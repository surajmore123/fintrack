import 'package:fintrack/src/mainlayout.dart';
import 'package:fintrack/src/model/transaction_model.dart';
import 'package:fintrack/src/repository.dart/transaction_repo.dart';
import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showDefaultBottom: true,
      ctx: 2,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Expense Details",
         style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F46E5),
            ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _expenseHeader(),

            const SizedBox(height: 20),

            _detailCard(),

            const SizedBox(height: 20),

            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _expenseHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor:
                const Color(0xff4F46E5),
            child: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            transaction.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Text(
              transaction.category,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "- ₹${transaction.amount.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _detailRow(
            Icons.calendar_today,
            "DATE",
            transaction.date,
          ),

          const Divider(),

          _detailRow(
            Icons.category,
            "CATEGORY",
            transaction.category,
          ),

          const Divider(),

          _detailRow(
            Icons.notes,
            "NOTES",
            transaction.note.isEmpty
                ? "No notes added"
                : transaction.note,
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor:
              Colors.grey.shade100,
          child: Icon(icon),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButtons(
    BuildContext context,
  ) {
    return Column(
      children: [
        Container(
            width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF4F46E5),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit,color: Colors.white,),
            label: const Text(
              "Edit Expense",
                   style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
                 style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton.icon(
            onPressed: () {
              TransactionRepository.transactions
                  .removeWhere(
                (e) =>
                    e.id ==
                    transaction.id,
              );

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            label: const Text(
              "Delete Expense",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}