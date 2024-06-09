import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c_kelompok4/view/home.dart';
import 'package:news_c_kelompok4/view/payments/body.dart';
import 'package:news_c_kelompok4/view/payments/pdf/invoice/model/product.dart';
import 'package:news_c_kelompok4/view/payments/pdf/pdf_view.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the toast package

class PaymentDetailsModal extends StatefulWidget {
  const PaymentDetailsModal({Key? key}) : super(key: key);

  static void show(BuildContext context, int subscriptionCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: PaymentDetailsContent(
            id: const Uuid().v1(),
            image: File('lib/images/logo.png'),
            products: [
              Product("Membership", 10000),
            ],
            subscriptionCount: subscriptionCount,
          ),
        );
      },
    );
  }

  @override
  _PaymentDetailsModalState createState() => _PaymentDetailsModalState();
}

class _PaymentDetailsModalState extends State<PaymentDetailsModal> {
  final formKey = GlobalKey<FormState>();
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PaymentDetailsContent extends StatelessWidget {
  final String id;
  final File image;
  final List<Product> products;
  late int subscriptionCount;

  PaymentDetailsContent({
    required this.id,
    required this.image,
    required this.products,
    required this.subscriptionCount,
    Key? key,
  }) : super(key: key);

  void _showConfirmationDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin $action?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
                if (action == 'mengubah data') {
                  _showToast2('Batal mengubah Data');
                } else if (action == 'menghapus data') {
                  _showToast2('Batal menghapus data');
                  _resetValues();
                }
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Body()),
                );
                if (action == 'mengubah data') {
                  _showToast('Data diubah');
                } else if (action == 'menghapus data') {
                  _showToast('Data dihapus');
                  _resetValues();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _resetValues() {
    // Update values as needed after deletion
    // For example, setting subscriptionCount to 0
    // You can adjust this based on your actual logic
    subscriptionCount = 0;
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showToast2(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget buildText(String text, TextAlign align, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Detail Pembayaran',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText('Total', TextAlign.left),
              Text(
                '${subscriptionCount * 10000}',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText('Pembayaran', TextAlign.left),
              buildText('Gopay', TextAlign.right),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText('Kode Bayar', TextAlign.left),
              buildText('12345', TextAlign.right),
            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              _showConfirmationDialog(context, 'mengubah data');
            },
            child: buildText('Detail', TextAlign.left, color: Colors.green),
          ),
          GestureDetector(
            onTap: () {
              _showConfirmationDialog(context, 'mengubah data');
            },
            child: buildText('Ubah', TextAlign.left, color: Colors.blue),
          ),
          GestureDetector(
            onTap: () {
              _showConfirmationDialog(context, 'menghapus data');
            },
            child: buildText('Delete', TextAlign.left, color: Colors.red),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFA95C8D),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text('Oke'),
            ),
          ),
        ],
      ),
    );
  }
}
