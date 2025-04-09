import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/job/filter_bloc/filter_controller.dart';
import 'package:cobuild/bloc/controller/job/filter_bloc/filter_event.dart';
import 'package:cobuild/bloc/controller/job/filter_bloc/filter_state.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_controller.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_event.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/empty_job_listing.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/app_common_radio_button.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/ui/widgets/common_check_box.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/enums/job_enums.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Screen to filter jobs , based upon multiple parameters
class FilterJobScreen extends StatefulWidget {
  const FilterJobScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FilterJobScreenState();
}

class _FilterJobScreenState extends State<FilterJobScreen> {
  late FilterController controller;
  late FilterStateStore store;
  late ServiceCategoryStateStore serviceCategoryStateStore;
  late ServiceCategoryController serviceCategoryController;

  @override
  void initState() {
    super.initState();
    controller = context.read<FilterController>();
    serviceCategoryController = context.read<ServiceCategoryController>();
    serviceCategoryStateStore = serviceCategoryController.state.store;
    _applyInitialFilters();
    store = controller.state.store;
    _getServiceCategory();
  }

  void _getServiceCategory() {
    serviceCategoryController.add(const GetServiceCategoryListEvent(
        type: ServiceTypeEnum.categoryService));
  }

  void _applyInitialFilters() {
    controller.add(InitPreApplyFiltersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.filters),
        bottomSheet: Container(
          color: AppColors.white,
          padding: KEdgeInsets.k(v: 18.h, h: 24.w),
          child: _applyAndResetButton(),
        ),
        body: Padding(
            padding: KEdgeInsets.kOnly(
                t: 1.h, l: 0, r: pageHorizontalPadding, b: 88.h),
            child: Column(
              children: [
                Expanded(child: _filters()),
              ],
            )));
  }

  Widget _applyAndResetButton() {
    return BlocBuilderNew<FilterController, FilterState>(
        onSuccess: (blocState) => {
              if (blocState.event is ApplyFiltersEvent ||
                  blocState.event is ResetFiltersEvent)
                {context.pop()}
            },
        defaultView: (blocState) {
          return Row(
            children: [
              Expanded(
                child: AppCommonButton(
                    buttonColor: AppColors.white,
                    buttonName: S.current.reset,
                    borderColor: AppColors.primaryColor,
                    style: AppStyles()
                        .mediumSemibold
                        .copyWith(color: AppColors.primaryColor),
                    onPressed: () {
                      controller.add(ResetFiltersEvent());
                    },
                    isExpanded: true),
              ),
              Gap(24.w),
              Expanded(
                child: AppCommonButton(
                    buttonName: S.current.apply,
                    onPressed: () {
                      controller.add(ApplyFiltersEvent());
                    },
                    isExpanded: true),
              ),
            ],
          );
        });
  }

  Widget _filters() {
    return BlocBuilderNew<FilterController, FilterState>(
        defaultView: (blocState) {
      return Row(
        children: [
          //left side tab bar for showing the contents like stay date and other things
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: JobFilterTypes.values
                    .map((type) => [
                          InkWell(
                            onTap: () {
                              controller.add(
                                  ChangeSelectedFilterTypeEvent(type: type));
                            },
                            child: Container(
                                alignment: Alignment.center,
                                color: store.selectedType == type
                                    ? AppColors.primaryColor
                                    : AppColors.white,
                                padding: KEdgeInsets.k14,
                                child: Title3(
                                    title: type.displayName,
                                    color: store.selectedType == type
                                        ? AppColors.white
                                        : AppColors.blackText)),
                          ),
                          const AppCommonDivider()
                        ])
                    .expand((e) => e)
                    .toList(),
              ),
            ),
          ),
          // right side tab to show the details of the respective selected field
          Expanded(
            flex: 3,
            child: _optionsOfSelectedFilterType(),
          )
        ],
      );
    });
  }

  Widget _optionsOfSelectedFilterType() {
    return ListView(
        padding: KEdgeInsets.kOnly(t: 14.h, l: 10.w),
        children: _subType() ?? []);
  }

  List<Widget>? _subType() {
    if (store.filtersModel == null) {
      return [const SizedBox()];
    }
    switch (store.selectedType) {
      case JobFilterTypes.status:
        return _statusFilter();
      case JobFilterTypes.serviceCategory:
        return _serviceCategoryFilterView();
      case JobFilterTypes.sortBy:
        return [
          Padding(
              padding: KEdgeInsets.kOnly(b: 10.h, l: 0),
              child: Title1(title: S.current.basedOnCreatedDate)),
          ..._sortByFilter()
        ];
      case JobFilterTypes.priority:
        return _priorityFilter();
    }
  }

  List<Widget>? _statusFilter() {
    return store.filtersModel?.status.keys.map((status) {
      return CheckBoxWithText(
          key: ValueKey(status),
          title: status.enumValue.displayName,
          value: store.filtersModel?.status[status],
          onChanged: (bool? isSelected) {
            setState(() {
              store.filtersModel?.status[status] = isSelected ?? false;
            });
          });
    }).toList();
  }

  List<Widget>? _serviceCategoryFilterView() {
    return [
      BlocBuilderNew<ServiceCategoryController, ServiceCategoryState>(
          loadingView: (blocState) {
        if (blocState.event is GetServiceCategoryListEvent &&
            serviceCategoryController.isCategoryListEmpty) {
          return const CommonLoader();
        }
        return _serviceCategory();
      }, failedView: (blocState) {
        return FailedView(onPressed: () {
          _getServiceCategory();
        });
      }, noInternetView: (blocState) {
        return NoInternetView(onPressed: () {
          _getServiceCategory();
        });
      }, defaultView: (blocState) {
        if (serviceCategoryController.isCategoryListEmpty) {
          return EmptyListing(title: S.current.nodataFound);
        }
        return _serviceCategory();
      })
    ];
  }

  Widget _serviceCategory() {
    if (serviceCategoryController.isCategoryListEmpty) {
      return const SizedBox();
    }
    return Column(
        children: serviceCategoryStateStore.categoryList.map((category) {
      return CheckBoxWithText(
          key: ValueKey(category),
          title: category.categoryName ?? '',
          value: store.filtersModel?.selectedServiceCategory
              .contains(category.sid ?? ''),
          onChanged: (bool? isSelected) {
            controller.add(AddCategoryFilterEvent(id: category.sid ?? ''));
          });
    }).toList());
  }

  List<Widget> _sortByFilter() {
    return SortByEnum.values.map((sort) {
      return CommonRadioButton<SortByEnum?>(
          key: ValueKey(sort),
          label: sort.displayName,
          value: sort,
          groupValue: store.filtersModel?.selectedSortBy,
          onChanged: (SortByEnum? sortBy) {
            setState(() {
              store.filtersModel?.selectedSortBy = sortBy;
            });
          });
    }).toList();
  }

  List<Widget>? _priorityFilter() {
    return store.filtersModel?.priority.keys.map((priority) {
      return CheckBoxWithText(
          key: ValueKey(priority),
          title: priority.enumValue.displayName,
          value: store.filtersModel?.priority[priority],
          onChanged: (bool? isSelected) {
            setState(() {
              store.filtersModel?.priority[priority] = isSelected ?? false;
            });
          });
    }).toList();
  }
}
