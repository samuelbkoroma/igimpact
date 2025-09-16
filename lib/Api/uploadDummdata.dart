import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadDummyData extends StatelessWidget {
  const UploadDummyData({super.key});

  void uploadSampleJob(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('internships').add({
        "title": "Frontend Developer",
        "company": "Google",
        "location": "Mountain View, USA",
        "description": "We're looking for a passionate frontend developer...",
        "level": "Senior Level",
        "type": "Full Time",
        "mode": "Remote",
        "postedAt": Timestamp.now(),
        "logoUrl": "https://yourcdn.com/google-logo.png",
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Job uploaded successfully!")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading job: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Sample Data'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => uploadSampleJob(context),
          child: const Text('Upload Sample Job'),
        ),
      ),
    );
  }
}
