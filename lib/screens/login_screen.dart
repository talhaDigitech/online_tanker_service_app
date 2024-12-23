import 'package:demo_app/screens/AdminScreen.dart';
import 'package:demo_app/screens/HomeScreen.dart';
import 'package:demo_app/widgets/custom_bottom.dart';
import 'package:demo_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Constants for styling
  static const double _inputHeight = 48.0; // Reduced height for both containers
  static const double _borderRadius = 8.0;
  // static const double _horizontalPadding = 16.0;  // Slightly reduced padding
  static const double _flagSize = 20.0; // Slightly smaller flag

  //? Admin number
  int admin = 03132076068;

  // Get the screen width and height

  // Form key to validate the form
  final formKey = GlobalKey<FormState>();

  // Controller for the TextField
  TextEditingController phoneController = TextEditingController();
  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userType', 'admin');

      // Navigate to admin screen
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AdminScreen()));
    } else {
      print('Validation Failed');
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomContainer(
                  height: screenHeight * 0.35,
                  width: screenWidth,
                  gradientColors: const [Color(0xFF0079C2), Colors.lightBlue],
                  centerText: "M & M Brothers Online Tanker Service",
                  textStyle: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height

              // Prompt Text
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05), // 5% of screen width
                child: const Text(
                  'Please enter your mobile number to continue.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // 2% of screen height

              // Form with validation
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05), // 5% of screen width
                      child: Row(
                        children: [
                          // Country Code Box
                          _buildCountryCodeContainer(),
                          SizedBox(width: screenWidth * 0.03),

                          // Phone Number Field
                          _buildPhoneNumberField(),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: screenHeight * 0.04), // 4% of screen height

                    //? Login Button
                    CustomButton(
                      text: "Login",
                      backgroundColor: const Color(0xFF0079C2),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final enteredNumber = int.parse(phoneController.text);
                          
                          if (enteredNumber == admin) {
                            // Admin login
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            await prefs.setString('userType', 'admin');
                            
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const AdminScreen()),
                            );
                          } else {
                            // User login
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            await prefs.setString('userType', 'user');
                            await prefs.setString('phoneNumber', phoneController.text);
                            
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          }
                        } else {
                          // If validation fails, display errors
                          print('Validation Failed');
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04), // 4% of screen height

              // Login Button
            ],
          ),
        ),
      ),
    );
  }

  // Update the country code container method
  Widget _buildCountryCodeContainer() {
    return Container(
      height: _inputHeight, // Using consistent height
      padding: const EdgeInsets.symmetric(horizontal: 12), // Smaller padding
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
            color: Colors.grey[300]!), // Added border to match TextField
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Added to keep container compact
        children: [
          Image.asset(
            'assets/flag.png',
            width: _flagSize,
            height: _flagSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6), // Smaller spacing
          const Text(
            '+92',
            style: TextStyle(fontSize: 15), // Slightly smaller text
          ),
        ],
      ),
    );
  }

  // Update the phone number field method
  Widget _buildPhoneNumberField() {
    return Expanded(
      child: SizedBox(
        height: _inputHeight,
        child: TextFormField(
          controller: phoneController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.phone,
          style: const TextStyle(fontSize: 15),
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 11) {
              return '';
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: true, // Makes the field compact
            errorStyle: const TextStyle(
              height: 0,
              fontSize: 0,
            ),
            border: _buildInputBorder(Colors.grey[300]!),
            enabledBorder: _buildInputBorder(phoneController.text.length == 11
                ? Colors.green
                : Colors.grey[300]!),
            focusedBorder: _buildInputBorder(
                phoneController.text.length == 11 ? Colors.green : Colors.blue),
            errorBorder: _buildInputBorder(Colors.red),
            focusedErrorBorder: _buildInputBorder(Colors.red),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14, // Added consistent vertical padding
            ),
            filled: true,
            fillColor: Colors.grey[100],
            hintText: '0300 123 4567',
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          onChanged: (value) => setState(() {}),
        ),
      ),
    );
  }

  InputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
