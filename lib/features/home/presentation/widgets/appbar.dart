// lib/features/home/presentation/widgets/gradient_header.dart
import 'package:flutter/material.dart';

class GradientHeader extends StatelessWidget implements PreferredSizeWidget {
  const GradientHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60); // Reduced from 70 to 60

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: preferredSize.height, // Use the reduced height
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
        child: _buildHeaderContent(context, statusBarHeight),
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context, double statusBarHeight) {
    return Stack(
      children: [
        // Main gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E3A8A), Color(0xFF7E22CE), Color(0xFF1E3A8A)],
            ),
          ),
        ),

        // Transparent black overlay
        Container(color: Colors.black.withOpacity(0.2)),

        // Main content with safe padding
        Padding(
          padding: EdgeInsets.only(
            top: statusBarHeight,
            bottom: 8, // Add some bottom padding
          ),
          child: _buildCenterText(),
        ),

        // Animated circles
        _buildAnimatedCircles(statusBarHeight),
      ],
    );
  }

  Widget _buildCenterText() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background text (ســایـرون) - hidden on small screens
          _ResponsiveBackgroundText(),

          // Main gradient text (SAIRON)
          Text(
            'SAIRON',
            style: TextStyle(
              fontSize: 24, // Slightly reduced for smaller height
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [Color(0xFF67E8F9), Color(0xFFD8B4FE)],
                ).createShader(Rect.fromLTWH(0, 0, 100, 0)),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCircles(double statusBarHeight) {
    return Stack(
      children: [
        // Cyan circle top-left - positioned safely below status bar
        Positioned(
          top: statusBarHeight - 6,
          left: -6,
          child: _AnimatedCircle(
            size: 20, // Slightly smaller
            color: Color(0xFF67E8F9).withOpacity(0.2),
            blurRadius: 8,
            delay: Duration.zero,
          ),
        ),

        // Purple circle bottom-right
        Positioned(
          bottom: -8,
          right: -8,
          child: _AnimatedCircle(
            size: 22, // Slightly smaller
            color: Color(0xFFD8B4FE).withOpacity(0.2),
            blurRadius: 8,
            delay: Duration(milliseconds: 1000),
          ),
        ),

        // White circle center-left - positioned safely
        Positioned(
          top: statusBarHeight + 8,
          left: 30,
          child: _AnimatedCircle(
            size: 14, // Slightly smaller
            color: Colors.white.withOpacity(0.1),
            blurRadius: 5,
            delay: Duration(milliseconds: 500),
          ),
        ),

        // Cyan circle bottom-right - positioned safely
        Positioned(
          bottom: 6,
          right: 30,
          child: _AnimatedCircle(
            size: 10, // Slightly smaller
            color: Color(0xFF67E8F9).withOpacity(0.1),
            blurRadius: 3,
            delay: Duration(milliseconds: 1500),
          ),
        ),
      ],
    );
  }
}

class _ResponsiveBackgroundText extends StatelessWidget {
  const _ResponsiveBackgroundText();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 300) {
          return const SizedBox.shrink(); // Hide on very small screens
        }
        return Text(
          'ســایـرون',
          style: TextStyle(
            fontSize: 38, // Reduced for smaller header
            fontWeight: FontWeight.w900,
            color: Colors.white.withOpacity(0.05),
            letterSpacing: 1.5,
          ),
        );
      },
    );
  }
}

class _AnimatedCircle extends StatefulWidget {
  final double size;
  final Color color;
  final double blurRadius;
  final Duration delay;

  const _AnimatedCircle({
    required this.size,
    required this.color,
    required this.blurRadius,
    required this.delay,
  });

  @override
  State<_AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<_AnimatedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 0.5 + _controller.value * 0.5,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.color,
                  blurRadius: widget.blurRadius,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
