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

class ChatController extends GetxController {
  RxList<types.Message> messages = <types.Message>[].obs;
  final user = const types.User( // Changed from _user to user (public)
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
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
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
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
                        Navigator.pop(context);
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
                        Navigator.pop(context);
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

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user, // Using public 'user'
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    addMessage(textMessage);
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
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: const Text('Delete'),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        messages.removeWhere((msg) => msg.id == message.id);
        saveMessageToFile(types.TextMessage(
          author: user, // Using public 'user'
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: '',
        ));
      }
    });
  }
}