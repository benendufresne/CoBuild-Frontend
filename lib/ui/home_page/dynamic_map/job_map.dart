import 'dart:async';
import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_controller.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_event.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_state.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Show map for user to select job using map
class LocationMapView extends StatefulWidget {
  final JobModel? jobModel;
  const LocationMapView({super.key, this.jobModel});

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _kGooglePlex;
  late DynamicMapController blocController;
  late DynamicMapStateStore store;

  @override
  void initState() {
    super.initState();
    blocController = context.read<DynamicMapController>();
    store = blocController.state.store;
    if (widget.jobModel?.location?.coordinates?.isNotEmpty ?? false) {
      List<double> coordinates = widget.jobModel?.location?.coordinates ?? [];
      _kGooglePlex = CameraPosition(
        target: LatLng(coordinates[1], coordinates[0]),
        zoom: blocController.zoomLevel,
      );
    } else {
      _kGooglePlex = CameraPosition(
        target: const LatLng(37.42796133580664, -122.085749655962),
        zoom: blocController.zoomLevel,
      );
    }
  }

  void initMapData() {
    blocController.add(SetInitialJobLocationEvent(jobModel: widget.jobModel));
  }

  @override
  void dispose() {
    blocController.googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<DynamicMapController, DynamicMapState>(
        defaultView: (blocState) {
      return Stack(children: [
        GoogleMap(
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          markers: Set<Marker>.of(store.marker),
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            blocController.googleMapController = controller;
            initMapData();
          },
        ),
      ]);
    });
  }
}
