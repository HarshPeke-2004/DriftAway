import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  String? _userImageUrl;

  @override
  void initState() {
    _getUserImageUrl();
    super.initState();
  }

  void _getUserImageUrl() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userEmail = currentUser.email!;
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail);
      final userData = await userDoc.get();
      final userMap = userData.data();

      if (userMap != null && userMap.containsKey('profile')) {
        setState(() {
          _userImageUrl = userMap['profile'];
        });
      }
    }
  }

  void _pickimage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 500,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!) as ImageProvider<Object>?
              : (_userImageUrl != null
                    ? NetworkImage(_userImageUrl!) as ImageProvider<Object>?
                    : null),
        ),
        Positioned(
          bottom: -7,
          right: 177,
          child: IconButton(
            onPressed: _pickimage,
            icon: Icon(Icons.add_photo_alternate_outlined, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
