import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/components/BottomAppBar.dart';
import 'package:igniteimpact/components/JobCard.dart';
import 'package:igniteimpact/theme/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // List of job data that will be used to automatically generate Jobcard widgets.
  final List<Map<String, String>> jobs = [
    {
      'asset': 'assets/spotify.png',
      'jobName': 'Data Scientist',
      'companyName': 'Spotify',
      'companyLocation': 'Sierra Leone, Freetown',
    },
    {
      'asset': 'assets/tiktok.png',
      'jobName': 'Software Engineer',
      'companyName': 'TikTok',
      'companyLocation': 'Beijing, China',
    },
    {
      'asset': 'assets/spotify.png',
      'jobName': 'UI/UX Designer',
      'companyName': 'Spotify',
      'companyLocation': 'New York, USA',
    },
    {
      'asset': 'assets/spotify.png',
      'jobName': 'Data Scientist',
      'companyName': 'Spotify',
      'companyLocation': 'Sierra Leone, Freetown',
    },
    {
      'asset': 'assets/tiktok.png',
      'jobName': 'Software Engineer',
      'companyName': 'TikTok',
      'companyLocation': 'Beijing, China',
    },
    {
      'asset': 'assets/spotify.png',
      'jobName': 'UI/UX Designer',
      'companyName': 'Spotify',
      'companyLocation': 'New York, USA',
    },
    // Add more jobs here as needed.
  ];

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
              MaterialPageRoute(builder: (context) => BottomAppbar()),
              (Route<dynamic> route) =>
                  false, // This predicate removes all previous routes.
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display number of jobs found using the list length.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${jobs.length} JOBS FOUND',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'All Relevance',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: mainBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Automatically generate Jobcards for each job entry in the list.
              Column(
                children: jobs.map((job) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: JobCard(
                        myImage: Image.asset(job['asset']!),
                        jobName: job['jobName']!,
                        companyName: job['companyName']!,
                        companyLocation: job['companyLocation']!,
                        docId: 'search_${jobs.indexOf(job)}',
                        timeStamp: DateTime.now().toString(),
                        mode: 'Full-time',
                        level: 'Entry Level'),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
