import 'package:carousel_slider/carousel_slider.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/widgets/dot_builder.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';

/// Media carousal to show multiple images in report details page
class MediaCarousel extends StatefulWidget {
  final List<MediaModel> mediaList;

  const MediaCarousel({required this.mediaList, super.key});

  @override
  State<MediaCarousel> createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<MediaCarousel> {
  int currentIndex = 0; // Tracks the current page index
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 200.h,
              autoPlay: false,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              animateToClosest: false,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index; // Update currentIndex dynamically
                });
              },
            ),
            items: widget.mediaList.asMap().entries.map((entry) {
              final index = entry.key;
              final mediaModel = entry.value;
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      context.pushNamed(
                        AppRoutes.imagePreviewScreen,
                        extra: [index, widget.mediaList],
                      );
                    },
                    child: EstimateRequestMediaView(
                      model: mediaModel,
                      isDetailView: true,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          if (widget.mediaList.length > 1)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: DotBuilder(
                length: widget.mediaList.length,
                isCircle: true,
                currentIndex: currentIndex, // Pass the dynamic index here
              ),
            ),
        ],
      ),
    );
  }
}
