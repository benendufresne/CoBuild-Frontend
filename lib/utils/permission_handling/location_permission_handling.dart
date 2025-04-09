import 'dart:io';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';

/// Location permission handler
class LocationPermissionHandler {
  Future<LocationModel?> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    PermissionStatus permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      openSettingWhileLocationServiceIsDisable();
      return null;
    }

    permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      PermissionStatus locationPermission = await Permission.location.request();
      if (locationPermission == PermissionStatus.denied ||
          locationPermission == PermissionStatus.permanentlyDenied) {
        return null;
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      if (context.mounted) {
        _showSettingsPopup(context);
        return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    // Convert coordinates to address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks.first;
    String address =
        "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    return LocationModel(coordinates: [
      position.longitude,
      position.latitude,
    ], address: address);
  }

  void _showSettingsPopup(BuildContext context) {
    DialogBox().commonDialog(
        title: 'Permission Required',
        subtitle:
            'Location permission is permanently denied. Please go to settings to enable it.',
        positiveText: 'Settings',
        negativeText: 'Cancel',
        onTapPositive: () async {
          Navigator.of(context).pop();
          openAppSettings();
        },
        onTapNegative: () {
          Navigator.of(context).pop();
        });
  }

  void openSettingWhileLocationServiceIsDisable() async {
    if (Platform.isIOS) {
      DialogBox().commonDialog(
        title: S.current.location,
        subtitle: S.current.enableLocationServiceManually,
        positiveText: S.current.okay,
      );
    } else {
      DialogBox().commonDialog(
          title: S.current.location,
          subtitle: S.current.locationServiceRequiredDescription,
          positiveText: S.current.enable,
          negativeText: S.current.cancel,
          onTapPositive: () {
            ctx.pop();
            Geolocator.openLocationSettings();
          });
    }
  }
}
