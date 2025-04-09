import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Location suggestion tile
class LocationSuggestionTile extends StatelessWidget {
  final LocationModel model;

  const LocationSuggestionTile({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ListTile(
            title: Title1(
              title: model.address ?? '',
              fontSize: 14,
              align: TextAlign.start,
            ),
            leading: const Icon(
              Icons.location_on,
            )));
  }
}
