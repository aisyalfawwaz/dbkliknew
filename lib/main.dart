import 'package:dbkliknew/screens/CustomBottomBar.dart';
import 'package:dbkliknew/screens/LoginScreen.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:dbkliknew/utils/StorageUtils.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiService.setBaseUrl('http://192.168.100.7:8000');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DB Klik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        // Check for an existing token
        future: StorageUtils.getTokenFromStorage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              // Token exists, navigate to the main screen
              return const CustomBottomBar();
            } else {
              // Token does not exist, show the login screen
              return const LoginScreen();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
