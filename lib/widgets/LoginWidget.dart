import 'package:dbkliknew/screens/CustomBottomBar.dart';
import 'package:dbkliknew/screens/HomePage.dart';
import 'package:dbkliknew/screens/RegisterPage.dart';
import 'package:dbkliknew/utils/StorageUtils.dart';
import 'package:flutter/material.dart';
import 'package:dbkliknew/widgets/CustomComponents/CustomBottom.dart';
import 'package:dbkliknew/widgets/CustomComponents/TextInputField.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService(); // Create an instance

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Welcome to DB Klik!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextInputField(
            label: 'Email', icon: Icons.email, controller: emailController),
        const SizedBox(height: 16),
        TextInputField(
            label: 'Password',
            icon: Icons.lock,
            isPassword: true,
            controller: passwordController),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Login',
          width: 380,
          height: 50,
          onPressed: () async {
            // Access the text values from the controllers
            String? email = emailController.text;
            String? password = passwordController.text;

            // Print the email and password for debugging
            print('Email: $email');
            print('Password: $password');

            // Use the instance to call the login method
            String? token = await apiService.login(email, password);

            // Handle the token or error as needed
            if (token != null) {
              // Token received, save it securely
              await StorageUtils.saveTokenToStorage(token);

              // Proceed with your logic
              print('Login successful! Token: $token');

              // Replace CustomButtonBar() with the actual homepage widget
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomBar(),
                ),
              );
            } else {
              // Handle login failure
              print('Login failed!');

              // Show a Snackbar with the error message and a sad emoticon
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login failed ! Check your email and password. '),
                      // Sad emoticon
                      Text('😢', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            // Navigate to the registration page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          child: Text("Don't have an account? Register now"),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "By logging in, you agree to our ",
              style: TextStyle(fontSize: 12),
            ),
            InkWell(
              onTap: () {
                // Add your logic to open the Privacy Policy link
                // Example: launchURL('your_privacy_policy_link');
              },
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
