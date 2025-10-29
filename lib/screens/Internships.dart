import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igniteimpact/components/JobCard.dart';
import 'package:igniteimpact/theme/colors.dart';
import 'package:igniteimpact/components/BookMarkIcon.dart';

class Internships extends StatefulWidget {
  const Internships({super.key});

  @override
  State<Internships> createState() => _InternshipsState();
}

class _InternshipsState extends State<Internships> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = [
    'All',
    'Tech',
    'Finance',
    'Healthcare',
    'Education'
  ];
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchSuggestions = [];
  List<DocumentSnapshot> _allDocuments = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchSuggestions = [];
      });
      return;
    }

    final searchTerm = _searchController.text.toLowerCase();
    final suggestions = _allDocuments
        .where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final title = data['title']?.toString().toLowerCase() ?? '';
          return title.contains(searchTerm);
        })
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data['title']?.toString() ?? '';
        })
        .toSet() // Remove duplicates
        .toList();

    setState(() {
      _searchSuggestions = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      appBar: AppBar(
        backgroundColor: bgWhite,
        elevation: 0,
        title: Text(
          'Find Your Next Opportunity',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: mainBlack,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: mainBlack),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar with Suggestions
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search internships, companies...',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                if (_searchSuggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchSuggestions[index]),
                          onTap: () {
                            setState(() {
                              _searchController.text =
                                  _searchSuggestions[index];
                              _searchSuggestions = [];
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: _filterOptions.map((option) {
                final isSelected = _selectedFilter == option;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = option;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? mainBlue : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // All Internships Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'All Internships',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mainBlack,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Job Listings
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('internships')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      _buildInternshipCard(
                        title: 'Finance Intern',
                        company: 'Freetown Bank',
                        location: 'Freetown',
                        deadline: '3 weeks',
                        logoColor: Colors.blue.shade100,
                      ),
                      _buildInternshipCard(
                        title: 'Project Management Intern',
                        company: 'Salone Connect',
                        location: 'Kenema',
                        deadline: '1 month',
                        logoColor: Colors.green.shade100,
                      ),
                      _buildInternshipCard(
                        title: 'Public Health Intern',
                        company: 'Wellness SL',
                        location: 'Makeni',
                        deadline: '5 days',
                        logoColor: Colors.amber.shade100,
                      ),
                    ],
                  );
                }

                // Store all documents for search suggestions
                _allDocuments = snapshot.data!.docs;

                // Apply filters
                List<DocumentSnapshot> filteredDocs =
                    snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final matchesFilter = _selectedFilter == 'All' ||
                      data['level']?.toString().toLowerCase() ==
                          _selectedFilter.toLowerCase();
                  final matchesSearch = _searchController.text.isEmpty ||
                      (data['title']?.toString().toLowerCase() ?? '')
                          .contains(_searchController.text.toLowerCase());
                  return matchesFilter && matchesSearch;
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final doc = filteredDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: JobCard(
                        docId: doc.id,
                        myImage: data['logoUrl'] != null
                            ? Image.network(
                                data['logoUrl'],
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/spotify.png',
                                    width: 40,
                                    height: 40,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/spotify.png',
                                width: 40,
                                height: 40,
                              ),
                        jobName: data['title'] ?? 'No Title',
                        companyName: data['company'] ?? 'No Company',
                        companyLocation: data['location'] ?? 'No Location',
                        timeStamp: (data['postedAt'] as Timestamp?)
                                ?.toDate()
                                .toIso8601String() ??
                            DateTime.now().toIso8601String(),
                        mode: data['mode'] ?? 'Full Time',
                        level: data['level'] ?? 'Not Specified',
                        description: data['description'] ?? '',
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard({
    required String title,
    required String company,
    required String location,
    required String deadline,
    required Color logoColor,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12, bottom: 8, top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: logoColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      company.substring(0, 1),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: mainBlack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        company,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Closes: $deadline',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipCard({
    required String title,
    required String company,
    required String location,
    required String deadline,
    required Color logoColor,
    String description =
        "This is a job description. It provides details about the role, responsibilities, and requirements.",
  }) {
    // Create job data for bookmark functionality
    final jobData = {
      'title': title,
      'company': company,
      'location': location,
      'deadline': deadline,
      'description': description,
      'postedAt': DateTime.now().toString(),
      'mode': 'Internship',
      'level': 'Entry Level',
    };

    // Generate a unique job ID based on title and company
    final jobId =
        '${title.replaceAll(' ', '_')}_${company.replaceAll(' ', '_')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showJobDescription(
                    context,
                    title: title,
                    company: company,
                    location: location,
                    deadline: deadline,
                    description: description,
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: logoColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      company.substring(0, 1),
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _showJobDescription(
                      context,
                      title: title,
                      company: company,
                      location: location,
                      deadline: deadline,
                      description: description,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: mainBlack,
                        ),
                      ),
                      Text(
                        company,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Closes: $deadline',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )

              // Add bookmark icon
            ],
          )),
    );
  }

  void _showJobDescription(
    BuildContext context, {
    required String title,
    required String company,
    required String location,
    required String deadline,
    required String description,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: mainBlack,
                    ),
                  ),
                  Text(
                    company,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location and deadline
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Closes: $deadline',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Apply button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to apply page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainBlue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Apply Now',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
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
}
