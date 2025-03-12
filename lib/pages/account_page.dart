import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/pages/accounts/about_page.dart';
import 'package:login/pages/accounts/account_and_security_page.dart';
import 'package:login/pages/accounts/application_sharing_page.dart';
import 'package:login/pages/accounts/declaration_page.dart';
import 'package:login/pages/accounts/general_page.dart';
import 'package:login/pages/accounts/my_service_provider_page.dart';
import 'package:login/pages/accounts/notifications_page.dart';
import 'package:login/pages/accounts/reports_page.dart';
import 'package:login/pages/accounts/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> _launchWebsite(BuildContext context) async {
    final Uri url = Uri.parse('https://rishavwiki.netlify.app/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = 600.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > maxWidth;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? maxWidth : double.infinity,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ProfilePage());
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
                          backgroundImage: NetworkImage('https://rishavwiki.netlify.app/assets/1707189968207-01.jpeg'),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Rishav'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'view_profile'.tr,
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

                Card(
                  elevation: isDesktop ? 2 : 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: [
                      _buildListTile(context, Icons.security, 'account_security'.tr, const AccountAndSecurityPage()),
                      _buildListTile(context, Icons.tune, 'general'.tr, const GeneralPage()),
                      _buildListTile(context, Icons.settings_input_antenna, 'service_provider'.tr, const MyServiceProviderPage()),
                      _buildListTile(context, Icons.web, 'website'.tr, null, () => _launchWebsite(context)), // ✅ Fixed
                      _buildListTile(context, Icons.notifications_active, 'notifications'.tr, const NotificationsPage()),
                      _buildListTile(context, Icons.insert_chart, 'reports'.tr, const ReportsPage()),
                      _buildListTile(context, Icons.share, 'app_sharing'.tr, const ApplicationSharingPage()),
                      _buildListTile(context, Icons.description, 'declaration'.tr, const DeclarationPage()),
                      _buildListTile(context, Icons.info_outline, 'about'.tr, const AboutPage()),
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

  ListTile _buildListTile(BuildContext context, IconData icon, String title, Widget? page, [VoidCallback? onTap]) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
      trailing: Icon(Icons.chevron_right, color: Theme.of(context).disabledColor),
      onTap: onTap ?? () {
        if (page != null) {
          Get.to(() => page);
        }
      },
    );
  }
}