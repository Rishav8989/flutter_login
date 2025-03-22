import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/pages/accounts/about_page.dart';
import 'package:login/pages/accounts/account_and_security_page.dart';
import 'package:login/pages/accounts/general_page.dart';
import 'package:login/pages/accounts/my_service_provider_page.dart';
import 'package:login/pages/accounts/profile_page.dart';
import 'package:login/pages/support/user_manual_page.dart';
import 'package:login/widgets/detailed_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login/widgets/logout_button.dart'; // Import the new widget

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse('https://rishavwiki.netlify.app/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch'.tr);
    }
  }

  Future<void> _launchApplicationSharingUrl() async {
    final Uri url = Uri.parse('https://github.com/Rishav8989/flutter_login');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch application sharing URL'.tr);
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
                          backgroundImage: NetworkImage(
                              'https://rishavwiki.netlify.app/assets/1707189968207-01.jpeg'),
                          backgroundColor: Colors.grey,
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
                                fontSize: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'view_profile'.tr,
                              style: TextStyle(
                                fontSize: 16,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    children: [
                      _buildListTile(Icons.security, 'account_security'.tr,
                          const AccountAndSecurityPage()),
                      _buildListTile(
                          Icons.tune, 'general'.tr, const GeneralPage()),
                      _buildListTile(Icons.settings_input_antenna,
                          'service_provider'.tr, const MyServiceProviderPage()),
                      _buildListTile(Icons.web, 'website'.tr, null,
                          () => _launchWebsite()),
                      _buildListTile(Icons.insert_chart, 'reports'.tr,
                          const DetailedChart()),
                      _buildListTile(Icons.share, 'app_sharing'.tr, null,
                          () => _launchApplicationSharingUrl()),
                      _buildListTile(Icons.description, 'declaration'.tr,
                          const UserManualPage()),
                      _buildListTile(
                          Icons.info_outline, 'about'.tr, const AboutPage()),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const LogoutButton(), // Using the new LogoutButton widget
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(IconData icon, String title, Widget? page,
      [VoidCallback? onTap]) {
    return ListTile(
      dense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Icon(icon, color: Theme.of(Get.context!).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            color: Theme.of(Get.context!).textTheme.bodyMedium?.color),
      ),
      trailing: Icon(Icons.chevron_right,
          color: Theme.of(Get.context!).disabledColor),
      onTap: onTap ??
          () {
            if (page != null) {
              Get.to(() => page);
            }
          },
    );
  }
}