import 'package:demo_app/screens/Request_tankerScreen.dart';
import 'package:demo_app/screens/track_tanker.dart';
import 'package:flutter/material.dart';

class TankerServiceScreen extends StatelessWidget {
  const TankerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Tanker Service'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildCard(
            context,
            'Request Tanker',
            Icons.local_shipping,
            () {
              // Handle Request Tanker tap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestTankerScreen(),
                ),
              );
            },
          ),
          buildCard(
            context,
            'Track Tanker',
            Icons.location_on,
            () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>const TrackTanker()));
            },
          ),
          buildCard(
            context,
            'Tanker History',
            Icons.history,
            () {
              // Handle Tanker History tap
               ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color.fromARGB(255, 41, 41, 41),
                      margin: EdgeInsets.symmetric(horizontal: 100,vertical: 50),
                      content: Text('Coming Soon'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
            },
          ),
          buildCard(
            context,
            'User Guide',
            Icons.book,
            () {
              // Handle User Guide tap
               ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color.fromARGB(255, 41, 41, 41),
                      margin: EdgeInsets.symmetric(horizontal: 100,vertical: 50),
                      content: Text('Coming Soon'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    double width = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon, size: width * 0.1, color: Colors.blue),
        title: Text(
          title,
          style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }
}