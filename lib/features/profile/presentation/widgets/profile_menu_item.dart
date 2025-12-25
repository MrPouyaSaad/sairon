import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool showArrow;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
                iconColor?.withOpacity(0.1) ?? Colors.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor ?? Colors.purple, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              )
            : null,
        trailing: showArrow
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.grey[600],
                  size: 18,
                ),
              )
            : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
