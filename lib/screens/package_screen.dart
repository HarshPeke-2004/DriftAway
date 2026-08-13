// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driftaway/data/constants.dart';
import 'package:driftaway/data/get_package_data.dart';
import 'package:driftaway/screens/booking_screen.dart';
import 'package:flutter/material.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key, required this.selectedCountry});

  final String selectedCountry;

  @override
  State<PackageScreen> createState() {
    return _PackageScreenState();
  }
}

class _PackageScreenState extends State<PackageScreen> {
  List<String> docIDs = [];
  bool isLoading = true;

  @override
  void initState() {
    getdocID();
    super.initState();
  }

  Future<void> getdocID() async {
  print('Querying for country: "${widget.selectedCountry}"');
  final snapshot = await FirebaseFirestore.instance
      .collection('packages')
      .where("country", isEqualTo: widget.selectedCountry)
      .get();

  print('Docs found: ${snapshot.docs.length}');

  final uniqueDocIDs = <String>{};
  snapshot.docs.forEach((document) {
    uniqueDocIDs.add(document.reference.id);
  });

  setState(() {
    docIDs = uniqueDocIDs.toList();
    isLoading = false;
  });
}

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Packages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            Text(
              '        CHOOSE\n YOUR PACKAGE!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),

            const SizedBox(height: 30),

            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 5,
                              child: ListTile(
                                onTap: () async {
                                  DocumentSnapshot packageSnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('packages')
                                          .doc(docIDs[index])
                                          .get();

                                  String packageName =
                                      packageSnapshot['package'];
                                  String cityName = packageSnapshot['city'];
                                  String days = packageSnapshot['days']
                                      .toString();
                                  String packagePrice = packageSnapshot['price']
                                      .toString();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                        country: widget.selectedCountry,
                                        package: packageName,
                                        price: packagePrice,
                                        city: cityName,
                                        days: days,
                                      ),
                                    ),
                                  );
                                },
                                title: GetPackageData(
                                  documentID: docIDs[index],
                                ),
                                tileColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    15,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
