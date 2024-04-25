import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class FindUsController extends GetxController {
  goToThebna(double lang, double lat);
  determinePosition();
  distancebetwwen(double lati, double long);
}

class FindUsControllerImp extends FindUsController {
  double mylat = 0.0;

  double mylang = 0.0;

  List<String> bnanames = [
    "BNA Megrine",
    "BNA El Mourouj",
    "BNA Agence Moncef Bey",
    "BNA Agence Rue Al Jazira",
    "BNA - Banque Nationale Agricole",
    "BNA bab Souika",
    "BNA - Le Bardo",
    "Agence Banque Nationale Agricole Menzah 9",
    "BNA (DenDen)",
    "BNA Bank Elaouina",
    "BNA - Agence Ariana",
    "BNA - La Marsa",
    "BNA Mornaguia",
  ];

  List bnadistances = [
    {"lat": 36.76973250069705, "long": 10.234363642963347},
    {"lat": 36.73561704058818, "long": 10.20955269957016},
    {"lat": 36.79408230220227, "long": 10.185612703770364},
    {"lat": 36.79848106444125, "long": 10.175570514323397},
    {"lat": 36.81078251127313, "long": 10.18381025951065},
    {"lat": 36.80645317713801, "long": 10.169819858828124},
    {"lat": 36.81091894754387, "long": 10.138383965128432},
    {"lat": 36.8445793026004, "long": 10.155031118523599},
    {"lat": 36.80245197798408, "long": 10.108379789017125},
    {"lat": 36.856991679780215, "long": 10.256544995807463},
    {"lat": 36.85951150305139, "long": 10.193657873091329},
    {"lat": 36.88228689868776, "long": 10.327208449202631},
    {"lat": 36.75973707631205, "long": 10.019167849202631},
  ];

  Set<Marker> mymarkers = {
    Marker(
      markerId: const MarkerId("BNA Megrine"),
      position: const LatLng(36.76973250069705, 10.234363642963347),
      infoWindow: const InfoWindow(title: "BNA Megrine"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA El Mourouj"),
      position: const LatLng(36.73561704058818, 10.20955269957016),
      infoWindow: const InfoWindow(title: "BNA El Mourouj"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA Agence Moncef Bey"),
      position: const LatLng(36.79408230220227, 10.185612703770364),
      infoWindow: const InfoWindow(title: "BNA Agence Moncef Bey"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA Agence Rue Al Jazira"),
      position: const LatLng(36.79848106444125, 10.175570514323397),
      infoWindow: const InfoWindow(title: "BNA Agence Rue Al Jazira"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA - Banque Nationale Agricole"),
      position: const LatLng(36.81078251127313, 10.18381025951065),
      infoWindow: const InfoWindow(title: "BNA - Banque Nationale Agricole"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA bab Souika"),
      position: const LatLng(36.80645317713801, 10.169819858828124),
      infoWindow: const InfoWindow(title: "BNA bab Souika"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA - Le Bardo"),
      position: const LatLng(36.81091894754387, 10.138383965128432),
      infoWindow: const InfoWindow(title: "BNA - Le Bardo"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("Agence Banque Nationale Agricole Menzah 9"),
      position: const LatLng(36.8445793026004, 10.155031118523599),
      infoWindow:
          const InfoWindow(title: "Agence Banque Nationale Agricole Menzah 9"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA (DenDen)"),
      position: const LatLng(36.80245197798408, 10.108379789017125),
      infoWindow: const InfoWindow(title: "BNA (DenDen)"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA Bank Elaouina"),
      position: const LatLng(36.856991679780215, 10.256544995807463),
      infoWindow: const InfoWindow(title: "BNA Bank Elaouina"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA - Agence Ariana"),
      position: const LatLng(36.85951150305139, 10.193657873091329),
      infoWindow: const InfoWindow(title: "BNA - Agence Ariana"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA - La Marsa"),
      position: const LatLng(36.88228689868776, 10.327208449202631),
      infoWindow: const InfoWindow(title: "BNA - La Marsa"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId("BNA Mornaguia"),
      position: const LatLng(36.75973707631205, 10.019167849202631),
      infoWindow: const InfoWindow(title: "BNA Mornaguia"),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ),
  };

  Completer<GoogleMapController> googlecontroller =
      Completer<GoogleMapController>();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(36.76973250069705, 10.234363642963347),
    zoom: 12.4746,
  );

  @override
  void onInit() {
    determinePosition();
    setInitialCameraPosition();
    distancebetwwen(mylat, mylang);
    super.onInit();
  }

  @override
  Future<void> goToThebna(lang, lat) async {
    final GoogleMapController controller = await googlecontroller.future;
    CameraPosition bnalocation = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(lat, lang),
      tilt: 59.440717697143555,
      zoom: 15.151926040649414,
    );

    await controller.animateCamera(CameraUpdate.newCameraPosition(bnalocation));

    Get.back();
  }

  @override
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> setInitialCameraPosition() async {
    try {
      Position position = await determinePosition();

      kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.4746,
      );
      mylang = position.longitude;
      mylat = position.latitude;

      update();
    } catch (e) {
      return;
    }
  }

  @override
  double distancebetwwen(lati, long) {
    double distanceInMeters = Geolocator.distanceBetween(
      mylat,
      mylang,
      lati,
      long,
    );
    double distanceInKilometers = distanceInMeters / 1000.0;

    return double.parse(distanceInKilometers.toStringAsFixed(3));
  }
}
