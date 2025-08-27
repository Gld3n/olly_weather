import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:universal_html/html.dart' as html;

class LocationHelper {
  static Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return null;
      }

      PermissionStatus permissionGranted = kIsWeb
          ? await _checkLocationPermissionOnWeb()
          : await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return null;
      }

      return await location.getLocation();
    } catch (e) {
      print('LocationHelper: Error retrieving location | $e');
      throw Exception('location_service: Error retrieving location | $e');
    }
  }

  //* Workaround for Permissions API issue (see README.md)
  static Future<PermissionStatus> _checkLocationPermissionOnWeb() async {
    html.PermissionStatus? status = await html.window.navigator.permissions
        ?.query({'name': 'geolocation'});
    switch (status?.state) {
      case 'granted':
        return PermissionStatus.granted;
      case 'prompt':
        return PermissionStatus.denied;
      case 'denied':
      default:
        return PermissionStatus.deniedForever;
    }
  }
}
