// lib/support_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // If you are using GetX for translations

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double maxWidth = 600.0; // Define maxWidth, same as AccountPage
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > maxWidth; // Determine desktop layout

    return Scaffold(
      appBar: AppBar(
        title: Text('Support'.tr),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        elevation: 0,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center( // Center the content
        child: ConstrainedBox( // Apply maxWidth constraint
          constraints: BoxConstraints(
            maxWidth: isDesktop ? maxWidth : double.infinity, // Apply maxWidth only on desktop
          ),
          child: Padding( // Keep the outer padding
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                _buildSectionHeader(context, 'Commissioning Tools'.tr),
                _buildSupportCard(
                  context: context,
                  icon: Icons.settings_input_antenna,
                  text: 'Local Access'.tr,
                  onTap: () {
                    print('Local Access Tapped');
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.wifi,
                  text: 'WLAN Configuration'.tr,
                  onTap: () {
                    print('WLAN Configuration Tapped');
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.download,
                  text: 'Firmware Download'.tr,
                  onTap: () {
                    print('Firmware Download Tapped');
                  },
                ),

                const SizedBox(height: 20.0),
                _buildSectionHeader(context, 'Value-added Services'.tr),
                _buildSupportCard(
                  context: context,
                  icon: Icons.access_time,
                  text: 'Live Data'.tr,
                  onTap: () {
                    print('Live Data Tapped');
                  },
                ),

                const SizedBox(height: 20.0),
                _buildSectionHeader(context, 'Help Center'.tr),
                _buildSupportCard(
                  context: context,
                  icon: Icons.feedback,
                  text: 'Feedback'.tr,
                  onTap: () {
                    print('Feedback Tapped');
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.play_arrow,
                  text: 'Video Tutorial'.tr,
                  onTap: () {
                    print('Video Tutorial Tapped');
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.book,
                  text: 'User Manual'.tr,
                  onTap: () {
                    print('User Manual Tapped');
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.question_answer,
                  text: 'FAQs'.tr,
                  onTap: () {
                    print('FAQs Tapped');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.textTheme.headlineSmall?.color,
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 0,
        color: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 24.0, color: theme.iconTheme.color),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    text,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Icon(Icons.chevron_right, color: theme.disabledColor, size: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}