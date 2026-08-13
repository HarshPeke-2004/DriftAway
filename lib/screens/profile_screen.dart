// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:driftaway/data/constants.dart';
import 'package:driftaway/widgets/textbox.dart';
import 'package:driftaway/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? _selectedImage;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // New variables to hold updated values
  String _updatedUsername = '';
  String _updatedPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    final userEmail = currentUser.email!;
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail);
    final userData = await userDoc.get();
    setState(() {
      _usernameController.text = userData['username'];
      _phoneNumberController.text =
          userData['phoneNumber'] ??
          ''; // Handle case where phone number is null
    });
  }

  Future<void> uploadImageToFirebaseStorage(File imageFile) async {
    final userEmail = currentUser.email!;
    final fileName = '$userEmail.jpg';
    final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
        .ref('profile_images')
        .child(fileName);

    try {
      await firebaseStorageRef.putFile(
        imageFile,
        firebase_storage.SettableMetadata(cacheControl: 'max-age=0'),
      );
      final imageUrl = await firebaseStorageRef.getDownloadURL();

      // Fetch the user's document by email
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail);

      // Update the document with the image URL
      await userDoc.set(
        {'profile': imageUrl},
        SetOptions(merge: true),
      ); // Merge the data with existing document if it exists

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image uploaded successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error uploading image: $e');
    }
  }

  Future<void> editField(String field) async {
    TextEditingController fieldController = field == 'Username'
        ? _usernameController
        : _phoneNumberController;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Edit $field'),
              content: TextField(
                controller: fieldController,
                decoration: InputDecoration(hintText: 'Enter new $field'),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Update the respective controller with the new value
                    if (field == 'Username') {
                      _updatedUsername =
                          fieldController.text; // Store updated username
                      _usernameController.text = fieldController.text;
                    } else if (field == 'Phone Number') {
                      _updatedPhoneNumber =
                          fieldController.text; // Store updated phone number
                      _phoneNumberController.text = fieldController.text;
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Account Details'),
        backgroundColor: kBackgroundColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 5),
          UserImagePicker(
            onPickImage: (pickedImage) {
              setState(() {
                _selectedImage = pickedImage;
              });
            },
          ),
          SizedBox(height: 15),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
          TextBoxx(
            secName: 'Username',
            onPressed: () => editField('Username'),
            text: _updatedUsername.isNotEmpty
                ? _updatedUsername
                : _usernameController.text,
          ),
          SizedBox(height: 10),
          TextBoxx(
            text: _updatedPhoneNumber.isNotEmpty
                ? _updatedPhoneNumber
                : _phoneNumberController.text,
            secName: 'Phone Number',
            onPressed: () => editField('Phone Number'),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_selectedImage != null ||
                    _usernameController.text != currentUser.displayName ||
                    _phoneNumberController.text != currentUser.phoneNumber) {
                  // Upload image if selected
                  if (_selectedImage != null) {
                    await uploadImageToFirebaseStorage(_selectedImage!);
                  }
                  // Save username and phone number to Firestore
                  final userEmail = currentUser.email!;
                  final userDoc = FirebaseFirestore.instance
                      .collection('users')
                      .doc(userEmail);
                  await userDoc.update({
                    'username': _usernameController.text,
                    'phoneNumber': _phoneNumberController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Changes saved successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No changes to save'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
