import 'dart:convert';

//import 'package:api/Models/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class exampleTwo extends StatefulWidget {
  const exampleTwo({super.key});

  @override
  State<exampleTwo> createState() => _exampleTwoState();
}

class _exampleTwoState extends State<exampleTwo> {
  List<Photos> photoslist = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photoslist.add(photos);
      }
      setState(() {});
      return photoslist;
    } else {
      return photoslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('API')),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getPhotos(),
            builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
              return ListView.builder(
                itemCount: photoslist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    subtitle: Text(snapshot.data![index].title.toString()),
                    title: Text(
                        'Notes id:\n' + snapshot.data![index].title.toString()),
                  );
                },
              );
            },
          ),
        )
      ]),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.id, required this.title, required this.url});
}
