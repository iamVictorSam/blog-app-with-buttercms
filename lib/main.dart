import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blog_app/api/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'secret_key.dart';

import 'api/blog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: Get.height * 0.5,
      backgroundColor: Colors.black,
      splash: Image.asset('assets/logo.png'),
      nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Butter butter = Butter("08074ef496b7521de3aa69ae56875163ac0b1671");
  final api = ProductApi();
  List data = [];

  // static const String _apiKey = '08074ef496b7521de3aa69ae56875163ac0b1671';

  Future retrieve() async {
    const postsEndpoint = "v2/posts";
    try {
      final url = Uri.parse("${Base.baseUrl}/v2/posts?auth_token=$apiKey");

      //https://api.buttercms.com/v2/posts/?auth_token=08074ef496b7521de3aa69ae56875163ac0b1671&exclude_body=true

      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        setState(() {
          data = result['data'] as List;
          print(data[0]['status']);
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
          ...List.generate(
            data.length,
            (index) => BlogCard(
              image: data[index]['featured_image'],
              title: data[index]['title'],
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

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key, required this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    print(data['body']);
    var date = DateTime.parse(data['updated']);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: NetworkImage(data['featured_image'])),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data['author']['profile_image']),
                    ),
                    title: Text(
                      "${data['author']['first_name']} ${data['author']['last_name']}",
                      style: TextStyle(
                          color: Colors.teal[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      date.toString(),
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(data['title'],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Html(data: """
                ${data['body']}
                """),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      required this.author,
      required this.authorImg,
      required this.press});

  final String image, title, desc, author, authorImg;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7), // boxShadow: [
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(185, 181, 181, 182),
              offset: Offset(1.0, 5.0),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image),
            // const FlutterLogo(
            //   size: 150,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      // backgroundImage: NetworkImage(authorImg),
                      radius: 20,
                      backgroundImage: NetworkImage(authorImg),
                    ),
                    title: Text(
                      author,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
