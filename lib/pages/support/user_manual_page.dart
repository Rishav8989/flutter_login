import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  const UserManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manual'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle(context, 'All Rights Reserved'),
            const SizedBox(height: 16),
            _buildParagraph(
                context, 'All Rights Reserved © Sungrow Power Supply Co., Ltd. 2024. All Rights Reserved'),
            const SizedBox(height: 16),
            _buildParagraph(
                context,
                'No part of this document can be reproduced in any form or by any means without the prior written permission of Sungrow Power Supply Co., Ltd (hereinafter "SUNGROW").'),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Trademark'),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: 'SUNGROW',
                      style: const TextStyle(color: Color(0xFFFF8C00), fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' and other Sungrow trademarks used in this manual are owned by SUNGROW. All other trademarks or registered trademarks mentioned in this manual are owned by their respective owners.'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Software Licenses'),
            const SizedBox(height: 16),
            _buildBulletPoint(context,
                'It is prohibited to use data contained in firmware or software developed by SUNGROW, in part or in full, for commercial purposes by any means.'),
            const SizedBox(height: 8),
            _buildBulletPoint(context,
                'It is prohibited to perform reverse engineering, cracking, or any other operations that compromise the original program design of the software developed by SUNGROW.'),
            const SizedBox(height: 32),
            _buildSectionTitle(context, 'Contact Information'),
            const SizedBox(height: 16),
            _buildParagraph(context, 'Sungrow Power Supply Co., Ltd.'),
            const SizedBox(height: 8),
            _buildParagraph(context,
                'Address: No. 1699, Xiyou Rd., High-tech Zone, Hefei City, Anhui Province, China'),
            const SizedBox(height: 8),
            _buildParagraph(context, 'Zip code: 230088'),
            const SizedBox(height: 8),
            _buildParagraph(context, 'Tel: 0551-6532 7878 / 0551-6532 7877'),
            const SizedBox(height: 8),
            _buildLink(context, 'Official website: www.sungrowpower.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• '),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildLink(BuildContext context, String text) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          const TextSpan(text: 'Official website: '),
          TextSpan(
            text: 'www.sungrowpower.com',
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}