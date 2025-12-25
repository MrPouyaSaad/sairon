import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({super.key, required this.description});

  final String description;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;
    const collapsedLines = 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: widget.description, style: textStyle);
        final tp = TextPainter(
          text: textSpan,
          textDirection: TextDirection.rtl,
          maxLines: collapsedLines,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = tp.didExceedMaxLines;

        return GestureDetector(
          onTap: isOverflowing ? _toggleExpand : null,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: textStyle,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  maxLines: _isExpanded ? null : collapsedLines,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
                if (isOverflowing)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _isExpanded ? 'کمتر' : 'بیشتر',
                      style: textStyle.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
  }
}
