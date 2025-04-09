import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_controller.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/text_fields/address_text_field.dart';
import 'package:cobuild/ui/components/text_fields/description_text_field.dart';
import 'package:cobuild/ui/components/text_fields/drop_down_text_field.dart';
import 'package:cobuild/ui/components/text_fields/name_text_field.dart';
import 'package:cobuild/ui/estimates/create_estimate_request/cable_consulting__components/cable_consulting_issue_type.dart';
import 'package:cobuild/ui/estimates/create_estimate_request/cable_consulting__components/select_cable_consulting_sub_issue.dart';
import 'package:cobuild/ui/estimates/create_estimate_request/select_category_service.dart';
import 'package:cobuild/ui/estimates/create_estimate_request/select_service_type.dart';
import 'package:cobuild/ui/shimmer_files/estimate_requests/estimate_edit_shimmer.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/media/add_media_widget.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Create estimate request
class EstimateRequestForm extends StatefulWidget {
  final EstimateRequestModel? model;
  const EstimateRequestForm({super.key, this.model});

  @override
  State<StatefulWidget> createState() => _EstimateRequestFormState();
}

class _EstimateRequestFormState extends State<EstimateRequestForm> {
  late EstimateRequestController controller;
  late ActiveEstimateController activeEstimateController;

  @override
  void initState() {
    super.initState();
    controller = context.read<EstimateRequestController>();
    activeEstimateController = context.read<ActiveEstimateController>();
    _initData();
  }

