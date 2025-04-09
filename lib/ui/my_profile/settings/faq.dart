import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_controller.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_events.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_states.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/models/faq_model/faq_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/shimmer_files/faq_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/html_reader.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// To show frequently asked questions
class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<StatefulWidget> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  late FAQController controller;
  MyProfileRepository repo = MyProfileRepository();

  @override
  void initState() {
    super.initState();
    controller = context.read<FAQController>();
    _getFAQs();
  }

  void _getFAQs() {
    controller.add(const GetFAQsEvent());
  }

  ///refresh challenge --------------------------------------------
  Future<void> _refreshData() async {
    _getFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(title: S.current.faq, child: _bodyView());
  }

  ///body -----------------------------------------
  Widget _bodyView() {
    return BlocBuilderNew<FAQController, FAQState>(
        failedView: (blocState) => _failedView(),
        noInternetView: (blocState) => _noInternetView(),
        defaultView: (blocState) => Container(
              padding: KEdgeInsets.k(h: 16.w, v: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.white),
              child: ValueListenableBuilder(
                  valueListenable: controller.state.store.faqCardCurrentIndex,
                  builder: (context, value, widget) {
                    if (blocState.state == BlocState.loading &&
                        blocState.event is GetFAQsEvent &&
                        repo.faqs.isEmpty) {
                      return const FAQTileShimmer(
                        itemCount: 10,
                      );
                    }
                    if (isEmptyList(blocState)) {
                      return Center(
                          child: Header2(heading: S.current.nodataFound));
                    }
                    return RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: repo.faqs.length,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: KEdgeInsets.k(h: 2.w, v: 5),
                              child: const AppCommonDivider(),
                            );
                          },
                          itemBuilder: (context, index) {
                            FAQModel model = repo.faqs[index];
                            return faqCard(
                                blocState: blocState,
                                model: model,
                                index: index,
                                value: value,
                                onTap: () {
                                  if (blocState
                                          .store.faqCardCurrentIndex.value ==
                                      index) {
                                    blocState.store.faqCardCurrentIndex.value =
                                        -1;
                                  } else {
                                    blocState.store.faqCardCurrentIndex.value =
                                        index;
                                  }
                                });
                          },
                        ));
                  }),
            ));
  }

  bool isEmptyList(FAQState blocState) {
    return (!(blocState.state == BlocState.loading &&
            blocState.event is GetFAQsEvent) &&
        (repo.faqs.isEmpty));
  }

  ///failed view -----------------------------------------
  Widget _failedView() {
    return FailedView(onPressed: () {
      controller.add(const GetFAQsEvent());
    });
  }

  ///no internet view -----------------------------------------
  Widget _noInternetView() {
    return NoInternetView(onPressed: () {
      controller.add(const GetFAQsEvent());
    });
  }

  ///faq card -----------------------------------------
  Widget faqCard({
    required FAQModel model,
    required int index,
    required int? value,
    void Function()? onTap,
    required FAQState blocState,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(index == 0 ? 0 : 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: HTMLReader(
                  html: model.question ?? '',
                  style: AppStyles().mediumBold,
                ),
              ),
              Gap(8.w),
              ShowImage(
                image: index == value
                    ? AppImages.minusCircle
                    : AppImages.plusCircle,
                height: 24.h,
                width: 24.w,
              ),
            ],
          ),
          if (index == value) ...[
            Gap(8.h),
            HTMLReader(
              html: model.answer ?? '',
              style: AppStyles().mediumBold.colored(AppColors.greyText),
            ),
          ],
          Gap((index == repo.faqs.length - 1) ? 0 : 22.h)
        ],
      ),
    );
  }
}
