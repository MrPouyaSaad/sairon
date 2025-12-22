import 'package:flutter/material.dart';
import 'package:sairon/features/address/domain/entities/address.dart';
import '../../../../core/widgets/gradient.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;
  final bool isSelected;
  final bool isLoading;
  final bool isCheckout;

  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
    this.isSelected = false,
    this.isLoading = false,
    this.isCheckout = false,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.12),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
              border: isSelected
                  ? Border.all(color: const Color(0xFF7E22CE), width: 2)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildReceiverInfo(),
                  const SizedBox(height: 10),
                  _buildAddressInfo(),
                  if (!isCheckout) ...[
                    const SizedBox(height: 16),
                    _buildActions(context),
                  ],
                ],
              ),
            ),
          ),

          if (address.isDefault) _buildDefaultIcon(),

          if (isLoading) _buildLoading(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GradientText(
          address.title,
          gradient: GradientTheme.buttonGradient,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
              "پیش‌فرض",
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
        Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
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
        Icon(Icons.phone_iphone, size: 16, color: Colors.grey[600]),
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
            Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                "${address.province}، ${address.city}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Colors.grey[600],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            "کد پستی: ${address.postalCode}",
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: Icons.edit_outlined,
            text: "ویرایش",
            color: const Color(0xFF1E3A8A),
            onTap: onEdit,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _actionButton(
            icon: Icons.delete_outline,
            text: "حذف",
            color: Colors.red,
            onTap: onDelete,
          ),
        ),
        const SizedBox(width: 8),
        if (!address.isDefault)
          Expanded(
            child: _actionButton(
              icon: Icons.star_outline,
              text: "پیش‌فرض",
              color: Colors.amber[800]!,
              onTap: onSetDefault,
            ),
          ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultIcon() {
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

  Widget _buildLoading() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(strokeWidth: 2.4),
          ),
        ),
      ),
    );
  }
}
