import 'package:blood_donators_managment_app/view/add_donor.dart';
import 'package:blood_donators_managment_app/view/home.dart';
import 'package:blood_donators_managment_app/view/update_donor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donor App With Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: false,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/AddDonor': (context) => const AddDonor(),
        '/UpdateDonor': (context) => const UpdateDonor(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
