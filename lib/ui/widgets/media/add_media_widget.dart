import 'dart:typed_data';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/widgets/media/media_common_components.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

/// Widget used to add media
class AddMediaWidget extends StatefulWidget {
  final Function(File? file) onSelect;
  final MediaModel? preSelectedMedia;

  const AddMediaWidget(
      {super.key, required this.onSelect, this.preSelectedMedia});

  @override
  State<StatefulWidget> createState() => _AddMediaWidgetState();
}

class _AddMediaWidgetState extends State<AddMediaWidget> {
  File? selectedMedia;
  @override
  Widget build(BuildContext context) {
    if (widget.preSelectedMedia?.media?.isNotEmpty ?? false) {
      return _uploadedMediaForUpdateView();
    }
    return (selectedMedia != null)
        ? _selectedMediaView()
        : MediaCommonComponents().selectMediaWidget(() => _showUploadOptions());
  }

  void _pickFile() async {
    if (context.mounted) {
      try {
        // Open file picker
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc'],
        );

        if (result != null && result.files.isNotEmpty) {
          // Get the file
          PlatformFile file = result.files.first;
          if (file.size > maxImageSize) {
            showSnackBar(message: S.current.mediaSizeError);
            return;
          }

          // Proceed with the selected file
          final path = file.path;
          if (path != null) {
            selectedMedia = File(path);
            _updateImage();
          } else {
            showSnackBar(message: S.current.errorSelectingMedia);
          }
        }
      } catch (e) {
        showSnackBar(message: '${S.current.errorSelectingMedia}: $e');
      }
    }
  }

  void _openGallery() async {
    if (context.mounted) {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? pickedFile =
            await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final fileSize = await file.length();
          if (fileSize > maxImageSize) {
            showSnackBar(message: S.current.mediaSizeError);
            return;
          }
          selectedMedia = file;
          _updateImage();
        }
      } catch (e) {
        showSnackBar(message: '${S.current.errorSelectingMedia}: $e');
      }
    }
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

  void openCamera() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        selectedMedia = File(pickedFile.path);
        _updateImage();
      }
    } catch (e) {
      showSnackBar(message: '${S.current.errorCapturingImage}: $e');
    }
  }

  void _editMedia(File file) async {
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
      _updateImage();
    }
  }

  Future<File> overrideExistingFile(File file, Uint8List newData) async {
    try {
      await file.writeAsBytes(newData, flush: false);
      selectedMedia = File(file.path);
      return file;
    } catch (e) {
      printCustom('Error overriding file: $e');
      rethrow;
    }
  }

  Widget _uploadedMediaForUpdateView() {
    return Stack(children: [
      EstimateRequestMediaView(
          model: widget.preSelectedMedia!, isEditPage: true),
      // Edit and delete buttons
      Positioned(
        top: 8,
        right: 8,
        child: Row(
          children: [
            if (isImageFile(selectedMedia)) ...[
              MediaCommonComponents().editIcon(() {
                _editMedia(selectedMedia!);
              }),
              Gap(12.w)
            ],
            MediaCommonComponents().deleteIcon(() {
              removeSelectedFile();
            }),
          ],
        ),
      )
    ]);
  }

  Widget _selectedMediaView() {
    return MediaCommonComponents().showSelectedImage(
        selectedMedia: selectedMedia,
        context: context,
        onDelete: () => removeSelectedFile(),
        onEdit: () {
          _editMedia(selectedMedia!);
        });
  }

  void removeSelectedFile() {
    selectedMedia = null;
    _updateImage();
  }

  void _updateImage() {
    widget.onSelect(selectedMedia);
  }

  // Show upload options (gallery, files, camera)
  void _showUploadOptions() {
    showModalBottomSheet(
        context: context,
        builder: (context) => MediaCommonComponents().selectMediaOptions(
            context: context,
            openCamera: pickFromCamera,
            openFile: _pickFile,
            openGallery: _openGallery));
  }
}
