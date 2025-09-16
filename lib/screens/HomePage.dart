import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igniteimpact/components/JobCard.dart';
import 'package:igniteimpact/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _userName = "User";

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.displayName != null) {
      setState(() {
        _userName = currentUser.displayName!;
      });
    }
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning 👋";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening 👋";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainGrey,
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('internships').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text("No job postings yet."));
            }

            final firstDoc = docs.first.data();
            final remainingDocs = docs.skip(1).toList();

            return Column(
              children: [
                // Header with first job in a stack
                SizedBox(
                  height: 400,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        color: mainBlue,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 70),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/profile.png"),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _userName,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              color: bgWhite,
                                            ),
                                          ),
                                          Text(
                                            "Data Science",
                                            style: GoogleFonts.poppins(
                                                color: bgWhite),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.notifications,
                                        size: 30, color: bgWhite),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/notificationpage");
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Text(
                                _getGreetingMessage(),
                                style: GoogleFonts.poppins(color: bgWhite),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Find your dream job here",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: bgWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 230,
                        left: 16,
                        right: 16,
                        child: JobCard(
                          docId: snapshot.data!.docs.first.id,
                          myImage: Image.network(
                            firstDoc['logoUrl'] ??
                                'https://via.placeholder.com/40',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/spotify.png',
                                width: 40,
                                height: 40,
                              );
                            },
                          ),
                          jobName: firstDoc['title'] ?? 'No Title',
                          companyName: firstDoc['company'] ?? 'No Company',
                          companyLocation:
                              firstDoc['location'] ?? 'No Location',
                          timeStamp: (firstDoc['postedAt'] as Timestamp?)
                                  ?.toDate()
                                  .toString() ??
                              DateTime.now().toString(),
                          level: firstDoc['level'] ?? 'No Level',
                          mode: firstDoc['mode'] ?? 'No Mode',
                          description: firstDoc['description'] ??
                              'No description available', // Add this line
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Remaining jobs
                ...remainingDocs.map((doc) {
                  final data = doc.data();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: JobCard(
                      docId: doc.id,
                      myImage: Image.network(
                        data['logoUrl'] ?? 'https://via.placeholder.com/40',
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/spotify.png',
                            width: 40,
                            height: 40,
                          );
                        },
                      ),
                      jobName: data['title'] ?? 'No Title',
                      companyName: data['company'] ?? 'No Company',
                      companyLocation: data['location'] ?? 'No Location',
                      timeStamp: (data['postedAt'] as Timestamp?)
                              ?.toDate()
                              .toString() ??
                          DateTime.now().toString(),
                      level: data['level'] ?? 'No Level',
                      mode: data['mode'] ?? 'No Mode',
                      description: data['description'] ??
                          'No description available', // Add this line
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
