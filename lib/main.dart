import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ReadJsonFile(),
    );
  }
}

class ReadCsvFile extends StatefulWidget {
  const ReadCsvFile({Key? key}) : super(key: key);

  @override
  State<ReadCsvFile> createState() => _ReadCsvFileState();
}

class _ReadCsvFileState extends State<ReadCsvFile> {
  List<List<dynamic>> data = [];

  void readCsvFileFromExtStorage() async {
    const filePath = 'C:/Users/HARSH/Downloads/csv.csv';
    final myFile = File(filePath);
    final csvStringFile = await myFile.readAsString();
    List<List<dynamic>> list =
        const CsvToListConverter().convert(csvStringFile);

    setState(() {
      data = list;
    });
  }

  // void readCsv() async {
  //   final readCsv = await rootBundle.loadString('assets/csc.csv');
  //   List<List<dynamic>> list = const CsvToListConverter().convert(readCsv);
  //   setState(() {
  //     data = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSV File Read'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // readCsv();
          readCsvFileFromExtStorage();
        },
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(3),
              color: index == 0 ? Colors.amber : Colors.white,
              child: ListTile(
                leading: Text(data[index][0].toString()),
                title: Text(data[index][1].toString()),
                trailing: Text(data[index][2].toString()),
              ),
            );
          }),
    );
  }
}

class ReadJsonFile extends StatefulWidget {
  const ReadJsonFile({Key? key}) : super(key: key);

  @override
  State<ReadJsonFile> createState() => _ReadJsonFileState();
}

class _ReadJsonFileState extends State<ReadJsonFile> {
  List _items = [];

  void readJsonFileFromExtStorage() async {
    const filePath = 'C:/Users/HARSH/Downloads/file.json';
    final myFile = File(filePath);
    final jsonStringFile = await myFile.readAsString();
    final data = json.decode(jsonStringFile);
    setState(() {
      _items = data["items"];
    });
  }


  void updateJsonValue() {
    // Path to the JSON file
    String filePath = 'C:/Users/Admin/Downloads/update_file.json';

    try {
      // Read the JSON file
      File jsonFile = File(filePath);
      Map<String, dynamic> jsonData = json.decode(jsonFile.readAsStringSync());

      // Update the value
      jsonData['name'] = 'Jane ';

      // Convert the updated JSON data to a string
      String jsonString = json.encode(jsonData);

      // Write the updated JSON string back to the file
      jsonFile.writeAsStringSync(jsonString);

      print('JSON value updated successfully!');
    } catch (e) {
      print('Error updating JSON value: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSV File Read'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // readCsv();
          readJsonFileFromExtStorage();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(3),
                    child: ListTile(
                      leading: Text(_items[index]['name'].toString()),
                    ),
                  );
                }),
          ),
          ElevatedButton(onPressed: (){
            updateJsonValue();
          }, child: Text('Update value'))
        ],
      ),
    );
  }
}
