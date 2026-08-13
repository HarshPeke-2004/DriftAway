import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key});

  @override
  State<UserProfileImage> createState() {
    return _UserProfileState();
  }
}

class _UserProfileState extends State<UserProfileImage> {
  String? _userImageUrl;

  @override
  void initState() {
    _getUserImageUrl();
    super.initState();
  }

  void _getUserImageUrl() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userEmail = currentUser.email;
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

  @override
  Widget build(context) {
    return _userImageUrl != null
        ? ClipOval(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(_userImageUrl!),
            ),
          )
        : CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/images/profile.png'),
          );
  }
}
