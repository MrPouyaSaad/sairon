// lib/features/category/presentation/widgets/modern_category_item.dart
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 75,
                height: 75,
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
                    color: categoryEntity.imageUrl.isEmpty
                        ? null
                        : Colors.white,
                    gradient: categoryEntity.imageUrl.isEmpty
                        ? GradientTheme.cardGradient
                        : null,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: categoryEntity.imageUrl.isEmpty
                      ? Center(
                          child: Text(
                            categoryEntity.name[0],
                            style: TextStyle(fontSize: 32, color: Colors.white),
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
              const SizedBox(height: 8),

              SizedBox(
                height: 32,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    categoryEntity.name,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
