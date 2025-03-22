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
      child: ConstrainedBox( // Add max width constraint
        constraints: const BoxConstraints(maxWidth: 600),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
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
              const SizedBox(height: 20),
              _buildDropdown('Associate Fault', 'Please Select'),
              const SizedBox(height: 20),
              const Text('Contact Information'),
              const SizedBox(height: 10),
              TextFormField(
                controller: widget.contactInfoController,
                decoration: InputDecoration(
                  hintText: 'Mobile Phone Number or Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
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
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Note: If there is an urgent problem to be dealt with, please contact My service provider'),
            ],
          ),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
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
}