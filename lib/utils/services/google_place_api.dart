import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:http/http.dart' as http;

// We will use this util class to fetch the auto complete result and get the details of the place.
class PlaceApiProvider {
  PlaceApiProvider(this.sessionToken);

  final String sessionToken;
  final apiKey = AppKeys.googlePlaceAPIKey;

  http.Request createGetRequest(String url) =>
      http.Request('GET', Uri.parse(url));

  FutureOr<List<LocationModel>?> fetchSuggestions(String input) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=establishment&key=$apiKey&sessiontoken=$sessionToken';
      var request = createGetRequest(url);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        final result = json.decode(data);

        if (result['status'] == 'OK') {
          return result['predictions']
              .map<LocationModel>((p) => LocationModel(
                  placeId: p['place_id'], address: p['description']))
              .toList();
        }
        if (result['status'] == 'ZERO_RESULTS') {
          return <LocationModel>[];
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } on SocketException {
      showSnackBar(message: S.current.noInternet);
      return <LocationModel>[];
    } on HandshakeException {
      showSnackBar(message: S.current.noInternet);
      return <LocationModel>[];
    } catch (e) {
      printCustom(e);
    }
    return null;
  }

  Future<LocationModel?> getPlaceDetailFromId(String placeId) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=formatted_address,name,geometry/location&key=$apiKey&sessiontoken=$sessionToken';
      var request = createGetRequest(url);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        final result = json.decode(data);
        printCustom(
            "result stauts ${result['status']}  res ${result['result']}");

        if (result['status'] == 'OK') {
          final place = LocationModel();
          place.address = result['result']['formatted_address'];
          place.coordinates = [
            result['result']['geometry']['location']['lng'],
            result['result']['geometry']['location']['lat']
          ];
          return place;
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } on SocketException {
      showSnackBar(message: S.current.noInternet);
      return null;
    } on HandshakeException {
      showSnackBar(message: S.current.noInternet);
      return null;
    } catch (e) {
      printCustom(e);
    }
    return null;
  }
}
