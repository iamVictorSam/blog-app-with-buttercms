import 'dart:convert';
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

  Future retrieveBlogPost() async {
    try {
      final url =
          Uri.parse("https://api.buttercms.com/v2/posts?auth_token=$apiKey");

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
    retrieveBlogPost();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: const Center(child: Text('Home'))),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                          press: () =>
                              Get.to(() => BlogScreen(data: data[index])),
                        ))
              ]),
            )),
          );
  }
}
