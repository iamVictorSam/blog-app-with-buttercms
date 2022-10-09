import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data['updated']);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat('MM/dd/yyyy hh:mm a').format(inputDate);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Hero(
                tag: data['slug'],
                child: Image(
                    image: NetworkImage(data['featured_image']),
                    fit: BoxFit.cover,
                    width: Get.width)),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(data['author']['profile_image']),
                        ),
                        title: Text(
                            "${data['author']['first_name']} ${data['author']['last_name']}",
                            style: const TextStyle(
                                // color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(outputDate,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                            ))),
                    const SizedBox(height: 10),
                    Text(data['title'],
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    Html(
                        data: """
                ${data['body']}
                """,
                        onLinkTap: (String? url,
                            RenderContext context,
                            Map<String, String> attributes,
                            dom.Element? element) async {
                          await _launchURL(url);
                        }),
                  ],
                ))
          ],
        )));
  }

  _launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
