import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driftaway/data/constants.dart';
import 'package:flutter/material.dart';

class GetPackageData extends StatelessWidget {
  const GetPackageData({super.key, required this.documentID});

  final String documentID;

  @override
  Widget build(context) {
    CollectionReference packages = FirebaseFirestore.instance.collection(
      'packages',
    );

    return FutureBuilder<DocumentSnapshot>(
      future: packages.doc(documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: EdgeInsetsGeometry.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Package: ${data['package']}',
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                
                Text(
                  'Price: \$${data['price']} per person',
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                Text(
                  "Duration: ${data["days"]} days",
                  style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          );
        }
        return Text("Loading..");
      },
    );
  }
}
