import 'dart:async';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_event.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_state.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DynamicMapController extends Bloc<DynamicMapEvent, DynamicMapState> {
  GoogleMapController? googleMapController;
  JobListingStateStore jobStore = ctx.read<JobListingController>().state.store;
  double zoomLevel = 14.4746;
  DynamicMapController()
      : super(DynamicMapState(
            state: BlocState.none,
            event: const DynamicMapInitialEvent(),
            response: null,
            store: DynamicMapStateStore())) {
    on<SetInitialJobLocationEvent>(_setInitialLocation);
    on<OnTapJobMarkerEvent>(_onTapJobMarker);
    on<CloseSeleectedJobOnMapEvent>(_closeSelectedJobOnMap);
    on<ClearMapDataEvent>(_clearDataOnLogout);
    on<UpdateMapViewEvent>(_updateMapView);
  }

  FutureOr _setInitialLocation(
      SetInitialJobLocationEvent event, Emitter<DynamicMapState> emit) async {
    add(ClearMapDataEvent());
    await Future.delayed(const Duration(seconds: 1));
    if (event.jobModel != null) {
      addJobsToList([event.jobModel!]);
      await _addMarkers([event.jobModel!]);
      await _moveCameraPosition(event.jobModel);
    } else {
      addJobsToList(jobStore.jobsListPaginationModel.models);
      await _addMarkers(state.store.jobList);
      if (state.store.jobList.isNotEmpty) {
        await _moveCameraPosition(state.store.jobList[0]);
      }
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr _updateMapView(
      UpdateMapViewEvent event, Emitter<DynamicMapState> emit) async {
    addJobsToList(jobStore.jobsListPaginationModel.models);
    await _addMarkers(state.store.jobList);
    if (event.initPage) {
      if (state.store.jobList.isNotEmpty) {
        await _moveCameraPosition(state.store.jobList.first);
      }
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr _onTapJobMarker(
      OnTapJobMarkerEvent event, Emitter<DynamicMapState> emit) async {
    if (event.jobModel == null) {
      return;
    } else {
      state.store.selectedJobModel = event.jobModel;
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr _closeSelectedJobOnMap(
      CloseSeleectedJobOnMapEvent event, Emitter<DynamicMapState> emit) async {
    if (state.store.selectedJobModel != null) {
      state.store.selectedJobModel = null;
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  Future<void> _addMarkers(List<JobModel> models) async {
    if (models.isEmpty) {
      return;
    }
    await initMarker();
    for (var model in models) {
      bool markerExists = state.store.marker
          .any((existingMarker) => existingMarker.markerId.value == model.sId);
      if (!markerExists) {
        state.store.marker.add(
          Marker(
            markerId: MarkerId(model.sId ?? ''),
            icon: markerIcon ?? BitmapDescriptor.defaultMarker,
            position: LatLng(model.location?.coordinates?[1] ?? 0,
                model.location?.coordinates?[0] ?? 0),
            draggable: false,
            onTap: () {
              add(OnTapJobMarkerEvent(jobModel: model));
            },
            onDragEnd: (post) {},
          ),
        );
      }
    }
  }

  Future<void> _moveCameraPosition(JobModel? model) async {
    if (model != null && (model.location?.coordinates?.isNotEmpty ?? false)) {
      var newPosition = CameraPosition(
          target: LatLng(model.location?.coordinates![1] ?? 0,
              model.location?.coordinates![0] ?? 0),
          zoom: zoomLevel * 1.25);

      CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
      await googleMapController?.animateCamera(update);
    }
  }

  void addJobsToList(List<JobModel> jobs) {
    for (JobModel job in jobs) {
      bool jobExists =
          state.store.jobList.any((existingJob) => existingJob.sId == job.sId);

      if (!jobExists) {
        // Add the job to the jobList if it doesn't already exist
        state.store.jobList.add(job);
      }
    }
  }

  int get totalJobCount {
    return jobStore.jobsListPaginationModel.totalJobCount;
  }

  FutureOr _clearDataOnLogout(
      ClearMapDataEvent event, Emitter<DynamicMapState> emit) async {
    state.store.selectedJobModel = null;
    state.store.jobList.clear();
    state.store.marker.clear();
    emit(state.copyWith(state: BlocState.success, event: event));
  }
}
