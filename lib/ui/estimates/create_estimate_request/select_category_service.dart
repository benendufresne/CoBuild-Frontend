import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_controller.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_event.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/service_category/service_category.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title2.dart';
import 'package:cobuild/ui/estimates/components/bottom_sheet_common_widgets.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/ui/shimmer_files/service_category_listing_shimmer.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Select category service (From multiple category services)
class SelectCategoryService extends StatefulWidget {
  final Function(ServiceCategoryModel model) onTap;
  const SelectCategoryService({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _SelectCategoryServiceState();
}

class _SelectCategoryServiceState extends State<SelectCategoryService> {
  late ServiceCategoryStateStore serviceCategoryStateStore;
  late ServiceCategoryController serviceCategoryController;
  final _debouncer = DeBouncer(milliseconds: 800);
  ValidatedController controller = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    serviceCategoryController = context.read<ServiceCategoryController>();
    serviceCategoryStateStore = serviceCategoryController.state.store;
    _getServiceCategory();
  }

  void _getServiceCategory() {
    serviceCategoryController.add(const GetServiceCategoryListEvent(
        type: ServiceTypeEnum.categoryService));
  }

  @override
  Widget build(BuildContext context) {
    return CommonSelectableBottomSheet(
      title: S.current.selectCategory,
      child:
          SizedBox(height: deviceHeight * 0.5, child: _showServiceCategory()),
    );
  }

  Widget _showServiceCategory() {
    return BlocBuilderNew<ServiceCategoryController, ServiceCategoryState>(
        failedView: (blocState) {
      return FailedView(onPressed: () {
        _getServiceCategory();
      });
    }, defaultView: (blocState) {
      if ((serviceCategoryController.isCategoryListEmpty) &&
          (blocState.event is! GetServiceCategoryListEvent)) {
        return FailedView(
            message: S.current.noServiceCategoryFound,
            onPressed: () {
              _getServiceCategory();
            });
      }
      return _body();
    });
  }

  Widget _body() {
    return Column(
      children: [_searchField(), Gap(10.h), _data()],
    );
  }

  Widget _data() {
    if (serviceCategoryController.state.event is GetServiceCategoryListEvent ||
        serviceCategoryController.state.event is SearchServiceCategoryEvent) {
      return const CategoryServiceShimmer(
        itemCount: 3,
      );
    }
    if (controller.text.trim().isEmpty) {
      return _serviceCategory(serviceCategoryStateStore.categoryList);
    } else {
      return _serviceCategory(serviceCategoryStateStore.searchList);
    }
  }

  Widget _searchField() {
    return AppTextField(
      autoFocus: false,
      onChange: (value) async {
        _debouncer.run(() async {
          callSearchApi(value);
        });
      },
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      maxLength: AppConstant.searchMaxLength,
      hintText: S.current.search,
      controller: controller,
      keyboardType: TextInputType.name,
      prefixWidget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ShowImage(
          image: AppImages.searchIcon,
          height: 24.h,
          width: 24.h,
        ),
      ),
    );
  }

  Widget _serviceCategory(List<ServiceCategoryModel> categoryList) {
    if (categoryList.isEmpty) {
      return Title2(title: S.current.noServiceCategoryFound);
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              context.pop();
              widget.onTap(categoryList[index]);
            },
            child: CommonBottomSheetWidgets.option(
                categoryList[index].categoryName ?? ''));
      },
      separatorBuilder: (context, index) {
        return CommonBottomSheetWidgets.commonDivider();
      },
    );
  }

  void callSearchApi(String value) async {
    serviceCategoryController.add(SearchServiceCategoryEvent(
        key: value, type: ServiceTypeEnum.categoryService));
  }
}
