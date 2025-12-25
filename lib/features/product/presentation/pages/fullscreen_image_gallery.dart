import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sairon/core/themes/app_colors.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_constants.dart';

class FullscreenImageGallery extends StatefulWidget {
  const FullscreenImageGallery({
    super.key,
    required this.productEntity,
    required this.initialIndex,
  });

  final ProductEntity productEntity;
  final int initialIndex;

  @override
  State<FullscreenImageGallery> createState() => _FullscreenImageGalleryState();
}

class _FullscreenImageGalleryState extends State<FullscreenImageGallery> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.productEntity.images.urls;

    return Scaffold(
      backgroundColor: AppColors.textSecondary,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: images.length,
            builder: (context, index) {
              final imageUrl = images[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(imageUrl),
                heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3,
              );
            },
            onPageChanged: (index) => setState(() => _currentIndex = index),
            backgroundDecoration: const BoxDecoration(
              border: null,
              color: AppColors.textSecondary,
            ),
          ),

          Positioned(
            top: 60,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Constants.primaryRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: images.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: AppColors.surfaceColor,
                  dotColor: AppColors.backgroundColor,
                  expansionFactor: 3,
                  spacing: 6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
