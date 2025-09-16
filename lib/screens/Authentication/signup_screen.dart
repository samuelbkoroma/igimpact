import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/components/FormButton.dart';
import 'package:igniteimpact/components/TextFormField.dart';
import 'package:igniteimpact/theme/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // To track input field color validation
  bool _isEmailValid = true;
  bool _isNameValid = true;
  bool _isPasswordValid = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  void _signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      _isNameValid = name.isNotEmpty;
      _isEmailValid = email.contains('@') && email.contains('.');
      _isPasswordValid = password.length >= 6;
    });

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showCustomSnackbar("All fields are required!", Icons.error, Colors.red);
      return;
    }

    if (!_isPasswordValid) {
      showCustomSnackbar(
          "Password must be at least 6 characters!", Icons.error, Colors.red);
      return;
    }

    if (!_isEmailValid) {
      showCustomSnackbar(
          "Please enter a valid email address!", Icons.error, Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update the user profile with the name
      await userCredential.user?.updateDisplayName(name);

      // Optional: Refresh user data to ensure name is available immediately
      await userCredential.user?.reload();

      showCustomSnackbar(
          "Account created successfully!", Icons.check, Colors.green);

      // Navigate to main screen after successful signup
      Navigator.pushReplacementNamed(context, '/bottomappbar');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showCustomSnackbar("Email is already in use!", Icons.error, Colors.red);
      } else if (e.code == 'weak-password') {
        showCustomSnackbar(
            "Weak password! Try a stronger one.", Icons.error, Colors.red);
      } else {
        showCustomSnackbar(
            "Signup failed! ${e.message}", Icons.error, Colors.red);
      }
    } catch (e) {
      showCustomSnackbar(
          "An unexpected error occurred!", Icons.error, Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            const SizedBox(height: 120),
            Center(
              child: Text(
                'Create Account',
                style: GoogleFonts.poppins(
                  color: mainBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                'Create an account so you can explore all the\nexisting jobs',
                style: GoogleFonts.poppins(
                  color: mainBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  UniveralFormField(
                    borderColor: _isNameValid ? mainGrey : Colors.red,
                    onChanged: (value) {
                      setState(() {
                        _isNameValid = value.isNotEmpty;
                      });
                    },
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 20),
                  UniveralFormField(
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid =
                            value.contains('@') && value.contains('.');
                      });
                    },
                    borderColor: _isEmailValid ? mainGrey : Colors.red,
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.email)),
                  ),
                  const SizedBox(height: 20),
                  UniveralFormField(
                    borderColor: _isPasswordValid ? mainGrey : Colors.red,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = value.length >= 6;
                      });
                    },
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : FormButton(
                          onPressed: _signUp,
                          btnText: 'Sign Up',
                        ),
                  const SizedBox(height: 25),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Already have an account?',
                        style: GoogleFonts.poppins(
                          color: mainBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: Text(
                      'Or continue with',
                      style: GoogleFonts.poppins(
                        color: mainBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialMediaButton('assets/google.png'),
                        const SizedBox(width: 10),
                        socialMediaButton('assets/facebook.png'),
                        const SizedBox(width: 10),
                        socialMediaButton('assets/facebook.png'),
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

  Widget socialMediaButton(String assetPath, {Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: mainGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
