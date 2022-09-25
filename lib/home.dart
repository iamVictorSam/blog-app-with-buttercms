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
    const postsEndpoint = "v2/posts";
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          const SizedBox(height: 15),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => BlogCard(
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
          // ...List.generate(
          //   data.length,
          //   (index) => BlogCard(
          //     image: data[index]['featured_image'],
          //     title: data[index]['title'],
          //     slug: data[index]['slug'],
          //     desc: data[index]['summary'],
          //     author:
          //         "${data[index]['author']['first_name']} ${data[index]['author']['last_name']}",
          //     authorImg: data[index]['author']['profile_image'],
          //     press: () => Get.to(() => BlogScreen(
          //           data: data[index],
          //         )),
          //   ),
          // ),
        ]),
      )),
    );
  }
}
