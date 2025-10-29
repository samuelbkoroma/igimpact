import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/theme/colors.dart';
import 'package:igniteimpact/screens/CompetitionDetails.dart';

class Entrepreneurship extends StatefulWidget {
  const Entrepreneurship({super.key});

  @override
  State<Entrepreneurship> createState() => _EntrepreneurshipState();
}

class _EntrepreneurshipState extends State<Entrepreneurship> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      appBar: AppBar(
        backgroundColor: mainBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: mainWhite, size: 28),
          onPressed: () {},
        ),
        title: Text(
          'Pitch Competitions',
          style: GoogleFonts.poppins(
            color: mainWhite,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: mainWhite, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: mainWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search competitions',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(Icons.search, color: mainBlue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),

            // Filter Chips
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 10),
                  _buildFilterChip('Student'),
                  const SizedBox(width: 10),
                  _buildFilterChip('Recent Graduate'),
                  const SizedBox(width: 10),
                  _buildFilterChip('Tech'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Competition Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  _buildCompetitionCard(
                    title: 'Freetown Innovates Challenge',
                    organization: 'Sierra Leone Tech Hub',
                    prize: 'SLL 10,000,000',
                    deadline: '30 Nov 2024',
                    eligibility: 'Eligibility: Students & Recent Graduates',
                    iconColor: mainBlue.withOpacity(0.8),
                    onTap: () => _navigateToDetails(
                      'Freetown Innovates Challenge',
                      'Sierra Leone Tech Hub',
                      'SLL 10,000,000',
                      '30 Nov 2024',
                      'Students & Recent Graduates',
                      'A pitch competition for innovative solutions to local challenges in Freetown. Winners receive funding and mentorship to develop their ideas into viable businesses.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCompetitionCard(
                    title: 'African Innovation Prize',
                    organization: 'African Development Bank',
                    prize: '\$50,000',
                    deadline: '15 Dec 2024',
                    eligibility: 'Eligibility: All African Entrepreneurs',
                    iconColor: mainBlue.withOpacity(0.8),
                    onTap: () => _navigateToDetails(
                      'African Innovation Prize',
                      'African Development Bank',
                      '\$50,000',
                      '15 Dec 2024',
                      'All African Entrepreneurs',
                      'The African Innovation Prize seeks to identify and support innovative solutions to Africa\'s most pressing challenges. Winners receive funding, mentorship, and access to a network of investors.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCompetitionCard(
                    title: 'Youth Entrepreneurship Summit',
                    organization: 'Global Youth Network',
                    prize: '\$25,000 + Mentorship',
                    deadline: '10 Jan 2025',
                    eligibility: 'Eligibility: Under 30 years',
                    iconColor: mainBlue.withOpacity(0.8),
                    onTap: () => _navigateToDetails(
                      'Youth Entrepreneurship Summit',
                      'Global Youth Network',
                      '\$25,000 + Mentorship',
                      '10 Jan 2025',
                      'Under 30 years',
                      'A global competition for young entrepreneurs with innovative ideas. The summit brings together young entrepreneurs from around the world to pitch their ideas and connect with investors and mentors.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCompetitionCard(
                    title: 'Green Energy Solutions',
                    organization: 'Ministry of Energy',
                    prize: '\$30,000',
                    deadline: '28 Feb 2025',
                    eligibility: 'Eligibility: Open to All',
                    iconColor: mainBlue.withOpacity(0.8),
                    onTap: () => _navigateToDetails(
                      'Green Energy Solutions',
                      'Ministry of Energy',
                      '\$30,000',
                      '28 Feb 2025',
                      'Open to All',
                      'A competition seeking innovative solutions in renewable energy and sustainability. Winners will receive funding to develop and implement their green energy solutions.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCompetitionCard(
                    title: 'Digital Innovation Challenge',
                    organization: 'Tech4All Foundation',
                    prize: '\$20,000',
                    deadline: '5 Mar 2025',
                    eligibility: 'Eligibility: All Youth',
                    iconColor: mainBlue.withOpacity(0.8),
                    onTap: () => _navigateToDetails(
                      'Digital Innovation Challenge',
                      'Tech4All Foundation',
                      '\$20,000',
                      '5 Mar 2025',
                      'All Youth',
                      'A competition focused on digital solutions that address social challenges. Participants will pitch their ideas to a panel of tech industry experts.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? mainBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? mainBlue : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: mainBlue.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCompetitionCard({
    required String title,
    required String organization,
    required String prize,
    required String deadline,
    required String eligibility,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.lightbulb_outline,
                      color: iconColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          organization,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: mainBlue,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoItem(Icons.attach_money, prize),
                  const SizedBox(width: 16),
                  _buildInfoItem(Icons.calendar_today, deadline),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                eligibility,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: mainBlue,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _navigateToDetails(
    String title,
    String organization,
    String prize,
    String deadline,
    String eligibility,
    String description,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompetitionDetails(
          title: title,
          organization: organization,
          prize: prize,
          deadline: deadline,
          eligibility: eligibility,
          description: description,
        ),
      ),
    );
  }
}
