import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/theme/colors.dart';

class CompetitionDetails extends StatelessWidget {
  final String title;
  final String organization;
  final String prize;
  final String deadline;
  final String eligibility;
  final String description;

  const CompetitionDetails({
    Key? key,
    required this.title,
    required this.organization,
    required this.prize,
    required this.deadline,
    required this.eligibility,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      appBar: AppBar(
        backgroundColor: mainBlue,
        elevation: 0,
        title: Text(
          'Competition Details',
          style: GoogleFonts.poppins(
            color: mainWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: mainWhite),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: mainWhite),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Competition saved!',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: mainBlue,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with competition info
            Container(
              width: double.infinity,
              color: mainWhite,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: mainBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    organization,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildInfoCard(
                        Icons.attach_money,
                        'Prize',
                        prize,
                      ),
                      const SizedBox(width: 16),
                      _buildInfoCard(
                        Icons.calendar_today,
                        'Deadline',
                        deadline,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    Icons.people,
                    'Eligibility',
                    eligibility,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Description section
            Container(
              width: double.infinity,
              color: mainWhite,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainBlack,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Requirements section
            Container(
              width: double.infinity,
              color: mainWhite,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Requirements',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainBlack,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRequirementItem('Business plan or pitch deck'),
                  _buildRequirementItem('Proof of concept or prototype'),
                  _buildRequirementItem('Team information'),
                  _buildRequirementItem('Market analysis'),
                ],
              ),
            ),

            const SizedBox(height: 80), // Space for the button
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: mainWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Show application confirmation
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Apply for Competition',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Are you sure you want to apply for this competition?',
                  style: GoogleFonts.poppins(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(color: Colors.grey[700]),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Application submitted successfully!',
                            style: GoogleFonts.poppins(),
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainBlue,
                    ),
                    child: Text(
                      'Apply',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: mainBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Apply Now',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: mainWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value,
      {bool isFullWidth = false}) {
    return Expanded(
      flex: isFullWidth ? 2 : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mainBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: mainBlue.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: mainBlue),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: mainBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: mainBlue,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
