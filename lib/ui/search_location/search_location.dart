import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/ui/components/common_widgets.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/search_location/location_suggestion_tile.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:cobuild/utils/permission_handling/location_permission_handling.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/services/google_place_api.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';

/// Search location screen
class SearchLocationScreen extends StatefulWidget {
  final LocationModel? model;
  const SearchLocationScreen({super.key, this.model});

  @override
  State<StatefulWidget> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final _debouncer = DeBouncer(milliseconds: 800);
  late final PlaceApiProvider placesProvider;
  List<LocationModel> suggestion = [];
  ValidatedController controller = ValidatedController.notEmpty(
    validation: Validation.string.addrress(),
  );
  FocusNode focusNode = FocusNode();
  bool isSearching = false;
  bool noLocationFind = false;

  @override
  void initState() {
    super.initState();
    placesProvider = PlaceApiProvider(const Uuid().v4());
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
      title: S.current.searchLocation,
      child: Column(
        children: [
          // Select current location
          InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () async {
              setState(() {
                isSearching = true;
              });
              LocationModel? location =
                  await LocationPermissionHandler().getCurrentLocation(context);
              setState(() {
                isSearching = false;
              });
              if (location != null && context.mounted) {
                context.pop(location);
              }
            },
            child: Row(
              children: [
                Header2(heading: S.current.selectCurrentLocation, fontSize: 16),
                Gap(8.w),
                const Icon(Icons.location_on_rounded),
              ],
            ),
          ),
          Gap(fieldGap),
          // Select Location manually
          _searchField(),
          Gap(fieldGap),
          _suggestionList()
        ],
      ),
    );
  }

  Widget _searchField() {
    return AppTextField(
      autoFocus: true,
      onChange: (value) async {
        _debouncer.run(() async {
          if (value.trim().isNotEmpty) {
            callSearchApi(value);
          }
        });
      },
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      maxLength: AppConstant.addressMaxLength,
      hintText: S.current.location,
      controller: controller,
      keyboardType: TextInputType.name,
      prefixWidget: Padding(
        padding: EdgeInsets.fromLTRB(12.h, 16.h, 8.h, 16.h),
        child: CommonWidgets.searchIcon(),
      ),
    );
  }

  Widget _suggestionList() {
    if (isSearching) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.1),
        child: const CommonLoader(),
      );
    } else if (suggestion.isEmpty && noLocationFind) {
      return Padding(
          padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.1),
          child: Title1(title: S.current.noLocationFound));
    } else {
      return ListView.separated(
          shrinkWrap: true,
          itemCount: suggestion.length,
          separatorBuilder: (context, index) {
            if (isEmptyData(suggestion[index])) {
              return const SizedBox();
            }
            return SizedBox(height: fieldGap / 2);
          },
          itemBuilder: (context, index) {
            if (isEmptyData(suggestion[index])) {
              return const SizedBox();
            }
            return InkWell(
                onTap: () async {
                  context.pop(suggestion[index]);
                },
                child: LocationSuggestionTile(model: suggestion[index]));
          });
    }
  }

  bool isEmptyData(LocationModel? suggestion) {
    return (suggestion?.address?.isEmpty ?? true);
  }

  void callSearchApi(String value) async {
    noLocationFind = false;
    setState(() {
      isSearching = true;
    });
    suggestion =
        (await placesProvider.fetchSuggestions(value)) ?? <LocationModel>[];
    if (suggestion.isEmpty) {
      noLocationFind = true;
    }
    setState(() {
      isSearching = false;
    });
  }

  void clearSuggestionList() {
    suggestion.clear();
  }
}
