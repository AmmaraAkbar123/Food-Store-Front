import 'package:flutter/material.dart';
import 'package:foodstorefront/services/share_pref_service.dart';
import 'package:provider/provider.dart';
import '../login and signup/login/login_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cruds = Provider.of<Cruds>(context);
    final user = cruds.user;

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              user != null ? '${user.firstName} ${user.lastName}' : 'Hi Guest',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              minTileHeight: 5,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.privacy_tip),
              title: Text('Terms and Conditions'),
              onTap: () {
                // Navigate to Terms and Conditions page
              },
            ),
            ListTile(
              minTileHeight: 5,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.add_box_outlined),
              title: Text('About Us'),
              onTap: () {
                // Navigate to About Us page
              },
            ),
            ListTile(
              minTileHeight: 5,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.support_outlined),
              title: Text('Support Center'),
              onTap: () {
                // Navigate to Support Center page
              },
            ),
            ListTile(
              minTileHeight: 5,
              contentPadding: EdgeInsets.zero,
              leading: user != null ? Icon(Icons.logout) : Icon(Icons.login),
              title: Text(
                user != null ? 'Logout' : 'Login',
              ),
              onTap: () {
                if (user != null) {
                  // Perform logout
                  cruds.logout(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
