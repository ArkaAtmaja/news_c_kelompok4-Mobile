import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_c_kelompok4/addNews/add_item_screen.dart';
import 'package:news_c_kelompok4/model/addNews_model.dart';
import 'package:news_c_kelompok4/client/addNews_client.dart';
import 'package:news_c_kelompok4/view/home.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class YourPost extends StatefulWidget {
  const YourPost({Key? key}) : super(key: key);

  @override
  State<YourPost> createState() => _YourPostState();
}

class _YourPostState extends State<YourPost> {
  List<addNews> items = [];
  int? id;
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      List<addNews> fetchedNews = await addNewsClient.fetchAll();
      setState(() {
        items = fetchedNews;
      });
    } catch (e) {
      // Handle error
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('ADD NEWS'),
        // ),

        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Lokasi',
                  color: Color.fromARGB(113, 0, 116, 6),
                  icon: Icons.location_pin,
                  onTap: () async {
                    await _getCurrentPosition();
                    items[index].lokasi = _currentAddress!;
                    print(items[index].lokasi);
                    try {
                      await lokasi(items[index].id, _currentAddress!);
                    } catch (e) {
                      print(e);
                    }

                    _fetchNews();
                  },
                ),
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () {
                    id = items[index].id;
                    print(id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItemScreen(
                          title: 'Update Item',
                          id: items[index].id,
                          judul: items[index].judul,
                          kategori: items[index].kategori,
                          deskripsi: items[index].deskripsi,
                          onItemAdded: (Map<String, dynamic> newItem) {},
                        ),
                      ),
                    );
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    await _deleteItem(items[index].id);
                    _fetchNews();
                  },
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 167, 167, 167), // Set your desired background color
                  borderRadius: BorderRadius.circular(
                      16.0), // Set your desired border radius
                ),
                margin: EdgeInsets.all(16.0),
                child: ListTile(
                  title: Text(items[index].judul ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (items[index].imagePath != null)
                        Image.file(
                          File(items[index].imagePath!),
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      Text("Kategori: ${items[index].kategori ?? ''}"),
                      Text("Deskripsi: ${items[index].deskripsi ?? ''}"),
                      Text("data lokasi: ${items[index].lokasi ?? 'kosong'}"),
                    ],
                  ),
                  onTap: () {
                    // Add onTap behavior if needed
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddItemScreen(
                  title: 'Add News',
                  id: null,
                  judul: null,
                  kategori: null,
                  deskripsi: null,
                  onItemAdded: (Map<String, dynamic> newItem) {},
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _deleteItem(int id) async {
    try {
      await addNewsClient.destroy(id);
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> lokasi(int id, String lokasi) async {
    await addNewsClient.updateLokasi(id, lokasi);
  }
}
