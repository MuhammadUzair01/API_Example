import 'dart:convert';

//import 'package:api/Models/post_model.dart';
import 'package:api/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('API'))),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseRow(
                                      title: 'Name',
                                      value: snapshot.data![index].name
                                          .toString()),
                                  ReuseRow(
                                      title: 'UserName',
                                      value: snapshot.data![index].username
                                          .toString()),
                                  ReuseRow(
                                      title: 'Email',
                                      value: snapshot.data![index].email
                                          .toString()),
                                  ReuseRow(
                                      title: 'Address',
                                      value: snapshot.data![index].address!.city
                                              .toString() +
                                          snapshot
                                              .data![index].address!.geo!.lat
                                              .toString())
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }))
      ]),
    );
  }
}

// ignore: must_be_immutable
class ReuseRow extends StatelessWidget {
  String title, value;
  ReuseRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value)]),
    );
  }
}
