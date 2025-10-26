// lib/core/widgets/gradient_theme.dart
import 'package:flutter/material.dart';

class GradientTheme {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(200, 30, 59, 138),
      Color.fromARGB(200, 126, 34, 206),
      Color.fromARGB(200, 30, 59, 138),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF67E8F9), Color(0xFFD8B4FE)],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A8A), Color(0xFF7E22CE)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A8A), Color(0xFF7E22CE)],
  );
}

// ویجت برای ایجاد دکمه با گرادینت
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool expanded;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: GradientTheme.buttonGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7E22CE).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: expanded ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ویجت برای ایجاد کارت با گرادینت
class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const GradientCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: GradientTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7E22CE).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ویجت برای ایجاد متن با گرادینت
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const GradientText(this.text, {super.key, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          GradientTheme.accentGradient.createShader(bounds),
      child: Text(
        text,
        style:
            style?.copyWith(color: Colors.white) ??
            const TextStyle(color: Colors.white),
        textAlign: textAlign,
      ),
    );
  }
}

// ویجت برای ایجاد هدر با گرادینت (همان هدر اصلی شما)
class GradientHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const GradientHeader({super.key, this.title, this.actions, this.leading});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      leading: leading,
      actions: actions,
      title: title != null ? Text(title!) : null,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: _buildHeaderContent(statusBarHeight),
      ),
    );
  }

  Widget _buildHeaderContent(double statusBarHeight) {
    return Stack(
      children: [
        // Main gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: GradientTheme.primaryGradient,
          ),
        ),

        // Transparent black overlay
        Container(color: Colors.black.withOpacity(0.2)),

        // Main content with safe padding
        Padding(
          padding: EdgeInsets.only(top: statusBarHeight, bottom: 8),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background text (ســایـرون)
                Text(
                  'ســایـرون',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.05),
                    letterSpacing: 1.5,
                  ),
                ),

                // Gradient text (SAIRON)
                GradientText(
                  'SAIRON',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
