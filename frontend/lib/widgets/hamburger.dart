import 'package:flutter/material.dart';
import 'package:frontend/widgets/dashboard.dart';
import 'package:frontend/widgets/file_upload.dart';

class Hamburger extends StatefulWidget {
  const Hamburger({super.key});

  @override
  State<Hamburger> createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile2.jpg'),
              ),
            ),
            accountName: Text('Ryan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            accountEmail: Text('ryan@mit.edu',  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('COSC 5340'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DashBoard(course: 'COSC5340'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('COSC 3025'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DashBoard(course: 'COSC3025'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.network_locked_rounded),
            title: const Text('CS 4050'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DashBoard(course: 'CS4050'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.self_improvement),
            title: const Text('Independent study'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FileUpload(),
                ),
              );
            },
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('SimpliLearn v1.0'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
