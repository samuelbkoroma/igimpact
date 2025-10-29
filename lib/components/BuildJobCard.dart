// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:igniteimpact/theme/colors.dart';

// class Buildjobcard extends StatefulWidget {
//   const Buildjobcard({super.key});

//   @override
//   State<Buildjobcard> createState() => _BuildjobcardState();
// }

// class _BuildjobcardState extends State<Buildjobcard> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }

// void _showJobDescription(
//   BuildContext context, {
//   required String title,
//   required String company,
//   required String location,
//   required String deadline,
//   required String description,
// }) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => Container(
//       height: MediaQuery.of(context).size.height * 0.75,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Handle bar
//           Center(
//             child: Container(
//               margin: const EdgeInsets.only(top: 10),
//               width: 50,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           // Content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: GoogleFonts.poppins(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: mainBlack,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     company,
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on_outlined,
//                         size: 18,
//                         color: Colors.grey.shade600,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         location,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Icon(
//                         Icons.access_time,
//                         size: 18,
//                         color: Colors.grey.shade600,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         'Closes: $deadline',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Job Description',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: mainBlack,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: Colors.grey.shade800,
//                       height: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Apply for job functionality
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: mainBlue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Text(
//                         'Apply Now',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildJobCard({
//   required String title,
//   required String company,
//   required String location,
//   required String deadline,
//   required Color logoColor,
// }) {
//   return GestureDetector(
//     onTap: () {
//       _showJobDescription(
//         context,
//         title: title,
//         company: company,
//         location: location,
//         deadline: deadline,
//         description:  
//             "This is a job description. It provides details about the role, responsibilities, and requirements.",
//       );
//     },
//     child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: logoColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Text(
//                     company.substring(0, 1),
//                     style: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: mainBlack,
//                       ),
//                     ),
//                     Text(
//                       company,
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on_outlined,
//                           size: 16,
//                           color: Colors.grey.shade600,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           location,
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Icon(
//                           Icons.access_time,
//                           size: 16,
//                           color: Colors.grey.shade600,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           'Closes: $deadline',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.bookmark_border),
//                 color: Colors.grey.shade600,
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         )),
//   );
// }
