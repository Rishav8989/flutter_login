// lib/support_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/pages/support/chat_page.dart';
import 'package:login/pages/support/faqs_page.dart';
import 'package:login/pages/support/feedback_page.dart';
import 'package:login/pages/support/firmware_download_page.dart';
import 'package:login/pages/support/user_manual_page.dart';
import 'package:login/pages/support/video_tutorial_page.dart';
import 'package:login/pages/support/wlan_configuration_page.dart';
import 'package:login/pages/support/local_access.dart';


class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double maxWidth = 600.0; // Define maxWidth, same as AccountPage
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > maxWidth; // Determine desktop layout

    return Scaffold(
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
                    Get.to(() => LocalAccess()); // Removed const here
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.wifi,
                  text: 'WLAN Configuration'.tr,
                  onTap: () {
                    Get.to(() => const WLANConfigurationPage());
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.download,
                  text: 'Firmware Download'.tr,
                  onTap: () {
                    Get.to(() => const FirmwareDownloadPage());
                  },
                ),

                const SizedBox(height: 20.0),
                _buildSectionHeader(context, 'Help Center'.tr),
                _buildSupportCard(
                  context: context,
                  icon: Icons.chat, // Or another appropriate icon
                  text: 'Chat with us'.tr,
                  onTap: () {
                    Get.to(() => const ChatPage());
                  }),
                _buildSupportCard(
                  context: context,
                  icon: Icons.feedback,
                  text: 'Feedback'.tr,
                  onTap: () {
                    Get.to(() => const FeedbackPage());
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.play_arrow,
                  text: 'Video Tutorial'.tr,
                  onTap: () {
                    Get.to(() => const VideoTutorialPage());
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.book,
                  text: 'User Manual'.tr,
                  onTap: () {
                    Get.to(() => const UserManualPage());
                  },
                ),
                _buildSupportCard(
                  context: context,
                  icon: Icons.question_answer,
                  text: 'FAQs'.tr,
                  onTap: () {
                    Get.to(() => const FAQsPage());
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
                Icon(Icons.chevron_right, color: theme.disabledColor, size: 20,), // Removed const here
              ],
            ),
          ),
        ),
      ),
    );
  }
}