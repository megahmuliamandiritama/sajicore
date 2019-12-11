// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapView extends StatefulWidget {
//   const GoogleMapView();

//   @override
//   State<StatefulWidget> createState() => GoogleMapViewState();
// }

// class GoogleMapViewState extends State<GoogleMapView> {
//   GoogleMapViewState();

//   static final LatLng center = const LatLng(-6.5977465, 106.7283743);

//   static GoogleMapController controller;
//   // int _markerCount = 0;
//   static Marker selectedMarker;

//   void _onMapCreated(GoogleMapController mapController) {
//     GoogleMapViewState.controller = mapController;
//     // GoogleMapViewState.controller.onMarkerTapped.add(_onMarkerTapped);

//     _initMarker();
//   }

//   void _initMarker() {
//     // controller.addMarker(MarkerOptions(
//     //   position: LatLng(-6.5977465, 106.7283743),
//     //   draggable: true,
//     //   infoWindowText: InfoWindowText('Marker #${_markerCount + 1}', '*'),
//     // ));

//     // controller.animateCamera(CameraUpdate.newCameraPosition(
//     //   const CameraPosition(
//     //     bearing: 270.0,
//     //     target: LatLng(-6.5977465, 106.7283743),
//     //     tilt: 30.0,
//     //     zoom: 17.0,
//     //   ),
//     // ));

//     setState(() {
//       // _markerCount += 1;
//     });
//   }

//   @override
//   void dispose() {
//     // controller?.onMarkerTapped?.remove(_onMarkerTapped);
//     super.dispose();
//   }

//   // void _onMarkerTapped(Marker marker) {
//   //   setState(() {
//   //     selectedMarker = marker;
//   //   });
//   // }

//   static void updateSelectedMarker(lat, lng, address) {
//     // GoogleMapViewState.controller.clearMarkers();
//     GoogleMapViewState.controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         bearing: 270.0,
//         target: LatLng(lat, lng),
//         tilt: 30.0,
//         zoom: 17.0,
//       ),
//     ));

//     // GoogleMapViewState.controller.addMarker(MarkerOptions(
//     //   position: LatLng(lat, lng),
//     //   draggable: true,
//     //   infoWindowText: InfoWindowText('Tujuan:', address),
//     // ));
//   }

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Expanded(
//           child: GoogleMap(
//             initialCameraPosition: _kGooglePlex,
//             onMapCreated: _onMapCreated,
//             // options: GoogleMapOptions(
//             //   cameraPosition: const CameraPosition(
//             //     target: LatLng(-33.852, 151.211),
//             //     zoom: 11.0,
//             //   ),
//             // ),
//           ),
//         ),
//       ],
//     );
//   }
// }
