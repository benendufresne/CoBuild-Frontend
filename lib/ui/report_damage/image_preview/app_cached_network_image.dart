import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Commmon cached network view
class AppCacheNetworkImage extends StatelessWidget {
  const AppCacheNetworkImage({
    required this.image,
    this.type = ImageType.network,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.maxHeightDiskCache,
    this.maxWidthDiskCache,
    this.showLoadingProgress = false,
    this.placeholder,
    super.key,
  });

  final BoxFit? fit;
  final String image;
  final Color? color;
  final double? height;
  final double? width;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final bool showLoadingProgress;
  final String? placeholder;
  final ImageType type;

  @override
  Widget build(BuildContext context) {
    return image.isEmpty
        ? const SizedBox()
        : type == ImageType.file
            ? Image.file(
                File(image),
                height: height,
                width: width,
                fit: fit,
                color: color,
              )
            : type == ImageType.local
                ? Image.asset(
                    image,
                    height: height,
                    width: width,
                    fit: fit,
                    color: color,
                  )
                : type == ImageType.svgLocal
                    ? SvgPicture.asset(
                        image,
                        height: height,
                        width: width,
                        colorFilter: color == null
                            ? null
                            : ColorFilter.mode(color!, BlendMode.srcIn),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: AppColors.rejectedStatusColor),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          height: height,
                          width: width,
                          color: color,
                          fit: fit,
                          // placeholder: placeholder == null
                          //     ? null
                          //     : (_, __) {
                          //         return Image.asset(
                          //           placeholder!,
                          //           height: 100,
                          //           width: 100,
                          //           fit: BoxFit.cover,
                          //         );
                          //       },
                          // progressIndicatorBuilder: placeholder != null
                          //     ? null
                          //     : (context, url, progress) {
                          //         return showLoadingProgress
                          //             ? Center(
                          //                 child: CircularProgressIndicator(
                          //                   value: progress.progress,
                          //                   color: AppColors.primaryColor,
                          //                 ),
                          //               )
                          //             : const SizedBox.shrink();
                          //       },
                          // errorWidget: (context, url, error) {
                          //   return placeholder == null
                          //       ? const SizedBox()
                          //       : Image.asset(
                          //           placeholder!,
                          //           fit: BoxFit.cover,
                          //         );
                          // },
                          maxWidthDiskCache: maxWidthDiskCache,
                          maxHeightDiskCache: maxHeightDiskCache,
                        ),
                      );
  }
}
