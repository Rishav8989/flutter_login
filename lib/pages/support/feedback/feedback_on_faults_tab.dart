// feedback_on_faults_tab.dart
import 'dart:io';
import 'package:flutter/material.dart';

class FeedbackOnFaultsTab extends StatefulWidget {
  final TextEditingController problemDescriptionController;
  final TextEditingController contactInfoController;
  final List<File> uploadedFiles;
  final Function selectFiles;
  final int characterCount;
  final GlobalKey<FormState> formKey;

  const FeedbackOnFaultsTab({
    Key? key,
    required this.problemDescriptionController,
    required this.contactInfoController,
    required this.uploadedFiles,
    required this.selectFiles,
    required this.characterCount,
    required this.formKey,
  }) : super(key: key);

  @override
  _FeedbackOnFaultsTabState createState() => _FeedbackOnFaultsTabState();
}

class _FeedbackOnFaultsTabState extends State<FeedbackOnFaultsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: ListView(
          children: <Widget>[
            _buildDropdown('Plant Name', 'Please Select'),
            const SizedBox(height: 10),
            _buildDropdown('Communication Device S/N', 'Please Select'),
            const SizedBox(height: 20),
            const Text('Problem Details'),
            const SizedBox(height: 10),
            _buildDropdown('Functional Module', 'Please Select'),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.problemDescriptionController,
              decoration: InputDecoration(
                labelText: 'Problem Description',
                hintText: 'Please describe the problem using at least 10 characters so that we can provide further assistance',
                border: const OutlineInputBorder(),
                counterText: '${widget.characterCount}/600',
              ),
              maxLines: 5,
              maxLength: 600,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a problem description';
                }
                if (value.length < 10) {
                  return 'Description must be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const Text('Attachment'),
            const SizedBox(height: 10),
            _buildUploadSection(),
            const SizedBox(height: 20),
            _buildDropdown('Associate Fault', 'Please Select'),
            const SizedBox(height: 20),
            const Text('Contact Information'),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.contactInfoController,
              decoration: const InputDecoration(
                hintText: 'Mobile Phone Number or Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter contact information';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  // Handle form submission
                }
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Note: If there is an urgent problem to be dealt with, please contact My service provider'),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
          ),
          items: <String>['Option 1', 'Option 2', 'Option 3']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => widget.selectFiles(),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey[100],
            ),
            child: widget.uploadedFiles.isEmpty
                ? const Center(
                    child: Text('Tap to upload files'),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    itemCount: widget.uploadedFiles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Center(
                          child: Icon(Icons.insert_drive_file),
                        ),
                      );
                    },
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${widget.uploadedFiles.length}/5 files selected',
          style: TextStyle(
            color: widget.uploadedFiles.length >= 5 ? Colors.red : null,
          ),
        ),
        const SizedBox(height: 10),
        const Text('Upload up to 5 files, each file no more than 5 MB'),
      ],
    );
  }
}
