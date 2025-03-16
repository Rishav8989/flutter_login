import 'package:flutter/material.dart';

class SoftwareAdviceTab extends StatelessWidget {
  const SoftwareAdviceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Problem Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Functional Module Selection
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Please Select'),
                    Icon(Icons.arrow_forward_ios),
                  ],
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
                    maxLines: 5,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      hintText: 'Please describe the problem using at least 10 characters...',
                      border: OutlineInputBorder(),
                      counterText: '0/500',
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Attachment Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Attachment'),
                  const SizedBox(height: 8),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.add, size: 40),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Upload up to 5 files, each file no more than 5 MB'),
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
                    backgroundColor: const Color.fromARGB(255, 9, 97, 230),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
      // Add your submission logic here
      print('Submit button pressed');
    },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
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