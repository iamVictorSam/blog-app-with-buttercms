import 'dart:convert';

import 'package:blog_app/api/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'blog_card.dart';
import 'blog_screen.dart';
import 'secret_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  bool isLoading = true;

  Future retrieve() async {
    try {
      final url = Uri.parse("${Base.baseUrl}/v2/posts?auth_token=$apiKey");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        setState(() {
          data = result['data'] as List;
          isLoading = false;
        });
        return result;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    retrieve();
    // print(data.data);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              // actions: [
              //   IconButton(
              //       onPressed: () => showSearch(
              //             context: context,
              //             delegate: SearchPage(
              //               onQueryUpdate: print,
              //               items: data,
              //               searchLabel: 'Search Blog',
              //               suggestion: const Center(
              //                 child: Text('Filter blog by tag'),
              //               ),
              //               failure: const Center(
              //                 child: Text('No blog found :('),
              //               ),
              //               filter: (blog) => blog['tags'][0]['name'],
              //               // sort: (a, b) => a.compareTo(b),
              //               builder: (blog) => BlogCard(
              //                 image: data[blog]['featured_image'],
              //                 title: data[blog]['title'],
              //                 slug: data[blog]['slug'],
              //                 desc: data[blog]['summary'],
              //                 author:
              //                     "${data[blog]['author']['first_name']} ${data[blog]['author']['last_name']}",
              //                 authorImg: data[blog]['author']['profile_image'],
              //                 press: () => Get.to(() => BlogScreen(
              //                       data: data[blog],
              //                     )),
              //               ),
              //             ),
              //           ),
              //       icon: const Icon(Icons.search))
              // ],
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [
                const SizedBox(height: 15),
                ...List.generate(
                  data.length,
                  (index) => BlogCard(
                    image: data[index]['featured_image'],
                    title: data[index]['title'],
                    slug: data[index]['slug'],
                    desc: data[index]['summary'],
                    author:
                        "${data[index]['author']['first_name']} ${data[index]['author']['last_name']}",
                    authorImg: data[index]['author']['profile_image'],
                    press: () => Get.to(() => BlogScreen(
                          data: data[index],
                        )),
                  ),
                ),
              ]),
            )),
          );
  }
}
