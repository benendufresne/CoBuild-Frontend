import 'package:cobuild/models/jobs/job_model.dart';

class JobsListPaginationModel {
  List<JobModel> models;
  int nextHit;
  int totalJobCount;

  JobsListPaginationModel(
      {required this.models, required this.nextHit, this.totalJobCount = 0});
}
