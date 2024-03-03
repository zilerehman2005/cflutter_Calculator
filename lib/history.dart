import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> calculationHistory = [];

  @override
  void initState() {
    super.initState();
    loadHistory(); // Load calculation history when the screen initializes
  }

  // Method to load calculation history from SharedPreferences
  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      calculationHistory = prefs.getStringList('calculationHistory') ?? [];
    });
  }

  // Method to save calculation history to SharedPreferences
  Future<void> saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('calculationHistory', calculationHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculation History'),
      ),
      body: ListView.builder(
        itemCount: calculationHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              calculationHistory[index],
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              // Implement any action upon tapping a history item
              // For example: You can copy the history item to the clipboard
              Clipboard.setData(ClipboardData(text: calculationHistory[index]));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Copied to clipboard: ${calculationHistory[index]}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Clear the calculation history and update SharedPreferences
            calculationHistory.clear();
            await saveHistory(); // Await the saveHistory method call
            setState(() {}); // Force a rebuild if needed
            // Show a snackbar to inform the user
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('this is calculator history')
              ),
            );
          },

        child: Icon(Icons.clear),
      ),
    );
  }
}
