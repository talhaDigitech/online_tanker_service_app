import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/screens/login_screen.dart';

import 'dart:convert';
import '../models/tanker_request.dart';
import 'package:intl/intl.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<TankerRequest> requests = [];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final requestStrings = prefs.getStringList('tanker_requests') ?? [];
    
    setState(() {
      requests = requestStrings
          .map((str) => TankerRequest.fromJson(jsonDecode(str)))
          .toList()
          .reversed
          .toList();
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    // Clear shared preferences
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear(); // This clears all stored data

    // Navigate to login screen and remove all previous routes
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false, // This removes all previous routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          // Add logout button to app bar
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: requests.isEmpty
          ? const Center(
              child: Text('No tanker requests yet'),
            )
          : ListView.builder(
              itemCount: requests.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final request = requests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('MMM dd, yyyy').format(request.requestTime),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(request.requestTime),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text('Address: ${request.address}'),
                        Text('Gallons: ${request.gallons}'),
                        Text('Hydrant: ${request.hydrantLocation}'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tanker Charges: Rs.${request.tankerCharges}'),
                            Text('Distance Fare: Rs.${request.distanceFare}'),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Total: Rs.${request.totalCharges}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Show confirmation dialog before logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _handleLogout(context); // Perform logout
              },
            ),
          ],
        );
      },
    );
  }
}