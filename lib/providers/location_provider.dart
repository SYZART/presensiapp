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
  ResultStateLocationProvider _stateLocationProvider =
      ResultStateLocationProvider.hasData;
  ResultStateLocationProvider get stateLocation => _stateLocationProvider;
  loc.Location location = loc.Location();
  String addres = '';
  String distance = '';
  // double lat1 = -6.3911331;
  // double lat2 = 0;
  // double long1 = 106.8488186;
  // double long2 = 0;
  double startLatitude = -6.3911331;
  double starLongtitude = 106.8488186;
  double endLatitude = 0;
  double endLongtitude = 0;

//   Future determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     Position position;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//       _stateLocationProvider = ResultStateLocationProvider.loading;
//       notifyListeners();
//     try {
//       position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude, position.longitude,
//           localeIdentifier: 'id_ID');
//       if (placemarks.isNotEmpty) {
//         lat2 = position.latitude;
//         long2 = position.longitude;

//         _stateLocationProvider = ResultStateLocationProvider.hasData;
//         notifyListeners();
//         // double calculateDistance(lat1, lon1, lat2, lon2) {
//         //   var p = 0.017453292519943295;
//         //   var c = cos;
//         //   var a = 0.5 -
//         //       c((lat2 - lat1) * p) / 2 +
//         //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//         //   return 12742 * asin(sqrt(a));
//         // }
//       }
//       // debugPrint(calculateDistance(lat1, long1, lat2, long2).toString());
//       debugPrint(placemarks.last.toString());
//       return addres =
//           '${placemarks.last.street} ${placemarks.last.subLocality} ${placemarks.last.locality} ${placemarks.last.subAdministrativeArea} ${placemarks.last.administrativeArea} ${placemarks.last.postalCode}';
//     } catch (e) {
//       _stateLocationProvider = ResultStateLocationProvider.error;
//       notifyListeners();
//       return;
//     }
//   }
// }

  // Future getLoc() async {
  //   late bool _serviceEnabled;
  //   late loc.PermissionStatus _permissionGranted;
  //   late loc.LocationData _locationData;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _stateLocationProvider = ResultStateLocationProvider.loading;
  //   notifyListeners();
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == loc.PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != loc.PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   try {
  //     _locationData =
  //         await location.getLocation().timeout(const Duration(seconds: 30),onTimeout:()=> onTime() );
  //     debugPrint(_locationData.toString());
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _locationData.latitude ?? -6.25101,
  //         _locationData.longitude ?? 106.8652419,
  //         localeIdentifier: 'id_ID');

  //     if (placemarks.isNotEmpty) {
  //       lat2 = _locationData.latitude ?? 0;
  //       long2 = _locationData.longitude ?? 0;

  //       _stateLocationProvider = ResultStateLocationProvider.hasData;
  //       notifyListeners();
  //       double calculateDistance(lat1, lon1, lat2, lon2) {
  //         var p = 0.017453292519943295;
  //         var c = cos;
  //         var a = 0.5 -
  //             c((lat2 - lat1) * p) / 2 +
  //             c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //         return 12742 * asin(sqrt(a));
  //       }

  //       debugPrint(calculateDistance(lat1, long1, lat2, long2).toString());
  //       debugPrint(placemarks.length.toString());
  //       debugPrint(placemarks[1].street);
  //       return addres =
  //           '${placemarks.last.street} ${placemarks[0].subLocality} ${placemarks[0].locality} ${placemarks[0].subAdministrativeArea} ${placemarks[0].administrativeArea} ${placemarks[0].postalCode}';
  //     }
  //   } catch (e) {
  //     _stateLocationProvider = ResultStateLocationProvider.error;
  //     notifyListeners();
  //     return;
  //   }
  // }
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
          timeLimit: const Duration(seconds: 30));

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: 'id_ID');
      if (placemarks.isNotEmpty) {
        // lat2 = position.latitude;
        // long2 = position.longitude;
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
