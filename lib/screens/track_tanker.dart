import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import '../models/tanker_request.dart';
import 'package:intl/intl.dart';

class TrackTanker extends StatefulWidget {
  const TrackTanker({super.key});

  @override
  State<TrackTanker> createState() => _TrackTankerState();
}

class _TrackTankerState extends State<TrackTanker> {
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
          .toList(); // Show newest first
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Tanker'),
       
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
}