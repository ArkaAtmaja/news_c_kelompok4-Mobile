import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:news_c_kelompok4/model/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.data, {Key? key}) : super(key: key);
  final NewsData data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double userRating = 0.0;

  @override
  void initState() {
    super.initState();
    loadRating(); // Load rating when the widget is initialized
  }

  void saveRatingLocally(double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('news_${widget.data.id}', rating);
  }

  void loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Use the correct key to retrieve the rating
    double? savedRating = prefs.getDouble('news_${widget.data.id}');

    if (savedRating != null) {
      setState(() {        userRating = savedRating;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.title!,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.data.author!,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: ObjectKey(widget.data),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(widget.data.urlToImage!),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: userRating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      userRating = rating;
                    });
                    saveRatingLocally(rating);
                  },
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  userRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(widget.data.content!)
          ],
        ),
      ),
    );
  }
}
