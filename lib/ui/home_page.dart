import 'package:flutter/material.dart';

import '../model/business_news.dart';
import '../network/business_news_api.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Future<BusinessNews>? news;

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView,)) {
      throw "Can not launch url";
    }
  }

  // Future<BusinessNews>? businessNews;
  // Future<BusinessNews>? businessNews;
  // Future<BusinessNews>? businessNews;

  List<Widget> widgetpages = [];

  @override
  void initState() {
    super.initState();
    // if (selectedIndex == 0) {
    // } else if (selectedIndex == 1) {
    //   businessNews = BusinessNewsAPI().FetchNews('Sports');
    // } else if (selectedIndex == 2) {
    //   businessNews = BusinessNewsAPI().FetchNews('Science');
    // } else if (selectedIndex == 3) {
    //   businessNews = BusinessNewsAPI().FetchNews('Entertainment');
    // } else if (selectedIndex == 4) {
    //   businessNews = BusinessNewsAPI().FetchNews('Health');
    // }
    news = BusinessNewsAPI().FetchNews('Business');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Headlines US'),
        ),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            currentIndex: selectedIndex,
            onTap: (i) {
              setState(() {
                selectedIndex = i;
              });

              if (selectedIndex == 0) {
                news = BusinessNewsAPI().FetchNews('Business');
              } else if (selectedIndex == 1) {
                news = BusinessNewsAPI().FetchNews('Sports');
              } else if (selectedIndex == 2) {
                news = BusinessNewsAPI().FetchNews('Science');
              } else if (selectedIndex == 3) {
                news = BusinessNewsAPI().FetchNews('Entertainment');
              } else {
                news = BusinessNewsAPI().FetchNews('Health');
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business_center_sharp), label: 'Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_kabaddi), label: 'Sports'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.airplanemode_active), label: 'Science'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.tv), label: 'Entertainment'),
              BottomNavigationBarItem(icon: Icon(Icons.chair), label: 'Health'),
            ]),
        body: FutureBuilder<BusinessNews>(
            future: news,
            builder: (context, AsyncSnapshot<BusinessNews> s) {
              if (s.hasData) {
                return ListView.builder(
                    itemCount: s.data!.articles!.length,

                    // gridDelegate:
                    //     const SliverGridDelegateWithFixedCrossAxisCount(
                    //         childAspectRatio: 0.57, crossAxisCount: 2),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          _launchURL('${s.data!.articles![i].url}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                boxShadow: [BoxShadow(blurRadius: 1)]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  '${s.data!.articles![i].urlToImage}',
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 5),
                                  child: Text(
                                    '${s.data!.articles![i].title}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (s.hasError) {
                return Text('${s.error}');
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

//import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// final Uri _url = Uri.parse('https://flutter.dev');
//
// void main() => runApp(
//       const MaterialApp(
//         home: Material(
//           child: Center(
//             child: ElevatedButton(
//               onPressed: _launchUrl,
//               child: Text('Show Flutter homepage'),
//             ),
//           ),
//         ),
//       ),
//     );
//
// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw 'Could not launch $_url';
//   }
// }
