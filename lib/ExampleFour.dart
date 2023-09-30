// ignore_for_file: must_be_immutable

// JSON DATA WITHOUT MNODEL

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExamleFour extends StatefulWidget {
  const ExamleFour({super.key});

  @override
  State<ExamleFour> createState() => _ExamleFourState();
}

class _ExamleFourState extends State<ExamleFour> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('API'))),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(children: [
                            ReuseableRow(
                                title: 'Name',
                                value: data[index]['name'].toString()),
                            ReuseableRow(
                                title: 'UserName',
                                value: data[index]['username'].toString()),
                            ReuseableRow(
                                title: 'Email',
                                value: data[index]['email'].toString()),
                            ReuseableRow(
                                title: 'Address',
                                value: data[index]['address']['street']
                                    .toString()),
                            ReuseableRow(
                                title: 'Lat',
                                value: data[index]['address']['geo']['lat']
                                    .toString()),
                            ReuseableRow(
                                title: 'Lng',
                                value: data[index]['address']['geo']['lng']
                                    .toString()),
                          ]),
                        );
                      });
                }
              }),
        )
      ]),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
