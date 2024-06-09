import 'package:flutter/material.dart';
import 'package:news_c_kelompok4/client/pembayaranClient.dart';
import 'package:news_c_kelompok4/model/pembayaran_model.dart';

class PembayaranViewList extends StatefulWidget {
  @override
  _PembayaranViewListState createState() => _PembayaranViewListState();
}

class _PembayaranViewListState extends State<PembayaranViewList> {
  late Future<List<pembayaranModel>> pembayaranList;

  @override
  void initState() {
    super.initState();
    pembayaranList = PembayaranClient.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran List'),
      ),
      body: FutureBuilder<List<pembayaranModel>>(
        future: pembayaranList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Pembayaran available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('ID: ${snapshot.data![index].id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Metode: ${snapshot.data![index].metode}'),
                        Text('Jumlah: ${snapshot.data![index].jumlah}'),
                        Text('Harga: ${snapshot.data![index].harga}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PembayaranViewList(),
  ));
}
