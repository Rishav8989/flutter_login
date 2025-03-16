import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login/pages/support/feedback/feedback_on_faults_tab.dart';
import 'package:login/pages/support/feedback/software_advice_tab.dart';


class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _problemDescriptionController = TextEditingController();
  final _contactInfoController = TextEditingController();
  List<File> _uploadedFiles = [];
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _problemDescriptionController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _problemDescriptionController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _problemDescriptionController.text.length;
    });
  }

  void _selectFiles() async {
    // In a real app, you would use a file picker package like file_picker
    // This is just a placeholder implementation
    setState(() {
      _uploadedFiles = List.generate(2, (index) => File('file_$index.txt'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(
              child: Text('Feedback on Faults'),
            ),
            const Tab(
              child: Text('Software Advice'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FeedbackOnFaultsTab(
            problemDescriptionController: _problemDescriptionController,
            contactInfoController: _contactInfoController,
            uploadedFiles: _uploadedFiles,
            selectFiles: _selectFiles,
            characterCount: _characterCount,
            formKey: _formKey,
          ),
          const SoftwareAdviceTab(),
        ],
      ),
    );
  }
}
