import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowBookingsScreen extends StatefulWidget {
  const ShowBookingsScreen({super.key});

  @override
  State<ShowBookingsScreen> createState() {
    return _ShowBookingState();
  }
}

class _ShowBookingState extends State<ShowBookingsScreen> {
  late String? _userEmail;
  final List<Map<String, dynamic>> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    setState(() => _userEmail = email);
    if (email == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('email', isEqualTo: email)
        .get();

    setState(() {
      _bookings
        ..clear()
        ..addAll(snapshot.docs.map((d) => d.data()));
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Bookings')),
      body: _userEmail == null
          ? Center(child: CircularProgressIndicator())
          : _bookings.isEmpty
          ? Center(child: Text('No bookings found'))
          : ListView.builder(
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                final booking = _bookings[index];
                final date = booking['date'];
                final formattedDate = date != null
                    ? DateFormat(
                        'dd-MM-yyyy',
                      ).format((date as Timestamp).toDate())
                    : 'N/A';
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        'Package: ${booking['package']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Date: $formattedDate', // Use formatted date
                        style: TextStyle(fontSize: 16),
                      ),
                      tileColor: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
