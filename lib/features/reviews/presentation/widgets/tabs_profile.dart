import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweetsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TweetsTabState();
  }
}

class TweetsTabState extends State<TweetsTab> {
  var elevationValue = 0.0;
  List<Map> tweetsList = [{}, {}, {}, {}];

  // Future _refresh() async{
  //   var list = await getTweets();
  //   setState(() {
  //     tweetsList.clear();
  //     tweetsList = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // _refresh();
      },
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
          itemCount: tweetsList.length,
          itemBuilder: (context, index) {
            var tweet = tweetsList[index];
            return GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TweetPage(tId: tweet.tId.toString())))
                //     .then((value) => setState(() {
                //   // _refresh();
                // }));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: elevationValue,
                    child: Text('Tweet Model'),
                  )),
            );
          }),
    );
  }

//   Future<List<TweetsModel>> getTweets() async {
//     int userId = await getTokenId();
//     final response =
//     await http.get(Uri.parse('$globalApiUrl/users/tweets?userId=${userId}'));
//     var data = jsonDecode(response.body);
//     tweetsList.clear();
//     if (response.statusCode == 200) {
//       for (Map i in data) {
//         tweetsList.add(TweetsModel.fromJson(i));
//       }
//       return tweetsList;
//     } else {
//       return tweetsList;
//     }
//   }
// }
}

class RepliesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RepliesTabState();
  }
}

class RepliesTabState extends State<RepliesTab> {
  var elevationValue = 0.0;
  List<Map> tweetsList = [{}, {}, {}, {}];

  // Future _refresh() async{
  //   var list = await getTweets();
  //   setState(() {
  //     tweetsList.clear();
  //     tweetsList = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // _refresh();
      },
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
          itemCount: tweetsList.length,
          itemBuilder: (context, index) {
            var tweet = tweetsList[index];
            return GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TweetPage(tId: tweet.tId.toString())))
                //     .then((value) => setState(() {
                //   // _refresh();
                // }));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: elevationValue,
                    child: Text('Tweet Model'),
                  )),
            );
          }),
    );
  }
}

class LikesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LikesTabState();
  }
}

class LikesTabState extends State<LikesTab> {
  var elevationValue = 0.0;
  List<Map> tweetsList = [{}, {}, {}, {}];

  // Future _refresh() async{
  //   var list = await getTweets();
  //   setState(() {
  //     tweetsList.clear();
  //     tweetsList = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // _refresh();
      },
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
          itemCount: tweetsList.length,
          itemBuilder: (context, index) {
            var tweet = tweetsList[index];
            return GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TweetPage(tId: tweet.tId.toString())))
                //     .then((value) => setState(() {
                //   // _refresh();
                // }));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: elevationValue,
                    child: Text('Tweet Model'),
                  )),
            );
          }),
    );
  }

// Future<List<TweetsModel>> getTweets() async {
//   int userId = await getTokenId();
//   final response =
//   await http.get(Uri.parse('$globalApiUrl/users/likes?userId=${userId}'));
//   var data = jsonDecode(response.body);
//   tweetsList.clear();
//   if (response.statusCode == 200) {
//     for (Map i in data) {
//       tweetsList.add(TweetsModel.fromJson(i));
//     }
//     return tweetsList;
//   } else {
//     return tweetsList;
//   }
// }
}
