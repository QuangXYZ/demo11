import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class DemoGeolocator extends StatefulWidget {
  const DemoGeolocator({super.key});

  @override
  State<DemoGeolocator> createState() => _DemoGeolocatorState();
}

class _DemoGeolocatorState extends State<DemoGeolocator> {
  String _location = "";
  Position? position;
  void _displayCurrentLocation() async {
    final status = await Permission.location.request();
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print(e);
      position = null;
    }

    if (position != null) {
      setState(() {
        _location = ' ${position!.latitude},${position!.longitude}';
      });
    } else {
      setState(() {
        _location = 'Error getting location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Vị trí của bạn: $_location"),
        ElevatedButton(
            onPressed: () {
              _displayCurrentLocation();
            },
            child: Text("Lấy vị trí"))
      ]),
    );
  }
}
