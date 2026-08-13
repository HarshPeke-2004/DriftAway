import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key, required this.featureTitle});

  final String featureTitle;

  @override
  State<FeatureScreen> createState() {
    return _FeatureScreenState();
  }
}

class _FeatureScreenState extends State<FeatureScreen> {
  List<String> topItems = [];

  @override
  void initState() {
    super.initState();
    fetchTopItems();
  }

  void fetchTopItems() async {
    Set<String> items = {};
    String fieldName = '';
    if (widget.featureTitle == "Top Booked Packages") {
      fieldName = 'package';
    } else if (widget.featureTitle == "Top Booked Cities") {
      fieldName = 'city';
    } else if (widget.featureTitle == "Top Booked Destinations") {
      fieldName = 'country';
    }

    if (fieldName.isNotEmpty) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .orderBy(fieldName, descending: true)
          .limit(5)
          .get();
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) {
        items.add(doc[fieldName]);
      });
      setState(() {
        topItems = items.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.featureTitle)),
      body: ListView.builder(
        itemCount: topItems.length,
        itemBuilder: (context, index) {
          // Calculate the ranking based on the index
          int ranking = index + 1;
          return ListTile(
            title: Text(
              '$ranking. ${topItems[index]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
