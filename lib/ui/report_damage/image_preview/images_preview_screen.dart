import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/report_damage/image_preview/app_cached_network_image.dart';
import 'package:cobuild/ui/report_damage/image_preview/custom_interactor_viewer.dart';
import 'package:cobuild/ui/widgets/dot_builder.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Show list of images in full view
class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({
    super.key,
    required this.currentIndex,
    required this.images,
  });

  final int currentIndex;
  final List<MediaModel> images;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late PageController _controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController with the initial page set to 0.
    _controller = PageController(
      initialPage: widget.currentIndex,
    );
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.gallery,
          style: AppStyles().mediumRegular,
        ),
      ),
      body: Padding(
        padding: KEdgeInsets.kOnly(b: 30.sp),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
                itemCount: widget.images.length,
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, i) {
                  return Center(
                    child: CustomInteractiveViewer(
                      scaleDuration: const Duration(milliseconds: 400),
                      child: Container(
                        height: deviceHeight * 0.8,
                        alignment: Alignment.center,
                        width: deviceWidth,
                        child: AppCacheNetworkImage(
                            type: widget.images[currentIndex].media == null ||
                                    widget.images[currentIndex].media!.isEmpty
                                ? ImageType.local
                                : ImageType.network,
                            fit: BoxFit.cover,
                            image: widget.images[currentIndex].media == null ||
                                    widget.images[currentIndex].media!.isEmpty
                                ? ''
                                : widget.images[currentIndex].media ?? ''),
                      ),
                    ),
                  );
                }),
            if (widget.images.length > 1)
              Padding(
                padding: KEdgeInsets.kOnly(b: 0.075.h),
                child: DotBuilder(
                  isCircle: true,
                  length: widget.images.length,
                  currentIndex: currentIndex,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
