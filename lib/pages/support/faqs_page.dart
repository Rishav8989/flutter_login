import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
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
                    _buildFAQItem(
                      context,
                      title: 'How to obtain an account?',
                      content: [
                        'Registration or account allocation is available.',
                        '1. Registration: Owners or distributors/installers can register their accounts on the login page of iSolarCloud Web or App (Select the server site according to the actual situation, and be aware that the Chinese server only supports distributors/installers to register their accounts).',
                        '2. Account allocation: The backend administrator allocates accounts to the distributor/installer. When the distributors/installers get the accounts, they can help the owner to create the plant and generate the owner\'s account, and deliver it to the owner by text message or email.',
                      ],
                    ),
                    _buildFAQItem(
                      context,
                      title: 'What if I forget my login password?',
                      content: [
                        'Access iSolarCloud Web or App, click on "Forgot Password" on the login page to enter the "Account and Security" interface, and enter your account or email information to verify your identity. Reset the password after verification.',
                      ],
                    ),
                    _buildFAQItem(
                      context,
                      title: 'How do I change my login password?',
                      content: [
                        'Enter your account and password to log in iSolarCloud Web or App, click "Account and Security -> Account Password" to enter corresponding interface, and you can reset the password.',
                      ],
                    ),
                    _buildFAQItem(
                      context,
                      title: 'Account Cancellation',
                      content: [
                        'Enter your account and password to log in iSolarCloud Web or App, click "Account and Security -> Account Cancellation" to enter corresponding interface, verify your identity according to the prompt, and you can cancel your account after verification. Once an account is cancelled, all information related to the account will be permanently deleted and cannot be restored, so please operate cautiously.',
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, {required String title, required List<String> content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 16),
        ...content.map((text) => Text(text)).toList(),
        const SizedBox(height: 32),
        Divider(color: Colors.grey[300]),
        const SizedBox(height: 32),
      ],
    );
  }
}