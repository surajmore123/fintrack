import 'package:fintrack/src/components/appbar.dart';
import 'package:fintrack/src/mainlayout.dart';
import 'package:fintrack/src/repository.dart/transaction_repo.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MainLayout(
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
      ctx: 3,
       body: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        TransactionRepository.transactions;

    final totalSpend = transactions.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ProfileHeader(),

          const SizedBox(height: 20),

          StatsCard(
            totalTransactions:
                transactions.length,
            totalSpend: totalSpend,
          ),

          const SizedBox(height: 20),

          SettingsSection(),

          const SizedBox(height: 20),

          LogoutButton(),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor:
                Color(0xFFE8E4FF),
            child: Icon(
              Icons.person,
              size: 50,
              color: Color(0xFF4F46E5),
            ),
          ),

          SizedBox(height: 12),

          Text(
            "Suraj",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 4),

          Text(
            "Flutter Developer",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final int totalTransactions;
  final double totalSpend;

  const StatsCard({
    super.key,
    required this.totalTransactions,
    required this.totalSpend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  totalTransactions.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const Text(
                  "Transactions",
                ),
              ],
            ),
          ),

          Container(
            width: 1,
            height: 50,
            color: Colors.grey.shade300,
          ),

          Expanded(
            child: Column(
              children: [
                Text(
                  "₹${totalSpend.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const Text(
                  "Total Spend",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: const [
          ProfileMenuTile(
            icon: Icons.info_outline,
            title: "About App",
          ),

          Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
          ),

          Divider(height: 1),

          ProfileMenuTile(
            icon: Icons.help_outline,
            title: "Help & Support",
          ),
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF4F46E5),
      ),
      title: Text(title),
      trailing:
          const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        label: const Text(
          "Logout",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}