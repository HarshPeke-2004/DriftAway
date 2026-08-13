import 'package:driftaway/data/constants.dart';
import 'package:driftaway/screens/package_screen.dart';
import 'package:flutter/material.dart';

class CountrylistScreen extends StatefulWidget {
  const CountrylistScreen({super.key});

  @override
  State<CountrylistScreen> createState() {
    return _CountryState();
  }
}

class _CountryState extends State<CountrylistScreen> {
  List<String> countries = [];
  Map<String, String> countryImages = {};

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Countries',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final imageUrl = countryImages[country];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PackageScreen(selectedCountry: country),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            imageUrl != null
                                ? Ink.image(
                                    image: NetworkImage(imageUrl),
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Ink.image(
                                    image: AssetImage(
                                      'assets/images/country.jpg',
                                    ),
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(
                                    0.4), // Adjust opacity as needed
                              ),
                            ),
                            // Text
                            ListTile(
                              title: Center(
                                child: Text(
                                  country,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}