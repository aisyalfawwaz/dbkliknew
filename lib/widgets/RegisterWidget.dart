import 'package:dbkliknew/screens/LoginScreen.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:dbkliknew/utils/StorageUtils.dart';
import 'package:dbkliknew/widgets/CustomComponents/CustomBottom.dart';
import 'package:dbkliknew/widgets/CustomComponents/TextInputField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterWidget extends StatelessWidget {
  // Remove the 'const' keyword from the constructor
  RegisterWidget({Key? key}) : super(key: key);

  // Declare controllers without 'const'
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Create Your Account',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextInputField(
              label: 'Name', icon: Icons.person, controller: nameController),
          const SizedBox(height: 16),
          TextInputField(
              label: 'Email', icon: Icons.email, controller: emailController),
          const SizedBox(height: 16),
          TextInputField(
              label: 'Telephone',
              icon: Icons.phone,
              controller: phoneController),
          const SizedBox(height: 16),
          TextInputField(
              label: 'Password',
              icon: Icons.lock,
              isPassword: true,
              controller: passwordController),
          const SizedBox(height: 16),
          TextInputField(
            label: 'Confirm Password',
            icon: Icons.lock,
            isPassword: true,
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Register',
            width: 380,
            height: 50,
            onPressed: () async {
              // Access the text values from the controllers
              String name = nameController.text;
              String email = emailController.text;
              String phone = phoneController.text;
              String password = passwordController.text;
              String confirmPassword = confirmPasswordController.text;

              // Validate the input fields (you can add your validation logic here)

              // Check if passwords match
              if (password != confirmPassword) {
                // Display an error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Passwords do not match'),
                    duration: Duration(seconds: 3),
                  ),
                );
                return;
              }

              // Perform the registration API call
              String? token =
                  await ApiService().registerUser(name, email, phone, password);

              // Handle the token or error as needed
              if (token != null) {
                // Token received, save it securely
                await StorageUtils.saveTokenToStorage(token);

                // Proceed with your logic

                // Navigate to the login page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              } else {
                // Handle registration failure
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Registration failed. User already exists.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              // Navigate to the login page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: Text(
              "Have an account? Login now",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
