import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class JobDetailsEvent extends BlocEvent {
  const JobDetailsEvent();
}

class JobDetailsInitialEvent extends JobDetailsEvent {
  const JobDetailsInitialEvent();
}

/// Get Jobs Details
class GetJobDetailsEvent extends JobDetailsEvent {
  String jobId;
  GetJobDetailsEvent({required this.jobId});
}

class GetJobChatIdEvent extends JobDetailsEvent {
  final String jobId;
  const GetJobChatIdEvent({required this.jobId});
}
