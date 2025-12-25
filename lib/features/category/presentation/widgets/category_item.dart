import 'package:flutter/material.dart';
import 'package:sairon/core/themes/text_styles.dart';
import 'package:sairon/core/widgets/gradient.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/category/domain/entities/category_entity.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryEntity, this.onTap});

  final CategoryEntity categoryEntity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Container
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: categoryEntity.imageUrl.isEmpty ? null : Colors.white,
                  gradient: categoryEntity.imageUrl.isEmpty
                      ? GradientTheme.cardGradient
                      : null,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: categoryEntity.imageUrl.isEmpty
                    ? Center(
                        child: Text(
                          categoryEntity.name[0],
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: ImageLoadingService(
                          imageUrl: categoryEntity.imageUrl,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 6),

            Container(
              width: 70,
              height: 32, //
              alignment: Alignment.center,
              child: Text(
                categoryEntity.name,
                style: AppTextStyles.caption.copyWith(
                  fontSize: _calculateFontSize(categoryEntity.name),
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateFontSize(String text) {
    if (text.length <= 8) return 12;
    if (text.length <= 12) return 11;
    if (text.length <= 16) return 10;
    return 9;
  }
}
