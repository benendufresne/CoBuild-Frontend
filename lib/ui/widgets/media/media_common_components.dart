import 'dart:io';
import 'dart:typed_data';

import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:permission_handler/permission_handler.dart';

/// Media common components :- used in report details page and estimate request page
class MediaCommonComponents {
  Widget editIcon(Function onTap) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.black.withOpacity(0.15)),
          child: const ShowImage(
              image: AppImages.editIcon, color: AppColors.white),
        ));
  }

  Widget deleteIcon(Function onTap) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.black.withOpacity(0.15)),
          child: const ShowImage(
              image: AppImages.deleteIcon, color: AppColors.white),
        ));
  }

  Widget selectMediaOptions(
      {required BuildContext context,
      required Function openCamera,
      required Function openGallery,
      Function? openFile}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Header2(heading: S.current.selectOption, fontSize: 18),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(S.current.uploadFromGallery),
              onTap: () {
                Navigator.pop(context);
                openGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(S.current.captureFromCamera),
              onTap: () {
                Navigator.pop(context);
                openCamera();
              },
            ),
            if (openFile != null)
              ListTile(
                leading: const Icon(Icons.file_present),
                title: Text(S.current.uploadFromFiles),
                onTap: () {
                  Navigator.pop(context);
                  openFile();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget showSelectedImage(
      {File? selectedMedia,
      required BuildContext context,
      required Function onEdit,
      required Function onDelete}) {
    return Stack(
      children: [
        isImageFile(selectedMedia)
            ? image(selectedMedia: selectedMedia)
            : showSelectedDocument(
                context: context, selectedMedia: selectedMedia),
        // Edit and delete buttons
        _deleteAndEditIcon(
            selectedMedia: selectedMedia, onDelete: onDelete, onEdit: onEdit)
      ],
    );
  }

  Widget image({File? selectedMedia}) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Image.memory(selectedMedia!.readAsBytesSync()),
    );
  }

  Widget showSelectedDocument(
      {required BuildContext context, required File? selectedMedia}) {
    return InkWell(
      onTap: () {
        if (selectedMedia.path.contains('.pdf')) {
          context.pushNamed(AppRoutes.openPdf,
              extra: {AppKeys.path: selectedMedia.path});
        }
      },
      child: Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            '${S.current.selectedFile}: ${selectedMedia!.path.split('/').last}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _deleteAndEditIcon(
      {required File? selectedMedia,
      required Function onEdit,
      required Function onDelete}) {
    return Positioned(
      top: 8,
      right: 8,
      child: Row(
        children: [
          if (isImageFile(selectedMedia)) ...[
            MediaCommonComponents().editIcon(onEdit),
            Gap(12.w)
          ],
          MediaCommonComponents().deleteIcon(() => onDelete()),
        ],
      ),
    );
  }

  Widget selectMediaWidget(Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: KEdgeInsets.k(v: 14.h, h: 18.w),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColors.grayBorder)),
        child: Column(
          children: [
            const ShowImage(image: AppImages.browseIcon),
            Gap(10.h),
            Title1(title: S.current.selectMediaDescription),
            Gap(10.h),
            Container(
              height: 32.h,
              width: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4.r)),
              child: Icon(Icons.add, color: AppColors.white, size: 22.h),
            ),
          ],
        ),
      ),
    );
  }

  Widget addMoreOption({required Function onTap}) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        highlightColor: AppColors.transparent,
        onPressed: () {
          onTap();
        },
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: AppColors.primaryColor, size: 20.h),
            Text(S.current.addMore,
                style: AppStyles().regularBold.colored(AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }

  void editMedia(
      {required File file,
      required BuildContext context,
      required Function onUpdate}) async {
    var editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          savePath: file.path,
          image: file.readAsBytesSync(),
          cropOption: const CropOption(
            reversible: false,
          ),
        ),
      ),
    );
    // replace with edited image
    if (editedImage != null) {
      await overrideExistingFile(file, editedImage);
      onUpdate();
    }
  }

  Future<void> overrideExistingFile(File file, Uint8List newData) async {
    try {
      await file.writeAsBytes(newData, flush: false);
    } catch (e) {
      printCustom('Error overriding file: $e');
      rethrow;
    }
  }

  void openAppSettingsDialog() {
    DialogBox().commonDialog(
        title: S.current.permissionNeeded,
        subtitle: S.current.cameraPermission,
        positiveText: S.current.openSettings,
        negativeText: S.current.cancel,
        onTapPositive: () {
          openAppSettings();
          ctx.pop();
        },
        onTapNegative: () {
          ctx.pop();
        });
  }
}
