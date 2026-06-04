import 'package:flutter/material.dart';

class FinTrackAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const FinTrackAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E4FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: Color(0xFF4F46E5),
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4F46E5),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black87,
            size: 25,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}