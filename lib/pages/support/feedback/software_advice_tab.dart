import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class SoftwareAdviceTab extends StatefulWidget {
  const SoftwareAdviceTab({Key? key}) : super(key: key);

  @override
  State<SoftwareAdviceTab> createState() => _SoftwareAdviceTabState();
}

class _SoftwareAdviceTabState extends State<SoftwareAdviceTab> {
  final pb = PocketBase('https://first.pockethost.io'); // Your PB URL

  final TextEditingController _problemDescriptionController =
      TextEditingController();
  final TextEditingController _contactInformationController =
      TextEditingController();

  // Options for the dropdown
  final List<String> _availableOptions = [
    'Monitoring',
    'Faults',
    'Support',
    'Account'
  ];
  String? _selectedOption; // Store the selected option *text*

  List<PlatformFile> _selectedFiles = [];
  final int _maxFiles = 5;
  final int _maxFileSizeMB = 5;

  bool _isLoading = false;

  @override
  void dispose() {
    _problemDescriptionController.dispose();
    _contactInformationController.dispose();
    super.dispose();
  }

    Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image, // Only allow image files
      );

      if (result != null) {
        List<PlatformFile> files = result.files;

        // Check file count limit.
        if (files.length + _selectedFiles.length > _maxFiles) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'You can only upload a maximum of $_maxFiles files.')),
          );
          return;
        }

        //Check file size and add
        for(final file in files){
            if (file.size > _maxFileSizeMB * 1024 * 1024) {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'File "${file.name}" exceeds the maximum size of $_maxFileSizeMB MB.')),
              );
            }
            else{
              setState(() {
                _selectedFiles.add(file);
              });
            }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking files: $e')),
      );
    }
  }

  Future<void> _removeFile(PlatformFile file) async{
    setState(() {
      _selectedFiles.remove(file);
    });
  }

  Future<void> _submitForm() async {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option.')),
      );
      return;
    }
    if (_problemDescriptionController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please add a problem description (minimum 10 characters).')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final data = {
        'problem_detail': _selectedOption, // Send the selected option *text*
        'problem_description': _problemDescriptionController.text,
        'contact_information': _contactInformationController.text,
        // attachments are handled below
      };

      List<http.MultipartFile> files = [];
      for (final file in _selectedFiles) {
        files.add(
          await http.MultipartFile.fromPath(
            'attachments',
            file.path!,
            filename: file.name,
          ),
        );
      }

      await pb.collection('software_advice').create(body: data, files: files);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Software advice submitted successfully!')),
      );

      _problemDescriptionController.clear();
      _contactInformationController.clear();
      setState(() {
        _selectedOption = null;
        _selectedFiles = [];
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit software advice: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Problem Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Problem Detail Dropdown
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedOption,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Please Select',
                        ),
                        items: _availableOptions.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Problem Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '* Problem Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _problemDescriptionController,
                          maxLines: 5,
                          maxLength: 500,
                          decoration: InputDecoration(
                            hintText:
                                'Please describe the problem using at least 10 characters...',
                            border: const OutlineInputBorder(),
                            counterText:
                                '${_problemDescriptionController.text.length}/500', //Dynamic counter
                          ),
                          onChanged: (text) {
                            setState(() {}); // Update counter text on change
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Attachment Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Attachments'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _pickFiles,
                          child: const Text('Add Attachments'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            'Upload up to $_maxFiles files, each file no more than $_maxFileSizeMB MB'),
                        const SizedBox(height: 8),
                        // Display selected files.
                        if (_selectedFiles.isNotEmpty)
                          SizedBox(
                            height: 100, // Fixed height for scrollable list.
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedFiles.length,
                              itemBuilder: (context, index) {
                                final file = _selectedFiles[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    //Use stack for the remove button
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize
                                            .min, // Fit content to size
                                        children: [
                                          const Icon(Icons.image,
                                              size:
                                                  64), // Placeholder image icon.
                                          Text(
                                            file.name,
                                            overflow: TextOverflow
                                                .ellipsis, // Prevent long names.
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        // Positioned for absolute placement
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () => _removeFile(file),
                                          child: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Contact Information
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Information',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _contactInformationController,
                          decoration: const InputDecoration(
                            hintText: 'Mobile Phone Number or Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Note Section
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Note: If there is an urgent problem to be dealt with, please contact My service provider',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 9, 97, 230),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _isLoading ? null : _submitForm,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
      ),
    );
  }
}