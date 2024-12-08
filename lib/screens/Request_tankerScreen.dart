import 'package:demo_app/screens/booking_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/tanker_request.dart';

class RequestTankerScreen extends StatefulWidget {
  const RequestTankerScreen({super.key});

  @override
  State<RequestTankerScreen> createState() => _RequestTankerScreenState();
}

class _RequestTankerScreenState extends State<RequestTankerScreen> {
  String? selectedGPS = 'GPS';
  String? selectedGallans;
  final TextEditingController addressController = TextEditingController();
  bool showTankerFare = false;

  final double ratePerGallon = 1.8;
  double tankerCharges = 0.0;
  double distanceFare = 0.0;

  final List<String> gpsOptions = ['GPS'];
  // ignore: non_constant_identifier_names
  final List<String> GallansOptions = ['1000', '2000', '3000'];

  void calculateCharges(String? gallons) {
    if (gallons != null) {
      setState(() {
        tankerCharges = double.parse(gallons) * ratePerGallon;
        showTankerFare = true;
      });
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.02),
            _buildTitle(),
        
            _buildDropdown(
              hint: 'GPS',
              value: selectedGPS,
              options: gpsOptions,
              onChanged: (newValue) => setState(() => selectedGPS = newValue),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              'Address',
              style: TextStyle(color: Colors.black38),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: addressController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              'Gallons',
              style: TextStyle(color: Colors.black38),
            ),
            _buildDropdown(
              hint: 'Gallans',
              value: selectedGallans,
              options: GallansOptions,
              onChanged: (newValue) {
                setState(() {
                  selectedGallans = newValue;
                  calculateCharges(newValue);
                });
              },
            ),
            Visibility(
              visible: showTankerFare,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                      
                        'Tanker Fare',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hydrant'),
                        Text('Sakhi Hasan'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tanker Charges'),
                        Text('Rs. ${tankerCharges.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Distance Fare'),
                        Text('Rs. ${distanceFare.toStringAsFixed(2)}'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total (approx)'),
                        Text(
                          'Rs. ${(tankerCharges + distanceFare).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildWarningText(),
            SizedBox(height: screenHeight * 0.04),
            _buildRequestButton(),
          ],
        ),
      ),
    );
  }
//? Custom Widgets 
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('OTS - Request Tanker', style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Tanker Service',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black38
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    bool isGPSDropdown = options.length == 1 && options[0] == 'GPS';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint),
          value: value,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: isGPSDropdown ? null : onChanged,
        ),
      ),
    );
  }

  Widget _buildWarningText() {
    return const Row(
      children: [
        Icon(Icons.warning, color: Colors.red, size: 16),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            'All Prices given are subject to change with distance!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestButton() {
    return ElevatedButton(
      onPressed: _handleRequest,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text(
        'Request Tanker',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _saveRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final request = TankerRequest(
      address: addressController.text,
      gallons: int.parse(selectedGallans!),
      tankerCharges: tankerCharges,
      distanceFare: distanceFare,
      totalCharges: tankerCharges + distanceFare,
      hydrantLocation: 'Sakhi Hasan',
      requestTime: DateTime.now(),
    );

    // Get existing requests
    List<String> requests = prefs.getStringList('tanker_requests') ?? [];
    requests.add(jsonEncode(request.toJson()));
    
    // Save updated list
    await prefs.setStringList('tanker_requests', requests);
  }

  void _handleRequest() async {
    if (selectedGPS != null && addressController.text.isNotEmpty && selectedGallans != null) {
      await _saveRequest();
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            tankerCharges: tankerCharges,
            distanceFare: distanceFare,
            hydrantLocation: 'Sakhi Hasan',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}

