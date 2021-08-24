import 'package:cl_weather_app/weather/models/permission_exception.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationRepository {
  PermissionWithService get _permission => Permission.locationWhenInUse;

  Future<bool> _checkService() async {
    return _permission.serviceStatus.isEnabled;
  }

  Future<PermissionStatus> _hasPermission() async {
    final status = await _permission.status;
    return status;
  }

  Future<Position> fetchWithAskPermission() async {
    final _permissionStatus = await _hasPermission();

    if (_permissionStatus == PermissionStatus.permanentlyDenied ||
        _permissionStatus == PermissionStatus.restricted) {
      throw PermissionException();
    }

    if (_permissionStatus == PermissionStatus.denied) {
      final permissionStatus = await _permission.request();
      if (permissionStatus != PermissionStatus.granted) {
        throw PermissionException();
      }
    }

    final _serviceEnabled = await _checkService();
    if (!_serviceEnabled) {
      throw PermissionException();
    }

    return Geolocator.getCurrentPosition();
  }
}
