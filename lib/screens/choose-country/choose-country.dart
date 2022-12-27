// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, file_names
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../../shared/shared.dart';
import '../../theme/colors.dart';
import 'dart:core';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({Key? key}) : super(key: key);
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  String googleApikey = "AIzaSyB_k7NaX_zJsYGSndy9Ty70qeJtsYxagog";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(31.961192, 35.912848);
  String location = "Amman";
  @override
  void initState() {
    // ignore: deprecated_member_use
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("chooseCountry")),
        ),
        body: Stack(children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            Stack(alignment: Alignment.center, children: [
              GoogleMap(
                zoomGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: startLocation,
                  zoom: 14,
                ),
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (position) {},
              ),
              const Icon(
                Icons.room,
                size: 50,
                color: Colors.red,
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      deliverylocationController.text = location;
                    });
                    Navigator.pop(navigatorKey.currentState!.context);
                  },
                  child: Text(
                    translate('saveAddress'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]),
          Positioned(
              top: 10,
              child: InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: googleApikey,
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      components: [Component(Component.country, 'jor')],
                    );
                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                      });
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: newlatlang, zoom: 17)));
                      setState(() {
                        deliverylocationController.text = location;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title: Text(
                              location,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: const Icon(Icons.search),
                          )),
                    ),
                  )))
        ]));
  }
}
