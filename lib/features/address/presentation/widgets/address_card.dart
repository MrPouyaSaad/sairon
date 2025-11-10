// lib/features/address/presentation/widgets/address_card.dart
import 'package:flutter/material.dart';
import 'package:sairon/features/address/domain/entities/address.dart';

import '../../../../core/widgets/gradient.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;
  final bool isSelected;

  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: isSelected
            ? Border.all(color: const Color(0xFF7E22CE), width: 2)
            : null,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardHeader(),
                const SizedBox(height: 12),

                _buildReceiverInfo(),
                const SizedBox(height: 8),

                _buildAddressInfo(),
                const SizedBox(height: 12),

                _buildActionButtons(),
              ],
            ),
          ),

          if (address.isDefault) _buildDefaultBadge(),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return Row(
      children: [
        GradientText(
          address.title,
          gradient: GradientTheme.buttonGradient,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        if (address.isDefault)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: GradientTheme.accentGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'پیش‌فرض',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReceiverInfo() {
    return Row(
      children: [
        Icon(Icons.person_outline, color: Colors.grey[600], size: 16),
        const SizedBox(width: 6),
        Text(
          address.receiver,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.phone_iphone, color: Colors.grey[600], size: 16),
        const SizedBox(width: 6),
        Text(
          address.phoneNumber,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildAddressInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                '${address.province}، ${address.city}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            address.address,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            'کد پستی: ${address.postalCode}',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.edit_outlined,
            text: 'ویرایش',
            color: const Color(0xFF1E3A8A),
            onTap: onEdit,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionButton(
            icon: Icons.delete_outline,
            text: 'حذف',
            color: Colors.red,
            onTap: onDelete,
          ),
        ),
        const SizedBox(width: 8),
        if (!address.isDefault)
          Expanded(
            child: _buildActionButton(
              icon: Icons.star_outline,
              text: 'پیش‌فرض',
              color: Colors.amber,
              onTap: onSetDefault,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultBadge() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.star_rounded, color: Colors.white, size: 12),
      ),
    );
  }
}
