import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:igniteimpact/theme/colors.dart";

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                "assets/workfromhome.png",
                height: 300,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                "Discover the best\n  your dream job",
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF1F41BB)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Explore all the existing job roles based on your\n interest and study major",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        alignment: Alignment.center,
                        width: 160,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0XFF1F41BB),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: Card(
                      elevation: 0,
                      child: Container(
                        alignment: Alignment.center,
                        width: 160,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Register",
                          style: GoogleFonts.poppins(
                              color: Color(0XFF000000),
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
