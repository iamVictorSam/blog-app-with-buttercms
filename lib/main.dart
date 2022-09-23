import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            5,
            (index) => BlogCard(
              image: 'image',
              title: 'headline6',
              desc: 'desc',
              author: 'author',
              authorImg: 'authorImg',
              press: () => Get.to(() => const BlogScreen()),
            ),
          ),
        ]),
      )),
    );
  }
}

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image(image: NetworkImage('url')),
            const FlutterLogo(
              size: 250,
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(),
                    title: Text(
                      'Author',
                      style: TextStyle(
                          color: Colors.teal[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'date',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      'Creating an Ecommerce App with Flutter and Medusa',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                      'Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services.Medusa is an open source headless commence that allows users to build scalable and unique e-commerce stores and set up products seamlessly. It aids developers to build, manage and customize APIs fast and efficiently.Medusa comes with a lot of features among which are, an easy-to-use admin panel, it is free to use, has lots of plugins for different operations, and a large community support.This tutorial will demonstrate how to communicate with Medusa backend services from a Flutter application while building an e-commerce store. Medusa will handle our product creation. At the end of this tutorial, you will learn how to use Medusa to handle backend services.Below is a link to the source code for the complete flutter app',
                      style: TextStyle(fontSize: 18)),
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
            // Image.network(image),
            const FlutterLogo(
              size: 150,
            ),
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
                    leading: const CircleAvatar(
                      // backgroundImage: NetworkImage(authorImg),
                      radius: 20,
                      // backgroundImage: NetworkImage(authorImg),
                      child: FlutterLogo(),
                    ),
                    title: Text(
                      title,
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
