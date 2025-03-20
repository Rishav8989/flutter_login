// chat_ui.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:login/controllers/chat_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chat with us'.tr),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Show confirmation dialog before deleting messages
                  _showDeleteConfirmationDialog(controller); // Removed context, using Get.context if needed internally
                },
                tooltip: 'Delete all messages',
              ),
            ],
          ),
          body: Center(
            child: SizedBox(
              width: 600,
              child: Obx(() => Chat(
                    messages: controller.messages.toList(),
                    onAttachmentPressed: () => controller.handleAttachmentPressed(Get.context!), // Pass Get.context!
                    onMessageTap: (context, message) => controller.handleMessageTap(context, message),
                    onPreviewDataFetched: controller.handlePreviewDataFetched,
                    onSendPressed: controller.handleSendPressed,
                    showUserAvatars: true,
                    showUserNames: true,
                    // Access it as controller.user now (without underscore)
                    user: controller.user,
                    theme: DefaultChatTheme(
                      inputPadding: const EdgeInsets.all(12),
                      inputMargin: const EdgeInsets.all(8),
                      inputBorderRadius: const BorderRadius.all(Radius.circular(20)),
                      backgroundColor: themeData.colorScheme.background,
                      inputBackgroundColor: themeData.colorScheme.surface,
                      primaryColor: themeData.colorScheme.primary,
                      inputTextColor: themeData.colorScheme.onSurface,
                      inputTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      inputContainerDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    onMessageLongPress: (context, message) => controller.showMessageContextMenu(Get.context!, message), // Pass Get.context!
                  )),
            ),
          ),
        );
      },
    );
  }

  // Function to show a confirmation dialog before deleting messages
  Future<void> _showDeleteConfirmationDialog(ChatController controller) async { // Removed BuildContext parameter
    Get.dialog( // Use Get.dialog for AlertDialog
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to delete all messages?'),
              Text('This action cannot be undone.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Get.back(); // Close the dialog using Get.back()
            },
          ),
          TextButton(
            child: const Text('Yes, Delete'),
            onPressed: () {
              Get.back(); // Close the dialog using Get.back()
              controller.deleteMessages(); // Call the delete function
            },
          ),
        ],
      ),
      barrierDismissible: false, // User must tap a button to close dialog
    );
  }
}