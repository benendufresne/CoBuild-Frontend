import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/job_listing.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter/material.dart';

/// Show list of jobs
class JobListingScreen extends StatefulWidget {
  const JobListingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.nearbyJobs),
        body: Padding(
          padding: KEdgeInsets.k(h: pageHorizontalPadding),
          child: const JobListing(),
        ));
  }
}
