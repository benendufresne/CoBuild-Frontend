import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_event.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_state.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class JobDetailsController extends Bloc<JobDetailsEvent, JobDetailsState> {
  final JobsRepository _repository = JobsRepository();
  JobDetailsController()
      : super(JobDetailsState(
            state: BlocState.none,
            event: const JobDetailsInitialEvent(),
            response: null,
            store: JobDetailsStateStore())) {
    on<GetJobDetailsEvent>(_getJobDetails);
    on<GetJobChatIdEvent>(_getJobChatId);
  }

  Future<void> _getJobDetails(
      GetJobDetailsEvent event, Emitter<JobDetailsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.jobDetails(event);
    if (response.state == BlocState.success) {
      state.store.model = JobModel.fromJson(response.data[ApiKeys.data]);
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  Future<void> _getJobChatId(
      GetJobChatIdEvent event, Emitter<JobDetailsState> emit) async {
    if (state.store.chatId?.isNotEmpty ?? false) {
      _navigateToChatPage();
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.jobChatId(event);
    if (response.state == BlocState.success) {
      if (response.data[ApiKeys.data] != null) {
        printCustom("chat id is ${response.data}");
        state.store.chatId = response.data[ApiKeys.data][ApiKeys.chatId];
        if ((state.store.chatId != null) && ctx.mounted) {
          _navigateToChatPage();
        }
      }
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  void _navigateToChatPage() {
    if (state.store.chatId?.isNotEmpty ?? false) {
      ctx.pushNamed(AppRoutes.chatPage,
          extra: {AppKeys.id: state.store.chatId});
    }
  }
}
