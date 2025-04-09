import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_event.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_state.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_controller.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/ui/components/chat_icon.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/home_page/job_search_and_filter_widget.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/services/google_place_api.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Home page header to show :- name,locationa and chat option
class HomePageHeader extends StatefulWidget {
  const HomePageHeader({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  late final PlaceApiProvider placesProvider;
  late JobListingController jobController;
  @override
  void initState() {
    super.initState();
    placesProvider = PlaceApiProvider(const Uuid().v4());
    jobController = context.read<JobListingController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: KEdgeInsets.kOnly(b: 20.h, l: 20.h, r: 20.h, t: 18.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _nameAndLocation(),
            Gap(majorGapVertical),
            const JobSearchAndFilterWidget()
          ],
        ),
      ),
    );
  }

  Widget _nameAndLocation() {
    return BlocBuilderNew<UserProfileController, UserProfileState>(
        defaultView: (blocState) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Row(
                        children: [
                          Text(
                            "${S.current.hi},${AppPreferences.name}",
                            style: AppStyles()
                                .regularBold
                                .colored(AppColors.white.withOpacity(0.9)),
                          ),
                          Gap(6.w),
                          ShowImage(
                            image: AppImages.smile,
                            height: 16.h,
                            width: 16.h,
                          )
                        ],
                      ),
                      Gap(6.h),
                      // Address
                      _address(),
                    ],
                  ),
                ),
                Gap(10.w),
                const ChatIcon(isHomePage: true),
              ],
            ));
  }

  Widget _address() {
    return BlocBuilderNew<JobListingController, JobListingState>(
        defaultView: (blocState) => InkWell(
              onTap: () async {
                LocationModel? model =
                    await ctx.pushNamed(AppRoutes.searchLocation);
                if (model != null) {
                  if (model.placeId?.isNotEmpty ?? false) {
                    LocationModel? locationModel = await placesProvider
                        .getPlaceDetailFromId(model.placeId ?? '');
                    if (locationModel != null) {
                      model = locationModel;
                    }
                  }
                  if ((model.address?.isNotEmpty ?? false) &&
                      (model.coordinates?.isNotEmpty ?? false)) {
                    jobController.add(UpdateJobLocationEvent(model: model));
                  }
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowImage(
                      image: AppImages.locationIconOrange,
                      height: 24,
                      width: 14.w),
                  Gap(6.w),
                  Flexible(
                    flex: 5,
                    child: Text(
                        AppPreferences.jobsAddress ?? AppPreferences.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            AppStyles().mediumBolder.colored(AppColors.white)),
                  ),
                  Gap(6.w),
                  Flexible(
                    flex: 1,
                    child: ShowImage(
                        image: AppImages.dropDownIcon,
                        height: 20.h,
                        width: 20.h),
                  )
                ],
              ),
            ));
  }
}
