import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

enum ResultStateLocationProvider { loading, error, hasData }

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    getLocs();
  }
  // ResultStateLocationProvider? _stateLocationProvider;
  // ResultStateLocationProvider? get stateLocation => _stateLocationProvider;
  ResultStateLocationProvider? _stateLocationProvider;
  ResultStateLocationProvider? get stateLocation => _stateLocationProvider;
  loc.Location location = loc.Location();
  String addres = '';
  String distance = '';
  double startLatitude = -6.3911331;
  double starLongtitude = 106.8488186;
  double endLatitude = 0;
  double endLongtitude = 0;

  Future getLocs() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    Position position;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _stateLocationProvider = ResultStateLocationProvider.loading;
    notifyListeners();
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    try {
      position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              timeLimit: const Duration(seconds: 20))
          .onError(
        (error, stackTrace) => Position(
            longitude: 106.8639,
            latitude: -6.2548,
            timestamp: DateTime.now(),
            accuracy: 100,
            altitude: 10,
            altitudeAccuracy: 10,
            heading: 10,
            headingAccuracy: 10,
            speed: 10,
            speedAccuracy: 100),
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: 'id_ID');
      if (placemarks.isNotEmpty) {
        endLatitude = position.latitude;
        endLongtitude = position.longitude;

        _stateLocationProvider = ResultStateLocationProvider.hasData;
        notifyListeners();
        // double calculateDistance(lat1, lon1, lat2, lon2) {
        //   var p = 0.017453292519943295;
        //   var c = cos;
        //   var a = 0.5 -
        //       c((lat2 - lat1) * p) / 2 +
        //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
        //   return 12742 * asin(sqrt(a));
        // }

        // double distance = Geolocator.distanceBetween(
        //   endLatitude,
        //   endLongtitude,
        //   startLatitude,
        //   starLongtitude,
        // );

        return addres =
            '${placemarks.last.street} ${placemarks.last.subLocality} ${placemarks.last.locality} ${placemarks.last.subAdministrativeArea} ${placemarks.last.administrativeArea} ${placemarks.last.postalCode}';
      }
    } catch (e) {
      _stateLocationProvider = ResultStateLocationProvider.error;
      notifyListeners();
      return;
    }
  }
}
