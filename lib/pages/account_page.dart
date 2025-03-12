// lib/pages/account_page.dart
import 'package:flutter/material.dart';
import 'package:login/pages/accounts/about_page.dart';
import 'package:login/pages/accounts/account_and_security_page.dart';
import 'package:login/pages/accounts/application_sharing_page.dart';
import 'package:login/pages/accounts/declaration_page.dart';
import 'package:login/pages/accounts/general_page.dart';
import 'package:login/pages/accounts/my_service_provider_page.dart';
import 'package:login/pages/accounts/notifications_page.dart';
import 'package:login/pages/accounts/reports_page.dart';
import 'package:login/pages/accounts/profile_page.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> _launchWebsite(BuildContext context) async {
    final Uri url = Uri.parse('https://rishavwiki.netlify.app/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define a max width for desktop/larger screens
    final double maxWidth = 600.0; // Adjust this value as needed
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > maxWidth;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? maxWidth : double.infinity,
          ),
          child: Padding( // Outer Padding for the whole Account Page content
            padding: const EdgeInsets.all(16.0), // Add padding here (adjust value as needed)
            child: ListView(
              children: <Widget>[
                // Profile Banner Section
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).cardColor,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'View Profile',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Settings List
                Card(
                  elevation: isDesktop ? 2 : 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.security, color: Theme.of(context).iconTheme.color),
                        title: Text('Account and Security', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AccountAndSecurityPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.tune, color: Theme.of(context).iconTheme.color),
                        title: Text('General', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GeneralPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.settings_input_antenna, color: Theme.of(context).iconTheme.color),
                        title: Text('My Service Provider', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyServiceProviderPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.web, color: Theme.of(context).iconTheme.color),
                        title: Text('Website', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          _launchWebsite(context); // Call _launchWebsite directly
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.notifications_active, color: Theme.of(context).iconTheme.color),
                        title: Text('Notifications', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationsPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.insert_chart, color: Theme.of(context).iconTheme.color),
                        title: Text('Reports', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ReportsPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.share, color: Theme.of(context).iconTheme.color),
                        title: Text('Application Sharing', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ApplicationSharingPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.description, color: Theme.of(context).iconTheme.color),
                        title: Text('Declaration', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DeclarationPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 10), // Gap instead of Divider
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color),
                        title: Text('About', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AboutPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}