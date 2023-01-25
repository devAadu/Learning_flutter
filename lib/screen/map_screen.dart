import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
      String imagePath, Size size, String name) async {


    TextSpan span = TextSpan(
        style: const TextStyle(
          height: 1.2,
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        text: name);

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    const double shadowWidth = 15.0;
    const double borderWidth = 3.0;
    const double imageOffset = shadowWidth + borderWidth;


    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = Colors.red.withOpacity(0.5);

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width / 8, size.width / 2, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowCirclePaint);

    // TEXT BOX BACKGROUND
    Paint textBgBoxPaint = Paint()..color = Colors.red;

    Rect rect = Rect.fromLTWH(
      0,
      0,
      tp.width + 35,
      50,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10.0)),
      textBgBoxPaint,
    );

    //ADD TEXT WITH ALIGN TO CANVAS
    tp.paint(canvas, const Offset(20.0, 5.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));


    // ADD  PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    ui.Image image = await getImageFromPath(
        imagePath);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }


  Future<BitmapDescriptor> getMarkerIcon(String image, String name) async {
    if (image != null) {
      final File markerImageFile =
      await DefaultCacheManager().getSingleFile(image);
      Size s = const Size(120, 120);

      var icon = await createCustomMarkerBitmapWithNameAndImage(markerImageFile.path, s, name);

      return icon;
    } else {
      return BitmapDescriptor.defaultMarker;
    }
  }
  Set<Marker> markers = {};

  setAllMarkers() async {
    markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: const LatLng(30.699285146824476, 76.69179040341325),
        icon: await getMarkerIcon(
            "https://quizprojectapp.s3.us-east-2.amazonaws.com/quizImage_1629380529687.png",
            "DAVID"),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId("2"),
        position: const LatLng(30.70246327295858, 76.69501482303754),
        icon: await getMarkerIcon(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcA3AmOb_BMAsPra4XquXuWFMNAi7grJL0ug&usqp=CAU",
            "ROSE"),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId("3"),
        position: const LatLng(30.704382049382055, 76.70102297115308),
        icon: await getMarkerIcon(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuIavvjuQFB38Se2ZNa0GkZ1Gol3C5OwioHA&usqp=CAU",
            "JASSABELLE"),
      ),
    );
    setState(() {});

  }



  @override
  void initState() {
    super.initState();
    setAllMarkers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
        onMapCreated: _onMapCreated,
        
      ),
    );
  }
}
