import 'package:flutter/material.dart';
import 'student_page.dart'; // make sure this file exists

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Arrow
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // goes back to landing/student page
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Login Heading
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Email TextField
              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password TextField
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      print("Navigate to Sign Up page");
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // OR Divider
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),

              const SizedBox(height: 20),

              // Sign in with Google
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("Google Sign In");
                  },
                  icon: Image.asset(
                    "asset/fonts/images/GoogleLogo.jpg", // <-- make sure this exists
                    height: 24,
                  ),
                  label: const Text("Sign in with Google"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Sign in with Facebook
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("Facebook Sign In");
                  },
                  icon: Image.asset(
                    "asset/fonts/images/facebookLogo.jpg", // <-- make sure this exists
                    height: 24,
                  ),
                  label: const Text("Sign in with Facebook"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
