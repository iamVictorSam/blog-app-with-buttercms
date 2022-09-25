import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard(
      {super.key,
      required this.image,
      required this.title,
      required this.desc,
      required this.author,
      required this.authorImg,
      required this.slug,
      required this.press});

  final String image, title, desc, author, authorImg, slug;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
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
            Hero(tag: slug, child: Image.network(image)),
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
                    desc,
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
