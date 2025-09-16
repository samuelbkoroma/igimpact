import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/components/JobCard.dart';
import 'package:igniteimpact/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedJob extends StatefulWidget {
  const SavedJob({super.key});

  @override
  State<SavedJob> createState() => _SavedJobState();
}

class _SavedJobState extends State<SavedJob> {
  final ScrollController _scrollController = ScrollController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      appBar: AppBar(
        backgroundColor: bgWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Saved Jobs',
          style: GoogleFonts.poppins(
            color: mainBlack,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: user == null
          ? Center(
              child: Text(
                'Please login to view saved jobs',
                style: GoogleFonts.poppins(),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('savedJobs')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No saved jobs yet',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return JobCard(
                      docId: doc.id,
                      myImage: Image.network(
                        data['imageUrl'] ?? 'https://via.placeholder.com/40',
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
                      timeStamp: data['postedAt'] ?? DateTime.now().toString(),
                      mode: data['mode'] ?? 'No Mode',
                      level: data['level'] ?? 'No Level',
                      description: data['description'] ?? '',
                    );
                  },
                );
              },
            ),
    );
  }
}
