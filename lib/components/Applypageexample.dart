import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:igniteimpact/components/BookMarkIcon.dart';
import 'package:igniteimpact/screens/HomePage.dart' show Homepage;
import 'package:igniteimpact/theme/colors.dart' show mainBlue, mainGrey;

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGrey,
      appBar: AppBar(
        backgroundColor: mainGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
              (Route<dynamic> route) =>
                  false, // This predicate removes all previous routes.
            );
          },
        ),
        actions: [
          BookmarkIcon(
            jobId: '',
            jobData: {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "UI/UX Designer",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/badoo.png",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Badoo Inc.",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        "London, UK",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 57,
                            height: 18,
                            decoration: BoxDecoration(
                                color: mainBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Full Time",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 57,
                            height: 18,
                            decoration: BoxDecoration(
                                color: mainBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Intern",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: mainBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("100+ applicants"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: mainBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Remote 📍"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: mainBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("15k to 35k"),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              // Job Description
              Text(
                "About The Job",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Badoo Inc, is a forward-thinking software development firm committed to enhancing the capabilities of small and medium-sized businesses. As we look towards steady expansion, we're keen to onboard a UI/UX designer who also possesses strong graphic design skills.",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Colors.grey[900]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Responsibilities",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Badoo Inc, is a forward-thinking software development firm committed to enhancing the capabilities of small and medium-sized businesses. As we look towards steady expansion, we're keen to onboard a UI/UX designer who also possesses strong graphic design skills.",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    color: Colors.grey[900]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
