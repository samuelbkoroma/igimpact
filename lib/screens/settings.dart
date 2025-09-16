import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:igniteimpact/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final bool _notificationsEnabled = true;
  final bool _emailNotifications = true;
  final bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = auth.currentUser?.displayName ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateDisplayName() async {
    try {
      await auth.currentUser?.updateDisplayName(_nameController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Name updated successfully', style: GoogleFonts.poppins()),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Failed to update name', style: GoogleFonts.poppins()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> signOut() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await auth.signOut();
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Logout failed. Try again.', style: GoogleFonts.poppins()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.email),
                title: Text('Email Support', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  _launchEmail();
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text('Call Support', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  _launchPhoneCall();
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: Text('Live Chat', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  _openLiveChat();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@igniteimpact.com',
      queryParameters: {
        'subject': 'App Support Request',
        'body': 'Hello IgniteImpact team,',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Could not launch email app',
                  style: GoogleFonts.poppins())),
        );
      }
    }
  }

  Future<void> _launchPhoneCall() async {
    const phoneNumber = 'tel:+1234567890';
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Could not launch phone app',
                  style: GoogleFonts.poppins())),
        );
      }
    }
  }

  void _openLiveChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Live chat will open here', style: GoogleFonts.poppins())),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentTheme = Theme.of(context);
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password', style: GoogleFonts.poppins()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: currentTheme.colorScheme.primary,
              ),
              onPressed: () async {
                if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match',
                          style: GoogleFonts.poppins()),
                    ),
                  );
                  return;
                }

                try {
                  final credential = EmailAuthProvider.credential(
                    email: auth.currentUser!.email!,
                    password: oldPasswordController.text,
                  );
                  await auth.currentUser!
                      .reauthenticateWithCredential(credential);

                  await auth.currentUser!
                      .updatePassword(newPasswordController.text);

                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password updated successfully',
                            style: GoogleFonts.poppins()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  Navigator.pop(context);
                  String message = 'An error occurred';
                  if (e.code == 'wrong-password') {
                    message = 'Current password is incorrect';
                  } else if (e.code == 'weak-password') {
                    message = 'Password is too weak';
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message, style: GoogleFonts.poppins()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Update',
                  style: GoogleFonts.poppins(
                    color: currentTheme.colorScheme.onPrimary,
                  )),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account', style: GoogleFonts.poppins()),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                try {
                  await auth.currentUser?.delete();

                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Account deleted successfully',
                            style: GoogleFonts.poppins()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to delete account: ${e.message}',
                            style: GoogleFonts.poppins()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text(
                'Delete',
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
          color: currentTheme.colorScheme.onPrimary,
        ),
        centerTitle: true,
        title: Text('Settings',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: Colors.black)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Profile'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: currentTheme.colorScheme.primary,
                        child: Text(
                          (auth.currentUser?.displayName ?? 'U')[0]
                              .toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            color: currentTheme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelText: 'Display Name',
                      labelStyle: GoogleFonts.poppins(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: _updateDisplayName,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Email: ${auth.currentUser?.email ?? 'Not available'}',
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          _buildSectionHeader('Contacts'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.mail_outline,
                      color: currentTheme.colorScheme.primary),
                  title: Text('Contact Us', style: GoogleFonts.poppins()),
                  onTap: () {
                    _showContactOptions(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined,
                      color: currentTheme.colorScheme.primary),
                  title: Text('Privacy Policy', style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PolicyViewer(
                          title: 'Privacy Policy',
                          assetPath: 'assets/privacy_policy.html',
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.gavel_outlined,
                      color: currentTheme.colorScheme.primary),
                  title: Text('Terms and Conditions',
                      style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PolicyViewer(
                          title: 'Terms and Conditions',
                          assetPath: 'assets/terms_conditions.html',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          _buildSectionHeader('Privacy & Security'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.lock_outline,
                      color: currentTheme.colorScheme.primary),
                  title: Text('Change Password', style: GoogleFonts.poppins()),
                  onTap: () {
                    _showChangePasswordDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.security_outlined,
                      color: currentTheme.colorScheme.primary),
                  title: Text("Privacy Policy", style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PolicyViewer(
                          title: 'Privacy Policy',
                          assetPath: 'assets/privacy_policy.html',
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.gavel_outlined,
                      color: currentTheme.colorScheme.primary),
                  title:
                      Text("Terms & Conditions", style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PolicyViewer(
                          title: 'Terms and Conditions',
                          assetPath: 'assets/terms_conditions.html',
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline,
                      color: currentTheme.colorScheme.primary),
                  title: Text("FAQ", style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.pushNamed(context, '/faq');
                  },
                ),
              ],
            ),
          ),
          _buildSectionHeader('Account'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.red[400]),
                  title: Text('Delete Account',
                      style: GoogleFonts.poppins(color: Colors.red[400])),
                  onTap: () {
                    _showDeleteAccountConfirmation(context);
                  },
                ),
                const Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red[400]),
                  title: Text('Logout',
                      style: GoogleFonts.poppins(color: Colors.red[400])),
                  onTap: signOut,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class PolicyViewer extends StatefulWidget {
  final String title;
  final String assetPath;

  const PolicyViewer({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  State<PolicyViewer> createState() => _PolicyViewerState();
}

class _PolicyViewerState extends State<PolicyViewer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
