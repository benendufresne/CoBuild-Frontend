import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_evevt.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_media_placeholder.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_status.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Commmon Estimate card
class EstimateCard extends StatefulWidget {
  final EstimateRequestModel model;
  const EstimateCard({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _EstimateCardState();
}

class _EstimateCardState extends State<EstimateCard> {
  late EstimateController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<EstimateController>();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.estimateRequestDetails,
            extra: {AppKeys.id: widget.model.sId});
      },
      child: Container(
          padding: KEdgeInsets.kOnly(l: 16.w, r: 0.w, t: 0.h, b: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.white,
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Media
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: (widget.model.media?.isEmpty ?? true)
                  ? const EstimateMediaPlaceholder()
                  : EstimateRequestMediaView(
                      model: MediaModel(
                          media: widget.model.media,
                          mediaType: widget.model.mediaType)),
            ),
            Gap(16.w),
            // Detail
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service name
                    Text(CommonBottomSheetWidgets.serviceSubType(widget.model),
                        style:
                            AppStyles().mediumBolder.colored(AppColors.black)),
                    Gap(4.h),
                    if (CommonBottomSheetWidgets.serviceType(widget.model)
                        .isNotEmpty) ...[
                      Text(CommonBottomSheetWidgets.serviceType(widget.model),
                          style: AppStyles()
                              .smallSemiBold
                              .colored(AppColors.lightGreyText)),
                      Gap(5.h)
                    ],
                    if (widget.model.created != null) ...[
                      AppRichText(
                        children: [
                          AppTextSpan(
                              text: S.current.requestedOn,
                              style: AppStyles()
                                  .smallSemiBold
                                  .colored(AppColors.lightGreyText)),
                          AppTextSpan(
                              text: formatDate(widget.model.created),
                              style: AppStyles().smallSemiBold),
                        ],
                      ),
                      Gap(8.h)
                    ],
                    // Actions
                    EstimateRequestStatus(model: widget.model)
                  ],
                ),
              ),
            ),
            // Action icon
            (getEstimateEnumFromBackendValue(widget.model.status ?? '') ==
                    EstimatesStatusEnum.approved)
                ? Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: const SizedBox(),
                  )
                : _actionsForActiveEstimates(),
          ])),
    );
  }

  bool _showEditIcon() {
    return getEstimateEnumFromBackendValue(widget.model.status ?? '') ==
        EstimatesStatusEnum.pending;
  }

  bool _showDeleteIcon() {
    EstimatesStatusEnum status =
        getEstimateEnumFromBackendValue(widget.model.status ?? '');
    return !((status == EstimatesStatusEnum.inprogress) ||
        (status == EstimatesStatusEnum.approved));
  }

  Widget _actionsForActiveEstimates() {
    return (_showDeleteIcon() || _showEditIcon())
        ? PopupMenuButton<String>(
            icon: const ShowImage(image: AppImages.moreIcon),
            onSelected: (value) {
              // Handle menu selection
              if (value == S.current.edit) {
                _onEdit();
              } else if (value == S.current.delete) {
                _onDelete();
              }
            },
            itemBuilder: (BuildContext context) => [
              if (_showEditIcon())
                _menuItem(
                    value: S.current.edit,
                    icon: const ShowImage(
                      image: AppImages.editIcon,
                      color: AppColors.primaryColor,
                    )),
              if (_showDeleteIcon())
                _menuItem(
                    value: S.current.delete,
                    icon: const ShowImage(
                      image: AppImages.deleteIcon,
                    )),
            ],
          )
        : Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: const SizedBox(),
          );
  }

  PopupMenuItem<String> _menuItem(
      {required String value, required Widget icon}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  void _onEdit() {
    context.pushNamed(AppRoutes.estimatesRequestForm,
        extra: {AppKeys.model: widget.model});
  }

  void _onDelete({bool isCompleted = false}) {
    DialogBox().commonDialog(
      subtitle: S.current.deleteEstimateRequest,
      positiveText: S.current.yes,
      negativeText: S.current.no,
      onTapPositive: () {
        context.pop();
        controller.add(DeleteEstimateRequestEvent(
            estimateId: widget.model.sId ?? '', isCompleted: isCompleted));
      },
    );
  }
}
