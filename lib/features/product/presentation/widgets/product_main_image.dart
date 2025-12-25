import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sairon/core/constants/app_constants.dart';
import 'package:sairon/core/widgets/image_loading.dart';
import 'package:sairon/features/product/domain/entities/product_entity.dart';
import 'package:sairon/features/product/presentation/pages/fullscreen_image_gallery.dart';

class ProductMainImage extends StatefulWidget {
  const ProductMainImage({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<ProductMainImage> createState() => _ProductMainImageState();
}

class _ProductMainImageState extends State<ProductMainImage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  List<String> get _images => widget.productEntity.images.urls.isNotEmpty
      ? widget.productEntity.images.urls
      : [widget.productEntity.image];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onThumbTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = _images;
    final mainHeight = MediaQuery.of(context).size.width * 0.85;

    return Column(
      children: [
        // ---------- Main PageView ----------
        SizedBox(
          height: mainHeight,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final imageUrl = images[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    FullscreenImageGallery(
                      productEntity: widget.productEntity,
                      initialIndex: index,
                    ),
                  );
                },
                child: Hero(
                  tag: imageUrl,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: Constants.primaryRadius,
                      child: ImageLoadingService(imageUrl: imageUrl),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const Gap(12),

        // ---------- Thumbnails ----------
        SizedBox(
          height: kToolbarHeight * 1.2,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              final url = images[index];
              final selected = index == _currentIndex;
              return GestureDetector(
                onTap: () => _onThumbTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.all(selected ? 2 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: selected ? 2 : 0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  width: kToolbarHeight * 1.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageLoadingService(imageUrl: url),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
