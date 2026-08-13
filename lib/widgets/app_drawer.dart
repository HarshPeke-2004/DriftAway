import 'package:driftaway/admin/admin_login.dart';
import 'package:driftaway/screens/about_screen.dart';
import 'package:driftaway/screens/countrylist_screen.dart';
import 'package:driftaway/screens/explore_screen.dart';
import 'package:driftaway/screens/profile_screen.dart';
import 'package:driftaway/screens/show_bookings_screen.dart';
import 'package:driftaway/widgets/user_profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileScreen();
                            },
                          ),
                        );
                      },
                      child: UserProfileImage(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Divider(
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ExploreScreen();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      title: Text(
                        "  Home",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person_3,
                        color: Colors.black,
                      ),
                      title: Text(
                        "  Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CountrylistScreen();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.map,
                        color: Colors.black,
                      ),
                      title: Text(
                        "  Countries",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ShowBookingsScreen();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.airplane_ticket,
                        color: Colors.black,
                      ),
                      title: Text(
                        "  Bookings",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AdminLoginScreen();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.black,
                      ),
                      title: Text(
                        "  Admin Panel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AboutScreen();
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      title: Text(
                        "  About",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 35, bottom: 35),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  "  Log Out",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}