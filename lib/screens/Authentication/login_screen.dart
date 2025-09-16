import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/components/FormButton.dart';
import 'package:igniteimpact/components/TextFormField.dart';
import 'package:igniteimpact/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _obscurePassword = true; // Add this state variable
  bool isSigningIn = false;

  //to track input field color validation
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

//normal login function
  void login() async {
    String email = emailController.text.trim(); // Add this line
    String password = passwordController.text.trim();

    setState(() {
      _isEmailValid = email.contains('@') && email.contains('.');
      _isPasswordValid = password.length >= 6;
    });

    if (email.isEmpty || password.isEmpty) {
      showCustomSnackbar("All fields are required!", Icons.error, Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      showCustomSnackbar("Login successfull", Icons.check, Colors.green);

      // Navigate to login screen after successful signup
      Navigator.pushReplacementNamed(context, '/bottomappbar');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomSnackbar(
            "No user found with this email", Icons.error, Colors.red);
      } else if (e.code == 'wrong-password') {
        showCustomSnackbar("Incorrect Password", Icons.error, Colors.red);
      } else if (e.code == 'invalid-email') {
        showCustomSnackbar("Invalid email format", Icons.error, Colors.red);
      } else if (e.code == 'user-disabled') {
        showCustomSnackbar(
            "This account has been disabled", Icons.error, Colors.red);
      } else if (e.code == 'network-request-failed') {
        showCustomSnackbar(
            "Please check your internet connection", Icons.error, Colors.red);
      } else {
        showCustomSnackbar(
            "Login failed! ${e.message}", Icons.error, Colors.red);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //snackbar function

  void showCustomSnackbar(String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height -
              100, // Adjust this value as needed
          left: 20,
          right: 20,
        ),
        content: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Center(
              child: Text(
                'Login here',
                style: GoogleFonts.poppins(
                  color: mainBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                'Welcome back you\'ve\n been missed',
                style: GoogleFonts.poppins(
                  color: mainBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // Email
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  UniveralFormField(
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid =
                            value.contains('@') && value.contains('.');
                      });
                    },
                    borderColor: _isEmailValid ? mainGrey : Colors.red,
                    hintText: 'Email',
                    obscureText: false,
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.email)),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  UniveralFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: _obscurePassword,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = value.length >= 6;
                      });
                    },
                    borderColor: _isPasswordValid ? mainGrey : Colors.red,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotpassword');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                              color: mainBlueDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  _isLoading
                      ? const CircularProgressIndicator()
                      : FormButton(
                          onPressed: login,
                          btnText: 'Login',
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Create new account',
                        style: GoogleFonts.poppins(
                            color: mainBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),

                  // Social Media
                  Center(
                    child: Text(
                      'Or continue with',
                      style: GoogleFonts.poppins(
                          color: mainBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: mainGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Image.asset(
                                'assets/google.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: mainGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/facebook.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: mainGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/facebook.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
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
