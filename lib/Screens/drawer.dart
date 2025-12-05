import 'package:flutter/material.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(''),
              //   fit: BoxFit.cover,
              // ),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 95, 82, 238),
                  Color.fromARGB(255, 119, 108, 247),
                  Color.fromARGB(255, 149, 153, 249),
                ],
              ),
            ),
            // decoration: BoxDecoration(shape: BoxShape.rectangle),
            padding: EdgeInsetsGeometry.zero,
            // margin: EdgeInsetsGeometry.zero,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              margin: EdgeInsets.zero,
              accountName: const Text('Mirza Sameer Asghar'),
              accountEmail: const Text('sameerasghar018@gmail.com'),
              currentAccountPictureSize: const Size.square(70),
              currentAccountPicture: SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset('assets/profile_avatar.jpeg'),
                ),
              ),

              // backgroundImage: AssetImage('assets/boy_logo.jpeg'),
              // decoration: BoxDecoration(
              //   // image: DecorationImage(
              //   //   image: AssetImage(''),
              //   //   fit: BoxFit.cover,
              //   // ),
              //   gradient: LinearGradient(
              //     colors: [
              //       Color.fromARGB(255, 95, 82, 238),
              //       Color.fromARGB(255, 119, 108, 247),
              //       Color.fromARGB(255, 149, 153, 249),
              //     ],
              //   ),
              // ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.brightness_4),
            title: const Text('Theme'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
