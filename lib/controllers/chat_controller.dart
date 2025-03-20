// chat_controller.dart
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Add this import

class ChatController extends GetxController {
  RxList<types.Message> messages = <types.Message>[].obs;

  String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  final user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac', // Your user ID
  );
  final botUser = const types.User( // Define a user for the bot
    id: 'gemini-bot', // Unique ID for the bot
    firstName: 'Solar Asist', // Bot's name
  );

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void addMessage(types.Message message) {
    messages.insert(0, message);
    saveMessageToFile(message);
  }

  void handleAttachmentPressed(BuildContext context) {
    Get.bottomSheet( // Use Get.bottomSheet for bottom sheet
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Get.back(); // Use Get.back to dismiss bottom sheet
                        handleImageSelection();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo, size: 24),
                          SizedBox(width: 8),
                          Text('Photo'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Get.back(); // Use Get.back to dismiss bottom sheet
                        handleFileSelection();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.attach_file, size: 24),
                          SizedBox(width: 8),
                          Text('File'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white, // Optional: Set background color for bottomSheet
      elevation: 2, // Optional: Set elevation
      shape: RoundedRectangleBorder( // Optional: Customize shape
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user, // Using public 'user'
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      addMessage(message);
    }
  }

  void handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user, // Using public 'user'
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      addMessage(message);
    }
  }

  void handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          messages[index] = updatedMessage;
          messages.refresh(); // Trigger UI update for RxList

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          messages[index] = updatedMessage;
          messages.refresh(); // Trigger UI update for RxList
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    messages[index] = updatedMessage;
    messages.refresh(); // Trigger UI update for RxList
  }

  Future<void> handleSendPressed(types.PartialText message) async { // Make it async
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    addMessage(textMessage); // Add user's message immediately

    // *** Call Gemini API here ***
    try {
      final botResponse = await sendMessageToGemini(message.text);
      if (botResponse != null && botResponse.isNotEmpty) {
        final botTextMessage = types.TextMessage(
          author: botUser, // Use the botUser we defined
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: botResponse,
        );
        addMessage(botTextMessage); // Add bot's message to the chat
      } else {
        // Handle case where Gemini API returns no response or an error
        print('Gemini API returned empty or error response.');
        // Optionally show an error message to the user in the chat
        final errorMessage = types.TextMessage(
          author: botUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: 'Sorry, I encountered an error or didn\'t have a response.',
        );
        addMessage(errorMessage);
      }
    } catch (e) {
      print('Error calling Gemini API: $e');
      // Optionally show an error message to the user in the chat
      final errorMessage = types.TextMessage(
        author: botUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Sorry, I couldn\'t connect to the AI service.',
        );
      addMessage(errorMessage);
    }
  }

  // *** New function to send message to Gemini API (Using gemini-2.0-flash as requested) ***
  Future<String?> sendMessageToGemini(String message) async {
    const geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent'; // Gemini Flash API Endpoint (v1beta)
    final apiKey = geminiApiKey; // Use your API key


    try {
      final response = await http.post(
        Uri.parse('${geminiApiUrl}?key=$apiKey'), // Append API key as query parameter
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': message}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Gemini API response structure might vary slightly, adjust accordingly.
        // This assumes a simple text response in 'candidates[0].content.parts[0].text'
        if (responseData['candidates'] != null &&
            responseData['candidates'].isNotEmpty &&
            responseData['candidates'][0]['content'] != null &&
            responseData['candidates'][0]['content']['parts'] != null &&
            responseData['candidates'][0]['content']['parts'].isNotEmpty) {
          return responseData['candidates'][0]['content']['parts'][0]['text'] as String?;
        } else {
          print('Gemini API response structure unexpected: $responseData');
          print('Full Gemini API Response Body (Unexpected Structure): ${response.body}'); // Print full body for inspection
          return null; // Or handle differently
        }
      } else {
        print('Gemini API error - Status Code: ${response.statusCode}');
        print('Full Gemini API Response Body (Error): ${response.body}'); // Print full body for inspection
        return null; // Or handle differently
      }
    } catch (e) {
      print('Error sending message to Gemini API: $e');
      return null; // Or handle differently
    }
  }


  Future<void> loadMessages() async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      final file = File('${documentsDir.path}/messages.json');

      if (file.existsSync()) {
        final response = await file.readAsString();
        final loadedMessages = (jsonDecode(response) as List)
            .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
            .toList();

        messages.value = loadedMessages; // Update RxList value
      }
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  Future<void> saveMessageToFile(types.Message message) async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      print('Saving messages to: ${documentsDir.path}/messages.json');
      final file = File('${documentsDir.path}/messages.json');

      final List<Map<String, dynamic>> messagesJson = messages
          .map((msg) => msg.toJson() as Map<String, dynamic>)
          .toList();

      await file.writeAsString(jsonEncode(messagesJson));
    } catch (e) {
      print('Error saving message: $e');
    }
  }

  Future<void> deleteMessages() async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      final file = File('${documentsDir.path}/messages.json');

      if (file.existsSync()) {
        await file.delete();
        messages.value = []; // Update RxList value
      }
    } catch (e) {
      print('Error deleting messages: $e');
    }
  }

  void showMessageContextMenu(BuildContext context, types.Message message) {
    Get.dialog( // Use Get.dialog for showing context menu as dialog
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Delete'),
              onTap: () {
                Get.back(); // Dismiss the dialog
                messages.removeWhere((msg) => msg.id == message.id);
                saveMessageToFile(types.TextMessage(
                  author: user,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  id: const Uuid().v4(),
                  text: '',
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}