  void _initData() {
    controller.add(InitDataInCreateRequestEvent(model: widget.model));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.requestForm),
        bottomSheet: _createButton(),
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: KEdgeInsets.kOnly(
                t: pageVerticalPadding,
                l: pageHorizontalPadding,
                r: pageHorizontalPadding,
                b: pageVerticalPadding + 88.h),
            child:
                BlocBuilderNew<EstimateRequestController, EstimateRequestState>(
                    loadingView: (blocState) {
              if (blocState.event is InitDataInCreateRequestEvent) {
                return const EstimateEditShimmer();
              }
              return _formData();
            }, failedView: (blocState) {
              if (blocState.event is InitDataInCreateRequestEvent) {
                return Center(
                  child: FailedView(onPressed: () {
                    _initData();
                  }),
                );
              }
              return _formData();
            }, noInternetView: (blocState) {
              if (blocState.event is InitDataInCreateRequestEvent) {
                return Center(
                  child: NoInternetView(onPressed: () {
                    _initData();
                  }),
                );
              }
              return _formData();
            }, defaultView: (blocState) {
              return _formData();
            })));
  }

  Widget _formData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select Service
        DropDownTextField(
            controller: controller.serviceCategoryController,
            focusNode: controller.serviceCategoryFocus,
            hintText: S.current.selectService,
            onTap: () {
              _selectService();
            }),

        Gap(fieldGap),
        // Sub Category
        _subCategory(),
        _selectCableConsultingSubIssue(),

        // Address
        AddressTextField(
            controller: controller.addressController,
            focusNode: controller.addressFocus,
            locationModel: controller.locationModel),
        Gap(fieldGap),
        // Full name
        NameTextField(
          controller: controller.fullNameController,
          focusNode: controller.fullNameFocus,
          maxLength: AppConstant.nameMaxLimitInEstimate,
        ),
        Gap(fieldGap),
        // Mobile Number
        // PhoneTextField(
        //     controller: controller.mobileNumberController,
        //     focusNode: controller.mobileNumberFocus,
        //     countryCodeController: controller.countrycode),
        Gap(fieldGap),
        // Add Description
        DescriptionTextField(
          controller: controller.descriptionController,
          focusNode: controller.descriptionFocus,
          maxLength: AppConstant.descriptionMaxLength,
        ),
        Gap(fieldGap / 2),
        // Browse Photo
        AddMediaWidget(
          onSelect: (media) {
            controller.add(SelectMediaInCreateRequestEvent(file: media));
          },
          preSelectedMedia: controller.uploadedMediaModel,
        ),
      ],
    );
  }

  Widget _subCategory() {
    switch (controller.selectedServiceType) {
      case ServiceTypeEnum.categoryService:
        // i.Select Category :- if Service is "Category Service"
        return Column(
          children: [
            DropDownTextField(
                controller: controller.categoryServiceController,
                focusNode: controller.categoryServiceFocus,
                hintText: S.current.selectCategory,
                onTap: () {
                  _selectCategoryService();
                }),
            Gap(fieldGap),
          ],
        );
      case ServiceTypeEnum.customService:
        //ii.Enter Custom service name :- if Service is "Custom Service"
        return Column(
          children: [
            NameTextField(
              controller: controller.customServiceController,
              focusNode: controller.customServiceFocus,
              hint: S.current.enterCustomService,
              maxLength: AppConstant.maxCustomEstimateName,
            ),
            Gap(fieldGap),
          ],
        );
      case ServiceTypeEnum.cableConsultingService:
        // iii.Select consulting Service :- if Cable consulting is seleceted
        return Column(
          children: [
            DropDownTextField(
              controller: controller.consultingIssueController,
              focusNode: controller.consultingServiceFocus,
              hintText: S.current.selectConsultingServices,
              onTap: () {
                _selectCableConsultingIssue();
              },
            ),
            Gap(fieldGap),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Future<void> _selectService() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SelectCategory(onselect: (type) {
            controller.add(SelectServiceTypeInCreateRequestEvent(type: type));
          });
        });
  }

  // if type is 1 => select sub type
  Future<void> _selectCategoryService() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SelectCategoryService(
            onTap: (type) {
              controller
                  .add(SelectServiceCategoryCreateRequestEvent(type: type));
            },
          );
        });
  }

  Widget _createButton() {
    double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardSpace > 0) return const SizedBox();
    return BlocBuilderNew<EstimateRequestController, EstimateRequestState>(
        onSuccess: (blocState) {
      if (blocState.event is CreateEstimateRequestEvent) {
        if ((blocState.response?.data != null) &&
            (blocState.response?.data is EstimateRequestModel)) {
          EstimateRequestModel model =
              blocState.response?.data as EstimateRequestModel;
          _showSuccessDialog(id: model.chatId);
        } else {
          _showSuccessDialog();
        }
      } else if (blocState.event is UpdateEstimateRequestEvent) {
        _showSuccessDialog(isUpdate: true);
      }
    }, defaultView: (blocState) {
      if (((widget.model != null) &&
              (blocState.event is InitDataInCreateRequestEvent)) &&
          ((blocState.state == BlocState.loading) ||
              (blocState.state == BlocState.noInternet) ||
              (blocState.state == BlocState.failed))) {
        return const SizedBox();
      }
      return Container(
        color: AppColors.white,
        padding: KEdgeInsets.k(v: 18.h, h: 24.w),
        child: AppCommonButton(
            buttonName:
                widget.model != null ? S.current.update : S.current.create,
            isLoading: (((blocState.event is CreateEstimateRequestEvent) ||
                    (blocState.event is UpdateEstimateRequestEvent)) &&
                blocState.state == BlocState.loading),
            onPressed: () {
              if (controller.isAllDetailsFilled()) {
                if (widget.model != null) {
                  EstimateRequestModel updateModel = controller.getCreateModel;
                  updateModel.reqId = widget.model?.sId;
                  controller
                      .add(UpdateEstimateRequestEvent(model: updateModel));
                } else {
                  controller.add(CreateEstimateRequestEvent(
                      model: controller.getCreateModel));
                }
              } else {
                showSnackBar(message: S.current.provideRequiredDetails);
              }
            },
            isExpanded: true),
      );
    });
  }

  void _showSuccessDialog({bool isUpdate = false, String? id}) {
    DialogBox().successDialog(
        subtitle: isUpdate
            ? S.current.estimatedRequestUpdated
            : S.current.estimatedRequestCreated,
        onTap: () {
          context.pop();
          context.pop();
          if ((!isUpdate) && (id?.isNotEmpty ?? false)) {
            context.pushNamed(AppRoutes.chatPage, extra: {AppKeys.id: id});
          }
          if (isUpdate) {
            activeEstimateController.add(GetActiveEstimatesEvent());
          }
        });
  }

  /// cable consulting
  Future<void> _selectCableConsultingIssue() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return CableConsultingIssueType(onSelect: (type) {
            controller.add(
                SelectCableConsultingIssueInCreateRequestEvent(type: type));
          });
        });
  }

  Widget _selectCableConsultingSubIssue() {
    if (controller.selectedServiceType ==
            ServiceTypeEnum.cableConsultingService &&
        controller.selectedCableConsultingIssueType != null) {
      return Column(
        children: [
          const CableConsultingSubIssueTextField(),
          Gap(fieldGap),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
  //// -------- END ------
}
