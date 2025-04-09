import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/media_enum.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// Estimate Request Media View
class EstimateRequestMediaView extends StatelessWidget {
  final bool isDetailView;
  final bool isEditPage;
  final bool isChatPage;
  final MediaModel model;
  const EstimateRequestMediaView(
      {super.key,
      this.isDetailView = false,
      this.isEditPage = false,
      this.isChatPage = false,
      required this.model});

  @override
  Widget build(BuildContext context) {
    if (isEditPage) {
      return _editView();
    }
    if (isDetailView) {
      return _detailsView();
    } else if (isChatPage) {
      return _chatCardMedia();
    } else {
      return _estimateCardMedia();
    }
  }

  Widget _editView() {
    return Container(
      height: 200.h,
      width: double.infinity,
      alignment: (isPdf || isDoc) ? Alignment.center : null,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: isPdf
          ? _pdfView()
          : isDoc
              ? _docView()
              : _cachedImage(fit: BoxFit.contain, height: 200.h),
    );
  }

  Widget _detailsView() {
    return Container(
        height: isPdf ? 100.h : 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: AppColors.black.withOpacity(0.35), width: 0.25)),
        alignment: Alignment.center,
        child: isPdf
            ? _pdfView()
            : isDoc
                ? _docView()
                : _cachedImage(height: 200.h, fit: BoxFit.contain));
  }

  Widget _estimateCardMedia() {
    return Container(
        height: 100.h,
        width: 100.h,
        decoration: BoxDecoration(
            border: Border.all(width: 0.25),
            borderRadius: BorderRadius.circular(8.r)),
        alignment: (isPdf || isDoc) ? Alignment.center : null,
        child: isPdf
            ? _pdfView()
            : isDoc
                ? _docView()
                : _cachedImage(height: 100.h, width: 100.h, fit: BoxFit.cover));
  }

  Widget _chatCardMedia() {
    return Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
            border: Border.all(width: 0.25),
            borderRadius: BorderRadius.circular(20.r)),
        alignment: (isPdf || isDoc) ? Alignment.center : null,
        child: isPdf
            ? _pdfView()
            : isDoc
                ? _docView()
                : _cachedImage(height: 46.h, width: 46.h, fit: BoxFit.cover));
  }

  bool get isPdf => (getMediaType(model.mediaType) == MediaTypeEnum.pdf);

  bool get isDoc => (getMediaType(model.mediaType) == MediaTypeEnum.doc);

  Widget _cachedImage({double height = 100, double? width, BoxFit? fit}) {
    if ((model.media?.isEmpty ?? true)) {
      return const SizedBox();
    }
    if (isPdf) {
      return _pdfView();
    }
    return InkWell(
      onTap: () {
        if (isDetailView || isEditPage) {
          ctx.pushNamed(
            AppRoutes.imagePreviewScreen,
            extra: [
              0,
              [model]
            ],
          );
        }
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CachedNetworkImage(
            imageUrl: model.media ?? '',
            height: height,
            fit: fit ?? BoxFit.contain,
            width: width != null ? width.w : double.infinity,
            errorWidget: (context, url, error) => Container(
              alignment: Alignment.center,
              child: Text(S.current.errorLoadingMedia,
                  textAlign: TextAlign.center,
                  style: AppStyles().regularRegular),
            ),
          )),
    );
  }

  Widget _pdfView() {
    return InkWell(
        onTap: () {
          if (isDetailView || isEditPage) {
            ctx.pushNamed(AppRoutes.openPdf, extra: {AppKeys.url: model.media});
          }
        },
        child: ShowImage(
          image: AppImages.pdfIcon,
          height: 48.h,
          width: 48.h,
        ));
  }

  Widget _docView() {
    return InkWell(
        onTap: () {
          if (isDetailView || isEditPage) {
            launchUrl(Uri.parse(model.media ?? ''));
          }
        },
        child: ShowImage(
          image: AppImages.docIcon,
          height: 48.h,
          width: 48.h,
        ));
  }
}
