// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sairon/features/slider/domain/entities/slider_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/widgets/image_loading.dart';

class BannerSlider extends StatelessWidget {
  final PageController _controller = PageController();
  final List<SliderEntity> banners;

  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) => _Slide(banner: banners[index]),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                onDotClicked: (index) {
                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.ease,
                  );
                },
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                  spacing: 4.0,
                  radius: 4.0,
                  dotWidth: 20.0,
                  dotHeight: 2.0,
                  paintStyle: PaintingStyle.fill,
                  dotColor: Colors.grey.shade400,
                  activeDotColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final SliderEntity banner;

  const _Slide({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ImageLoadingService(
        imageUrl: banner.imageUrl,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
