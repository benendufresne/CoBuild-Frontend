import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/filters/filters_model.dart';
import 'package:cobuild/models/location_model/location_model.dart';

abstract class JobListingEvent extends BlocEvent {
  const JobListingEvent();
}

class JobListingInitialEvent extends JobListingEvent {
  const JobListingInitialEvent();
}

class GetAllJobList extends JobListingEvent {
  final bool isHomePage;
  final bool isNextPage;
  List<double>? coordinates;
  FiltersModel? filters;
  int pageNo;
  GetAllJobList(
      {this.isHomePage = false,
      this.isNextPage = false,
      this.coordinates,
      this.filters,
      this.pageNo = 1});
}

class ApplyFiltersInJobListingEvent extends JobListingEvent {
  final FiltersModel? model;
  ApplyFiltersInJobListingEvent({required this.model});
}

class ResetFiltersInJobListingEvent extends JobListingEvent {
  ResetFiltersInJobListingEvent();
}

class UpdateJobLocationEvent extends JobListingEvent {
  LocationModel model;
  UpdateJobLocationEvent({required this.model});
}

class ClearJobData extends JobListingEvent {
  ClearJobData();
}
