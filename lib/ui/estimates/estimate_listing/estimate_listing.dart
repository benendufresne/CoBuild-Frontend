import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_evevt.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_state.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/ui/estimates/estimate_listing/estimate_card.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Estimate list view
class EstimateListing extends StatelessWidget {
  final List<EstimateRequestModel> list;
  final ScrollController controller;
  const EstimateListing(
      {super.key, required this.controller, required this.list});

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<EstimateController, EstimateState>(
        defaultView: (blocState) => Stack(
              children: [
                ListView.separated(
                    controller: controller,
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15.h);
                    },
                    itemBuilder: (context, index) {
                      EstimateRequestModel model = list[index];
                      return EstimateCard(model: model);
                    }),
                if (blocState.state == BlocState.loading &&
                    blocState.event is DeleteEstimateRequestEvent)
                  const Center(child: CommonLoader())
              ],
            ));
  }
}
