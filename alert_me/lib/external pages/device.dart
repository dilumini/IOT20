import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Devide>> fetchPhotos(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://iotapplahiru.herokuapp.com'));
  // print(response);
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Devide> parsePhotos(String responseBody) {
  List fd = [];
  Map<String, dynamic> x = jsonDecode(responseBody);
  // print(x.keys);
  x.forEach((key, value) {
    // print(key);
    // print(value);
    fd.add(value);
  });
  final parsed = fd.cast<Map<String, dynamic>>();
  // print(parsed);
  return parsed.map<Devide>((json) => Devide.fromJson(json)).toList();
}

class Devide {
  final String temp;
  final String h;
  final String m;
  final String t;

  Devide({this.temp, this.m, this.h, this.t});

  factory Devide.fromJson(Map<String, dynamic> json) {
    return Devide(
      temp: json['temp'] as String,
      h: json['h'] as String,
      m: json['m'] as String,
      t: json['time'] as String,
    );
  }
}

class MyDevice extends StatefulWidget {
  @override
  _MyDeviceState createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 6,
          shape: ContinuousRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(90.0),
            ),
          ),
          title: Image.asset(
            "images/titile1.png",
            height: 80.0,
            width: 160.0,
          )),

      body: FutureBuilder<List<Devide>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          if (snapshot.hasData) {
            var fd =
                snapshot.data.where((element) => element.m == "1").toList();
            // print(fd);
            return ListView.builder(
                itemCount: fd.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueAccent,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${fd[index].t}",
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Temp: ${fd[index].temp}",
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              ),
                              Text(
                                "Humidity: ${fd[index].h}",
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (fd[index].m == "1")
                                  ? Text(
                                      "Motion detected",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.white),
                                    )
                                  : Text(
                                      "Motion not detected",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.white),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // body: Text("Hello"),
    );
  }
}
