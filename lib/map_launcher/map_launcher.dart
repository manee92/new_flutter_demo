import 'package:map_launcher/map_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MapLauncherApp());
}

class MapLauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Map Launcher Demo",
      home: MyMapLauncher(),
    );
  }
}

class MyMapLauncher extends StatelessWidget {
  final coordinates = Coords(7.296389, 80.635);
  final title = "Kandy";
  final description = "Kandy, Sri Lanka";

  showMarkerWithFirstMap() async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: coordinates,
      title: title,
    );
  }

  showDirectionWithFirstMap() async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showDirections(
      destination: coordinates,
    );
  }

  checkAvailableAndShow() async {
    bool isGoogleMaps =
        await MapLauncher.isMapAvailable(MapType.google) ?? false;
    if (isGoogleMaps) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: coordinates,
        title: title,
        description: description,
      );
    }
  }

  openMapsSheet(BuildContext context) async {
    try {
      final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (AvailableMap map in availableMaps)
                    ListTile(
                      onTap: () => map.showDirections(
                        destination: coordinates,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Launcher Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kandy - Coordinates',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                coordinates.latitude.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                coordinates.longitude.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () => showMarkerWithFirstMap(),
                  child: Text('Show Marker With First Map')),
              ElevatedButton(
                  onPressed: () => showDirectionWithFirstMap(),
                  child: Text('Show Direction With First Map')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () => checkAvailableAndShow(),
                  child: Text('Check Availability And Show Marker')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () => openMapsSheet(context),
                  child: Text('Show Available Maps')),
            ],
          ),
        ));
  }
}
