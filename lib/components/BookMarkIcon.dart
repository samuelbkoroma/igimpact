import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkIcon extends StatefulWidget {
  final String jobId;
  final Map<String, dynamic> jobData;

  const BookmarkIcon({
    super.key,
    required this.jobId,
    required this.jobData,
  });

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool _isSaved = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('savedJobs')
          .doc(widget.jobId)
          .get();

      setState(() {
        _isSaved = doc.exists;
      });
    }
  }

  Future<void> _toggleSave() async {
    final user = _auth.currentUser;
    if (user != null) {
      final savedJobRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('savedJobs')
          .doc(widget.jobId);

      setState(() {
        _isSaved = !_isSaved;
      });

      if (_isSaved) {
        // Save the job
        await savedJobRef.set(widget.jobData);
      } else {
        // Remove the job
        await savedJobRef.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: _isSaved ? Colors.blue : Colors.grey,
      ),
      onPressed: _toggleSave,
    );
  }
}
