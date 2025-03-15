// lib/date_picker_widget.dart
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;

  const DatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 16.0),
          textStyle: const TextStyle(fontSize: 14),
        ),
        onPressed: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2024, 5, 15),
            lastDate: DateTime(2024, 6, 17),
          );
          if (pickedDate != null && pickedDate != selectedDate) {
            onDateSelected(pickedDate);
          }
        },
        child: Text(
          'Select Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
        ),
      ),
    );
  }
}