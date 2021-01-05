import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jinong_news/account.dart';
import 'package:jinong_news/filtered_page.dart';
import 'package:jinong_news/saved_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Jinong App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var _pages = [
    home(),
    saved_page(),
    filtered_page(),
    account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(
          '지농 뉴스',
          // style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
            tooltip: '키워드 검색',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('홈'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('스크랩'),
            icon: Icon(Icons.turned_in_not),
          ),
          BottomNavigationBarItem(
            title: Text('필터링 기사'),
            icon: Icon(Icons.filter_alt_outlined),
          ),
          BottomNavigationBarItem(
            title: Text('계정'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

// Home Tab
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  //url_launcher
  launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
  }

  launchWebView(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    }
  }

  launchUniversalForIos(String url) async {
    if (await canLaunch(url)) {
      final bool succeeded =
          await launch(url, forceSafariVC: false, universalLinksOnly: true);
      if (!succeeded) {
        await launch(url, forceSafariVC: true);
      }
    }
  }

  //url_launcher

  //News contents
  List<String> article_title = [
    '“단감 저장·유통방식, ‘봉지→알감’으로 전환해야”',
    '농민들의 앱',
    '짱이다'
  ];
  List<String> article_source = ['농어민신문', '농어민신문', '네이버'];
  var article_date = [
    '2020-12-29',
    '2020-12-29',
    '2020-12-29',
  ];
  var urls = [
    "http://www.agrinet.co.kr/news/articleView.html?idxno=181784",
    "https://www.google.com",
    "https://www.google.com"
  ];

  //News contents

  @override
  Widget build(BuildContext context) {
    //Saved_articles
    final _saved = Set();
    // final Set _saved_articles = Set();
    //Saved_articles
    var alreadySaved = _saved.contains(article_title);

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: article_title.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text('${article_title[index]}'),
        onTap: () => setState(() {
          launchWebView('${urls[index]}');
        }),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${article_source[index]}'),
            Text('${article_date[index]}'),
          ],
        ),
        trailing: Icon(
          alreadySaved ? Icons.star : Icons.star_border,
          color: alreadySaved ? Colors.grey : null,
        ),
        isThreeLine: true,
        // onTap: () => setState(() {
        //   if (alreadySaved) {
        //     _saved.remove(article_title);
        //   } else {
        //     _saved.add(article_title);
        //   }
        // }),
      ),
    );
  }
}

// // 별표 누르기 기능 추가했으나 안됨/
//
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:jinong_news/account.dart';
// import 'package:jinong_news/filtered_page.dart';
// import 'package:jinong_news/saved_page.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Jinong App'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//   var _pages = [
//     home(),
//     saved_page(),
//     filtered_page(),
//     account(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.white,
//         title: Text(
//           '지농 뉴스',
//           // style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () => {},
//             tooltip: '키워드 검색',
//           ),
//         ],
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.blueGrey,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white.withOpacity(.60),
//         selectedFontSize: 14,
//         unselectedFontSize: 14,
//         currentIndex: _selectedIndex,
//         //현재 선택된 Index
//         onTap: (int index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             title: Text('홈'),
//             icon: Icon(Icons.home),
//           ),
//           BottomNavigationBarItem(
//             title: Text('스크랩'),
//             icon: Icon(Icons.turned_in_not),
//           ),
//           BottomNavigationBarItem(
//             title: Text('필터링 기사'),
//             icon: Icon(Icons.filter_alt_outlined),
//           ),
//           BottomNavigationBarItem(
//             title: Text('계정'),
//             icon: Icon(Icons.person),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Home Tab
// class home extends StatefulWidget {
//   @override
//   _homeState createState() => _homeState();
// }
//
// class _homeState extends State<home> {
//   //url_launcher
//   launchBrowser(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url, forceSafariVC: false, forceWebView: false);
//     }
//   }
//
//   launchWebView(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url, forceSafariVC: true, forceWebView: true);
//     }
//   }
//
//   launchUniversalForIos(String url) async {
//     if (await canLaunch(url)) {
//       final bool succeeded =
//       await launch(url, forceSafariVC: false, universalLinksOnly: true);
//       if (!succeeded) {
//         await launch(url, forceSafariVC: true);
//       }
//     }
//   }
//
//   //url_launcher
//
//   //News contents
//   List<String> article_title = [
//     '“단감 저장·유통방식, ‘봉지→알감’으로 전환해야”',
//     '농민들의 앱',
//     '짱이다'
//   ];
//   List<String> article_source = ['농어민신문', '농어민신문', '네이버'];
//   var article_date = [
//     '2020-12-29',
//     '2020-12-29',
//     '2020-12-29',
//   ];
//   var urls = [
//     "http://www.agrinet.co.kr/news/articleView.html?idxno=181784",
//     "https://www.google.com",
//     "https://www.google.com"
//   ];
//
//   //News contents
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: const EdgeInsets.all(8),
//       itemCount: article_title.length,
//       itemBuilder: (BuildContext context, int index) {
//
//         //Saved_articles
//         String favorite_article = article_title[index];
//         var _saved_index = Set<String>();
//         bool alreadySaved = _saved_index.contains(favorite_article);
//         //Saved_articles
//
//         return Container(
//           height: 100,
//           color: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     child: Text(
//                       '[지농 뉴스] ${article_title[index]}',
//                       // style: Theme.of(context).textTheme.headline,
//                     ),
//                     onTap: () => setState(() {
//                       launchWebView('${urls[index]}');
//                     }),
//                   ),
//                   InkWell(
//                     child: Text('${article_source[index]}'),
//                     onTap: () => setState(() {
//                       launchWebView('${urls[index]}');
//                     }),
//                   ),
//                   InkWell(
//                     child: Text('${article_date[index]}'),
//                     onTap: () => setState(() {
//                       launchWebView('${urls[index]}');
//                     }),
//                   ),
//                 ],
//               ),
//               InkWell(
//                 child: Icon(
//                   alreadySaved ? Icons.star : Icons.star_border,
//                   color: alreadySaved ? Colors.red : null,
//                 ),
//                 onTap: () => setState(() {
//                   if (alreadySaved) {
//                     _saved_index.remove(favorite_article);
//                   } else {
//                     _saved_index.add(favorite_article);
//                   }
//                 }),
//               ),
//             ],
//           ),
//         );
//       },
//       separatorBuilder: (BuildContext context, int index) => const Divider(),
//     );
//   }
// }
