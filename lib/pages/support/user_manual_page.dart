import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  const UserManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600,
                  minWidth: constraints.maxWidth < 600 ? constraints.maxWidth : 600,
                ),
                child: ListView(
                  children: [
                    _buildSectionTitle(context, 'All Rights Reserved'),
                    const SizedBox(height: 20),
                    _buildParagraph(
                        context, 'All Rights Reserved © Rishav Power Supply Co., Ltd. 2025. All Rights Reserved'),
                    const SizedBox(height: 20),
                    _buildParagraph(
                        context,
                        'No part of this document can be reproduced in any form or by any means without the prior written permission of Rishav Power Supply Co., Ltd (hereinafter "Rishav").'),
                    const SizedBox(height: 40),
                    _buildSectionTitle(context, 'Trademark'),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: 'Rishav',
                              style: const TextStyle(color: Color(0xFFFF8C00), fontWeight: FontWeight.bold)),
                          const TextSpan(text: ' and other Rishav trademarks used in this manual are owned by Rishav. All other trademarks or registered trademarks mentioned in this manual are owned by their respective owners.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildSectionTitle(context, 'Software Licenses'),
                    const SizedBox(height: 20),
                    _buildBulletPoint(context,
                        'It is prohibited to use data contained in firmware or software developed by Rishav, in part or in full, for commercial purposes by any means.'),
                    const SizedBox(height: 16),
                    _buildBulletPoint(context,
                        'It is prohibited to perform reverse engineering, cracking, or any other operations that compromise the original program design of the software developed by Rishav.'),
                    const SizedBox(height: 40),
                    _buildSectionTitle(context, 'Contact Information'),
                    const SizedBox(height: 20),
                    _buildParagraph(context, 'Rishav Power Supply Co., Ltd.'),
                    const SizedBox(height: 16),
                    _buildParagraph(context,
                        'Address: No. xyz, India'),
                    const SizedBox(height: 16),
                    _buildParagraph(context, 'Zip code: 000000'),
                    const SizedBox(height: 16),
                    _buildParagraph(context, 'Tel: 0123456789'),
                    const SizedBox(height: 16),
                    _buildLink(context, 'Official website: www.Rishavpower.com'),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
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
            text: 'https://rishavwiki.netlify.app/',
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}