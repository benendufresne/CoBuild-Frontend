import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/ui/components/common_widgets.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/services/google_place_api.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Address textfield ,to show address in complete app
class AddressTextField extends StatefulWidget {
  final ValidatedController<StringValidation> controller;
  final LocationModel? locationModel;
  final FocusNode focusNode;
  final Function()? onTap;
  final bool isOnboarding;
  final String? hintText;
  final bool isRequired;
  final bool showSiffixIcon;
  final bool showPrefixIcon;
  final void Function()? callBack;

  const AddressTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      this.onTap,
      this.isOnboarding = false,
      required this.locationModel,
      this.hintText,
      this.isRequired = true,
      this.showSiffixIcon = false,
      this.showPrefixIcon = false,
      this.callBack});

  @override
  State<StatefulWidget> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  late final PlaceApiProvider placesProvider;
  @override
  void initState() {
    super.initState();
    placesProvider = PlaceApiProvider(const Uuid().v4());
  }

  @override
  Widget build(BuildContext context) {
    return _addressTextField(context);
  }

  Widget _addressTextField(BuildContext context) {
    return AppTextField(
      textInputAction: TextInputAction.next,
      hintText:
          "${widget.hintText ?? S.current.address}${widget.isRequired ? S.current.requiredIcon : ""}",
      focusNode: widget.focusNode,
      readOnly: true,
      suffixIcon: (widget.showSiffixIcon && widget.controller.text.isNotEmpty)
          ? IconButton(
              onPressed: () {
                widget.controller.text = "";
                widget.locationModel?.address = '';
                widget.locationModel?.coordinates = null;
                _callBackFunction();
                setState(() {});
              },
              icon: const Icon(Icons.close_rounded))
          : null,
      controller: widget.controller,
      prefixWidget: widget.showPrefixIcon
          ? Padding(
              padding: EdgeInsets.fromLTRB(12.h, 16.h, 8.h, 16.h),
              child: CommonWidgets.locationIcon(),
            )
          : null,
      onTap: () async {
        LocationModel? model =
            await context.pushNamed(AppRoutes.searchLocation);
        if (model != null) {
          // Get current location
          if ((model.placeId == null) &&
              (model.coordinates?.isNotEmpty ?? false)) {
            widget.controller.text = model.address ?? "";
            widget.locationModel?.address = model.address;
            widget.locationModel?.coordinates = model.coordinates;
            _callBackFunction();
          }
          // Getting address from manually selected location
          else if (model.placeId != null) {
            widget.controller.text = model.address ?? '';
            setState(() {});
            LocationModel? location =
                await placesProvider.getPlaceDetailFromId(model.placeId ?? '');
            if (location != null) {
              widget.locationModel?.address = model.address;
              widget.locationModel?.coordinates = location.coordinates;
              _callBackFunction();
            } else {
              showSnackBar(message: S.current.reselectLocation);
            }
          }
        }
      },
      fillColor: widget.isOnboarding ? onboardingTextFieldColor : null,
    );
  }

  void _callBackFunction() {
    if (widget.callBack != null) {
      widget.callBack!();
    }
  }
}
