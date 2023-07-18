import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends Cubit<String?> {
  Position? currentPosition;

  LocationController(super.initialState);

  Future<Position> getPosition() async {
    LocationPermission? permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLng(long, lat) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

      Placemark place = placemark[0];

      String? currentLocation =
          "${place.locality}, ${place.street}, ${place.subLocality}, ${place.administrativeArea}, ${place.country}";

      emit(currentLocation);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      currentPosition = await getPosition();
      getAddressFromLatLng(
          currentPosition!.longitude, currentPosition!.latitude);
    } catch (e) {
      print(e);
    }
  }
}
