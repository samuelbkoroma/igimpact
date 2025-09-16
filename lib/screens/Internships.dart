import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igniteimpact/components/JobCard.dart';
import 'package:igniteimpact/theme/colors.dart';

class Internships extends StatefulWidget {
  const Internships({super.key});

  @override
  State<Internships> createState() => _InternshipsState();
}

class _InternshipsState extends State<Internships> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Job', 'Internship', 'Volunteer'];
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
      backgroundColor: mainGrey,
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          // Search Bar with Suggestions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for jobs...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: _filterOptions.map((option) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(option),
                      selected: _selectedFilter == option,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = selected ? option : 'All';
                        });
                      },
                      selectedColor: mainBlue,
                      backgroundColor: Colors.grey[200],
                      labelStyle: GoogleFonts.poppins(
                        color: _selectedFilter == option
                            ? Colors.white
                            : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 16),

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
                  return const Center(child: Text('No positions available'));
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
}
