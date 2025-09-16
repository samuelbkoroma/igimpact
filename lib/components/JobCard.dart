import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/components/BookmarkIcon.dart';
import 'package:igniteimpact/theme/colors.dart';
import 'dart:developer' as developer;

class JobCard extends StatefulWidget {
  final Image myImage;
  final String jobName;
  final String companyName;
  final String companyLocation;
  final String docId;
  final String timeStamp;
  final String mode;
  final String level;
  final String description;

  const JobCard({
    super.key,
    required this.myImage,
    required this.jobName,
    required this.companyName,
    required this.companyLocation,
    required this.docId,
    required this.timeStamp,
    required this.mode,
    required this.level,
    this.description = "",
  });

  String _getRelativeTime(String timestamp) {
    developer.log('Parsing timestamp: $timestamp');
    try {
      final DateTime postTime = DateTime.parse(timestamp);
      developer.log('Successfully parsed date: $postTime');
      final Duration difference = DateTime.now().difference(postTime);

      if (difference.inSeconds < 60) {
        return 'Just posted';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${difference.inDays ~/ 7}w ago';
      }
    } catch (e) {
      developer.log('Date parsing error', error: e);
      return 'Recently';
    }
  }

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  final bool _iconColor = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/applypage',
          arguments: {
            'jobName': widget.jobName,
            'companyName': widget.companyName,
            'companyLocation': widget.companyLocation,
            'timeStamp': widget.timeStamp,
            'mode': widget.mode,
            'level': widget.level,
            'description': widget.description,
            'imageUrl': widget.myImage,
          },
        );
      },
      child: Container(
        width: 320,
        height: 176,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        widget.myImage,
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.jobName,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              widget.companyName,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    BookmarkIcon(
                      jobId: widget.docId,
                      jobData: {
                        'title': widget.jobName,
                        'company': widget.companyName,
                        'location': widget.companyLocation,
                        'mode': widget.mode,
                        'level': widget.level,
                        'description': widget.description,
                        'postedAt': widget.timeStamp,
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 24,
                      decoration: BoxDecoration(
                        color: widget.level.toLowerCase() == 'internship'
                            ? Colors.green[100]
                            : widget.level.toLowerCase() == 'volunteer'
                                ? Colors.orange[100]
                                : Colors.blue[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          widget.level,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: widget.level.toLowerCase() == 'internship'
                                ? Colors.green[800]
                                : widget.level.toLowerCase() == 'volunteer'
                                    ? Colors.orange[800]
                                    : Colors.blue[800],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 62,
                      height: 24,
                      decoration: BoxDecoration(
                        color: mainGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          widget.mode,
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 62,
                      height: 24,
                      decoration: BoxDecoration(
                        color: mainGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "Remote",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.companyLocation,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget._getRelativeTime(widget.timeStamp),
                      style: GoogleFonts.poppins(color: Colors.blueGrey),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
