import 'package:demo_app/screens/contact_screen.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/screens/profile_screen.dart';
import 'package:demo_app/screens/tanker_service_screen.dart';
import 'package:demo_app/widgets/custom_container.dart';
import 'package:demo_app/widgets/service_title.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String userMobile = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? '';
      userMobile = prefs.getString('mobile') ?? '';
    });
  }

  void _handleLogout(BuildContext context)  {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs
    //     .clear(); // or specifically: await prefs.setBool('isLoggedIn', false);

    if (!context.mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
   
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              height: screenHeight * 0.35,
              width: screenWidth,
              gradientColors: const [Color(0xFF0079C2), Colors.lightBlue],
              centerText: "M & M Brothers Online Tanker Service",
              textStyle: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userName.isNotEmpty || userMobile.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userMobile,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ServiceTile(
                    icon: Icons.local_shipping,
                    title: 'Online Tanker Service',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TankerServiceScreen()));
                    },
                  ),
                  ServiceTile(
                    icon: Icons.person,
                    title: 'Profile Information',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                      _loadUserData();
                    },
                  ),
                  ServiceTile(
                    icon: Icons.help_outline,
                    title: 'User Guide / FAQs /\nTerms & Conditions',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromARGB(255, 41, 41, 41),
                          margin: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 50),
                          content: Text('Coming Soon'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  ServiceTile(
                    icon: Icons.phone,
                    title: 'Contact Us',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactScreen()));
                    },
                  ),
                  ServiceTile(
                    icon: Icons.report_problem_outlined,
                    title: 'Complaint Management\nSystem',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromARGB(255, 41, 41, 41),
                          margin: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 50),
                          content: Text('Coming Soon'),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  ServiceTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
