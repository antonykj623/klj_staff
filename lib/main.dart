import 'package:flutter/material.dart';
import 'package:kljcafe_staff_new/prefdata/dbhelper.dart';
import 'package:kljcafe_staff_new/prefdata/sharedpref.dart';
import 'package:kljcafe_staff_new/web/api_credentials.dart';
import 'package:kljcafe_staff_new/widgets/home.dart';
import 'package:kljcafe_staff_new/widgets/login.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences early (recommended)
   // Make sure this method exists in your SharedPref class
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLJ Cafe Staff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Optional: modern look
      ),
      home: const MyHomePage(title: 'KLJ Cafe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Start checking login status
  }

  Future<void> _checkLoginStatus() async {
    // Optional: keep splash visible for at least 2 seconds for better UX
    await Future.delayed(const Duration(seconds: 2));

    // Get token from SharedPreferences
    String? token = await SharedPref.getString(APICredentials.apptoken);

    // Safety check: widget still mounted?
    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // User is logged in → go to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      // No token or empty → go to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage("assets/kljcafeemployee.png"),
          width: 150,
          height: 150,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}