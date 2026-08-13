// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:driftaway/widgets/confirmed.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

// class BookingScreen extends StatefulWidget {
//   const BookingScreen({
//     super.key,
//     required this.country,
//     required this.city,
//     required this.package,
//     required this.price,
//     required this.days,
//   });

//   final String country;
//   final String package;
//   final String price;
//   final String city;
//   final String days;

//   @override
//   State<BookingScreen> createState() {
//     return _BookingState();
//   }
// }

// class _BookingState extends State<BookingScreen> {
//   DateTime? _selectedDate;
//   int _numberOfPersons = 1;

//   void _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(DateTime.now().year + 1),
//     );

//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   void navigateToConfirmScreen() {
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (context) => ConfirmScreen()));
//   }

//   @override
//   Widget build(context) {
//     double totalPrice = double.parse(widget.price) * _numberOfPersons;

//     return Scaffold(
//       appBar: AppBar(title: Text('Booking Screen')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Country: ${widget.country}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               'City: ${widget.city}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               'Package: ${widget.package}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               'Duration: ${widget.days} days',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               'Total Price: $totalPrice',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),

//             Text(
//               'Select Date: ',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text(
//                 _selectedDate == null
//                     ? 'Select Date'
//                     : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
//               ),
//             ),

//             const SizedBox(height: 20),

//             Text(
//               'Number of Persons:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     if (_numberOfPersons > 1) {
//                       setState(() {
//                         _numberOfPersons--;
//                       });
//                     }
//                   },
//                   icon: Icon(Icons.remove),
//                 ),
//                 Text(
//                   '$_numberOfPersons',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),

//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _numberOfPersons++;
//                     });
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (_selectedDate == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Please select a date!'),
//                         duration: Duration(seconds: 2),
//                       ),
//                     );
//                   } else {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => PaypalCheckoutView(
//                           sandboxMode: true,
//                           clientId:
//                               "AWavo88toW40JBjA8PPyqr97jwMdZ8VqByQhOXvl4QMi5pxz1EKKNUDSvcNTpId5O9JqKqEglsskms6p",
//                           secretKey:
//                               "ECSQAp-U3TB7-rjyuSZn_0Q7xMqeXZaN2LNBMWwMng1rrmHy9uVpfHhocIlXXgPxZFH2FEHAJjwN-byr",
//                           // returnURL: "success.snippetcoder.com",
//                           // cancelURL: "cancel.snippetcoder.com",
//                           transactions: [
//                             {
//                               "amount": {
//                                 "total": totalPrice.toString(),
//                                 "currency": "USD",
//                               },
//                               "description":
//                                   "Booking payment for ${widget.package}",
//                             }
//                           ],
//                           note:
//                               "Booking payment for ${widget.package} (${widget.days} days)",
//                           onSuccess: (params) async {
//                             // Payment success, push booking information to Firebase
//                             String? userEmail =
//                                 FirebaseAuth.instance.currentUser?.email;
//                             if (userEmail != null) {
//                               await FirebaseFirestore.instance
//                                   .collection('bookings')
//                                   .add({
//                                 'country': widget.country,
//                                 'city': widget.city,
//                                 'package': widget.package,
//                                 'days': widget.days,
//                                 'price': totalPrice,
//                                 'date': _selectedDate,
//                                 'numberOfPersons': _numberOfPersons,
//                                 'email': userEmail,
//                               });
//                             }
//                             navigateToConfirmScreen(); // Navigate to ConfirmScreen
//                           },
//                           onError: (error) {
//                             print("onError: $error");
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Failed to process payment!'),
//                               ),
//                             );
//                           },
//                           onCancel: () {
//                             print('Payment cancelled');
//                           },
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Book Now with PayPal'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driftaway/widgets/confirmed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    super.key,
    required this.country,
    required this.city,
    required this.package,
    required this.price,
    required this.days,
  });

  final String country;
  final String package;
  final String price;
  final String city;
  final String days;

  @override
  State<BookingScreen> createState() {
    return _BookingState();
  }
}

class _BookingState extends State<BookingScreen> {
  DateTime? _selectedDate;
  int _numberOfPersons = 1;

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void navigateToConfirmScreen() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => ConfirmScreen()));
  }

  // Shared save logic used by both PayPal and Demo Payment flows.
  Future<void> _saveBooking({
    required int totalPrice,
    required String paymentMethod,
  }) async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userEmail != null) {
      await FirebaseFirestore.instance.collection('bookings').add({
        'country': widget.country,
        'city': widget.city,
        'package': widget.package,
        'days': widget.days,
        'price': totalPrice,
        'date': _selectedDate,
        'numberOfPersons': _numberOfPersons,
        'email': userEmail,
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentMethod == 'PayPal' ? 'Paid' : 'Demo',
      });
    }
  }

  bool _validateDateSelected() {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date!'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(context) {
    int totalPrice = int.parse(widget.price) * _numberOfPersons;

    return Scaffold(
      appBar: AppBar(title: Text('Booking Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Country: ${widget.country}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                'City: ${widget.city}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                'Package: ${widget.package}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                'Duration: ${widget.days} days',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                'Total Price: $totalPrice',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Text(
                'Select Date: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Number of Persons:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (_numberOfPersons > 1) {
                        setState(() {
                          _numberOfPersons--;
                        });
                      }
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    '$_numberOfPersons',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    onPressed: () {
                      setState(() {
                        _numberOfPersons++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ---- Option 1: Pay with PayPal (real payment flow) ----
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_validateDateSelected()) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaypalCheckoutView(
                            sandboxMode: true,
                            clientId:
                                "AWavo88toW40JBjA8PPyqr97jwMdZ8VqByQhOXvl4QMi5pxz1EKKNUDSvcNTpId5O9JqKqEglsskms6p",
                            secretKey:
                                "ECSQAp-U3TB7-rjyuSZn_0Q7xMqeXZaN2LNBMWwMng1rrmHy9uVpfHhocIlXXgPxZFH2FEHAJjwN-byr",
                            transactions: [
                              {
                                "amount": {
                                  "total": totalPrice.toString(),
                                  "currency": "USD",
                                },
                                "description":
                                    "Booking payment for ${widget.package}",
                              }
                            ],
                            note:
                                "Booking payment for ${widget.package} (${widget.days} days)",
                            onSuccess: (params) async {
                              await _saveBooking(
                                totalPrice: totalPrice,
                                paymentMethod: 'PayPal',
                              );
                              navigateToConfirmScreen();
                            },
                            onError: (error) {
                              print("onError: $error");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to process payment!'),
                                ),
                              );
                            },
                            onCancel: () {
                              print('Payment cancelled');
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Book Now with PayPal'),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ---- Option 2: Demo Payment (no external checkout, instant booking) ----
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      if (!_validateDateSelected()) return;

                      await _saveBooking(
                        totalPrice: totalPrice,
                        paymentMethod: 'Demo Payment',
                      );
                      navigateToConfirmScreen();
                    },
                    child: Text('Book Now (Demo Payment)'),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}