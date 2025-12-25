import 'package:flutter/material.dart';

class SuperAnimatedBadge extends StatefulWidget {
  final Widget child;
  final int? value;
  final Color badgeColor;
  final Color textColor;
  final double badgeSize;
  final Duration animationDuration;
  final bool showBadge;

  const SuperAnimatedBadge({
    super.key,
    required this.child,
    this.value,
    this.badgeColor = Colors.blue,
    this.textColor = Colors.white,
    this.badgeSize = 16.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showBadge = true,
  });

  @override
  State<SuperAnimatedBadge> createState() => _SuperAnimatedBadgeState();
}

class _SuperAnimatedBadgeState extends State<SuperAnimatedBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  int? _previousValue;
  bool _shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _previousValue = widget.value;
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 50.0,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(SuperAnimatedBadge oldWidget) {
    super.didUpdateWidget(oldWidget);

    final valueIncreased =
        widget.value != null &&
        _previousValue != null &&
        widget.value! > _previousValue!;

    if (valueIncreased && widget.showBadge) {
      _shouldAnimate = true;
      _controller.reset();
      _controller.forward().then((_) {
        if (mounted) {
          setState(() => _shouldAnimate = false);
        }
      });
    }

    _previousValue = widget.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValidBadge =>
      widget.showBadge && widget.value != null && widget.value! > 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.badgeSize * 2,
      height: widget.badgeSize * 2,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [widget.child, if (_isValidBadge) _buildAnimatedBadge()],
      ),
    );
  }

  Widget _buildAnimatedBadge() {
    return Positioned(
      right: -widget.badgeSize / 4,
      top: -widget.badgeSize / 4,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: _BadgeContent(
            value: widget.value!,
            badgeColor: widget.badgeColor,
            textColor: widget.textColor,
            badgeSize: widget.badgeSize,
            isAnimating: _shouldAnimate,
          ),
        ),
      ),
    );
  }
}

class _BadgeContent extends StatelessWidget {
  final int value;
  final Color badgeColor;
  final Color textColor;
  final double badgeSize;
  final bool isAnimating;

  const _BadgeContent({
    required this.value,
    required this.badgeColor,
    required this.textColor,
    required this.badgeSize,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        boxShadow: isAnimating
            ? [
                BoxShadow(
                  color: badgeColor.withOpacity(0.7),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          _formatValue(value),
          style: TextStyle(
            color: textColor,
            fontSize: badgeSize * 0.55,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _formatValue(int value) {
    if (value > 99) return '99+';
    return value.toString();
  }
}
