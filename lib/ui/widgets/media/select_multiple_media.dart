import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/media/media_common_components.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// Widget used to add multiple media
class AddMultipleMediaWidget extends StatefulWidget {
  final Function(List<File>? file) onSelect;

  const AddMultipleMediaWidget({super.key, required this.onSelect});

  @override
  State<StatefulWidget> createState() => _AddMediaWidgetState();
}

class _AddMediaWidgetState extends State<AddMultipleMediaWidget> {
  List<File>? selectedMedia = [];
  @override
  Widget build(BuildContext context) {
    return (selectedMedia?.isNotEmpty ?? false)
        ? _showSelectedMedia()
        : MediaCommonComponents().selectMediaWidget(() => _showUploadOptions());
  }

  // Handle file selection from the camera
  Future<void> pickFromCamera() async {
    Permission permission =
        Platform.isAndroid ? Permission.camera : Permission.photos;
    PermissionStatus status = await permission.status;
    // If status is already permanently denied, show dialog
    if (status.isPermanentlyDenied) {
      MediaCommonComponents().openAppSettingsDialog();
      return;
    }
    // Request permission
    PermissionStatus newStatus = await permission.request();
    if (newStatus.isGranted) {
      openCamera();
    }
  }

  void _openGallery() async {
    bool anyLargeMedia = false;
    if (context.mounted) {
      try {
        final ImagePicker picker = ImagePicker();
        final List<XFile> pickedFiles = await picker.pickMultiImage();

        for (XFile pickedFile in pickedFiles) {
          if ((selectedMedia?.length ?? 0) >= 5) {
            showSnackBar(message: S.current.maxImageLimit);
            _updateImage();
            return;
          }
          if (selectedMedia?.any((e) => e.path == pickedFile.path) ?? false) {
            continue;
          } else {
            final file = File(pickedFile.path);
            final fileSize = await file.length();
            if (fileSize > maxImageSize) {
              anyLargeMedia = true;
            } else {
              selectedMedia?.add(File(pickedFile.path));
            }
          }
        }
        if (anyLargeMedia) {
          showSnackBar(message: S.current.mediaSizeError);
        }
        _updateImage();
      } catch (e) {
        showSnackBar(message: '${S.current.errorSelectingMedia}: $e');
      }
    }
  }

  void openCamera() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        selectedMedia?.add(File(pickedFile.path));
        _updateImage();
      }
    } catch (e) {
      showSnackBar(message: '${S.current.errorCapturingImage}: $e');
    }
  }

  Widget _showSelectedMedia() {
    return Column(
      children: [
        ...selectedMedia
                ?.map((media) => MediaCommonComponents().showSelectedImage(
                      selectedMedia: media,
                      context: context,
                      onDelete: () => _removeSelectedMedia(media),
                      onEdit: () {
                        MediaCommonComponents().editMedia(
                            file: media,
                            onUpdate: () => _updateImage(),
                            context: context);
                      },
                    ))
                .toList() ??
            [],
        if (isImageSelected && ((selectedMedia?.length ?? 0) < 5))
          MediaCommonComponents()
              .addMoreOption(onTap: () => _showUploadOptions())
      ],
    );
  }

  bool get isImageSelected => selectedMedia?.isNotEmpty ?? false;

  void _updateImage() {
    widget.onSelect(selectedMedia);
  }

  void _removeSelectedMedia(File media) {
    selectedMedia?.remove(media);
    _updateImage();
  }

  // Show upload options (gallery, camera)
  void _showUploadOptions() {
    showModalBottomSheet(
        context: context,
        builder: (context) => MediaCommonComponents().selectMediaOptions(
            context: context,
            openCamera: pickFromCamera,
            openGallery: _openGallery));
  }
}
