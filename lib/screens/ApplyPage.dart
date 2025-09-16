import 'package:expandable_text/expandable_text.dart' show ExpandableText;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/components/BookMarkIcon.dart';
import 'package:igniteimpact/theme/colors.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: 16.0), // Adjust spacing from bottom
        child: SizedBox(
          width: 250,
          height: 60,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text(
              "Apply",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: mainWhite,
              ),
            ),
            backgroundColor: mainBlue,
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // Centered at bottom
      backgroundColor: mainGrey,
      appBar: AppBar(
        backgroundColor: mainGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          BookmarkIcon(
            jobId: args['docId'] ?? '',
            jobData: {
              'title': args['jobName'],
              'company': args['companyName'],
              'location': args['companyLocation'],
              'mode': args['mode'],
              'level': args['level'],
              'description': args['description'],
              'postedAt': args['timeStamp'],
              'imageUrl': args['imageUrl']?.toString(),
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: args['imageUrl'] as Image? ??
                    Image.asset(
                      'assets/spotify.png',
                      width: 40,
                      height: 40,
                    ),
              ),
              SizedBox(height: 5),
              Text(
                args['jobName'] ?? "No Title",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                args['companyName'] ?? "No Company", // Use passed company name
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Posted ${args['timeStamp'] ?? 'Recently'}", // Use passed timestamp
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  //1 first column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apply Before",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            letterSpacing: 1.7),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "20th August 2021",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF181A1F,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Salary Range",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            letterSpacing: 1.7),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "100k - 120k/yearly",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF181A1F,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  //2 second column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Type",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            letterSpacing: 1.7),
                      ),
                      SizedBox(height: 5),
                      Text(
                        args['mode'] ?? "No Mode", // Use passed mode
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF181A1F),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Location",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          letterSpacing: 1.7,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        args['companyLocation'] ??
                            "No Location", // Fixed parameter name
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF181A1F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                "Job Description",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  letterSpacing: 1.7,
                ),
              ),
              SizedBox(height: 10),
              ExpandableText(
                args['description']?.toString() ?? "No description available",
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 8,
                linkColor: mainBlue,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF181A1F),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              // Text(
              //   "Roles and Responsibilities",
              //   style: GoogleFonts.poppins(
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.grey[800],
              //       letterSpacing: 1.7),
              // ),
              SizedBox(height: 10),
              // ExpandableText(
              //   "Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye?We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded Can you bring creative human-centered ideas to life and make great things happen beyond what meets the eye?We believe in teamwork, fun, complex projects, diverse perspectives, and simple solutions. How about you? We're looking for a like-minded",
              //   expandText: 'show more',
              //   collapseText: 'show less',
              //   maxLines: 8,
              //   linkColor: mainBlue,
              //   style: GoogleFonts.poppins(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //     color: Color(
              //       0xFF181A1F,
              //     ),
              //   ),
              // ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
