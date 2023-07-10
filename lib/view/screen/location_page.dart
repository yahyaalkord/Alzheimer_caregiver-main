import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../controller/location_controller.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationControllerImp locationControllerImp =
        Get.put(LocationControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
        backgroundColor: Color(0xff096b6c),
      ),
      body: StreamBuilder(
          stream: locationControllerImp.getUserLocation(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                        minZoom: 5.0,
                        center: LatLng(snapshot.data.docs[0].data()["lat"],
                            snapshot.data.docs[0].data()['lng'])),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(markers: [
                        Marker(
                            height: 20,
                            width: 20,
                            point: LatLng(snapshot.data.docs[0].data()["lat"],
                                snapshot.data.docs[0].data()["lng"]),
                            builder: (context) {
                              return Container(
                                child: const Icon(
                                  Icons.location_on,
                                  color: Color(0xff096b6c),
                                  size: 50,
                                ),
                              );
                            }),
                      ])
                    ],
                  )
                ],
              );
            } else if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.cyan.shade500,
              ));
            } else {
              return const Text(
                "no users",
                style: TextStyle(fontSize: 24),
              );
            }
          }),
    );
  }
}
