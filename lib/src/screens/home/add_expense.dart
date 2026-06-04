import 'package:fintrack/src/components/appbar.dart';
import 'package:fintrack/src/mainlayout.dart';
import 'package:fintrack/src/model/transaction_model.dart';
import 'package:fintrack/src/repository.dart/transaction_repo.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
void saveExpense() {
  if (titleController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter title"),
      ),
    );
    return;
  }

  if (amountController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter amount"),
      ),
    );
    return;
  }

  final transaction = TransactionModel(
    id: DateTime.now()
        .millisecondsSinceEpoch
        .toString(),

    title: titleController.text.trim(),

    category: selectedCategory ?? "Others",

    amount:
        double.tryParse(amountController.text) ??
            0,

    date:
        selectedDate.toIso8601String(),

    note: noteController.text.trim(),
  );

  TransactionRepository.transactions.insert(
    0,
    transaction,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        "Expense saved successfully",
      ),
    ),
  );

  Navigator.pop(
  context,
  transaction,
);
}
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      // ctx: 2,
      showDefaultBottom: true,
      appBar: FinTrackAppBar(
        title: "FinTrack",
        onProfileTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            ExpenseFormCard(
              onSave: saveExpense,
              titleController: titleController,
              amountController: amountController,
              noteController: noteController,
              selectedCategory: selectedCategory,
              selectedDate: selectedDate,
              onCategoryChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            const SizedBox(height: 20),

            const SecurityCard(),
          ],
        ),
      ),
    );
  }
}

class ExpenseFormCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final String? selectedCategory;
  final DateTime selectedDate;
final TextEditingController noteController;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onSave;

  const ExpenseFormCard({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.selectedCategory,
    required this.selectedDate,
    required this.onCategoryChanged,
    required this.onDateChanged,
    required this.noteController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        Text(
          "Track your spending with precision.",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
        ),

        const SizedBox(height: 10),

        const Text("Expense Title"),

        const SizedBox(height: 8),

        ExpenseTextField(
          controller: titleController,
          hintText: "e.g., Weekly Groceries",
        ),

        const SizedBox(height: 10),

        const Text("Amount"),

        const SizedBox(height: 8),

        ExpenseTextField(
          controller: amountController,
          hintText: "₹0.00",
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 10),

        const Text("Category"),

        const SizedBox(height: 8),

        CategoryDropdown(value: selectedCategory, onChanged: onCategoryChanged),

        const SizedBox(height: 10),

        const Text("Date"),

        const SizedBox(height: 8),

        DatePickerField(
          selectedDate: selectedDate,
          onDateChanged: onDateChanged,
        ),

        const SizedBox(height: 10),

        const Text("Notes (Optional)"),

        const SizedBox(height: 8),

        TextField(
            controller: noteController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Add more details...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),

        const SizedBox(height: 20),

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
          onPressed: onSave,
            icon: const Icon(Icons.save_outlined, color: Colors.white),
            label: const Text(
              "Save Expense",
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
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: const Color(0xFF4F46E5)),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpenseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  const ExpenseTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      hint: const Text("Select a category"),
      items: const [
        DropdownMenuItem(value: "Food", child: Text("Food")),
        DropdownMenuItem(value: "Travel", child: Text("Travel")),
        DropdownMenuItem(value: "Shopping", child: Text("Shopping")),
      ],
      onChanged: onChanged,
    );
  }
}

class DatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: selectedDate,
    );

    if (date != null) {
      onDateChanged(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              ),
            ),
            const Icon(Icons.calendar_today_outlined),
          ],
        ),
      ),
    );
  }
}

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff66E4AE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.shield_outlined),
          ),

          const SizedBox(width: 15),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SECURITY",
                style: TextStyle(fontSize: 12, letterSpacing: 1),
              ),
              SizedBox(height: 5),
              Text(
                "Encrypted Transaction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
