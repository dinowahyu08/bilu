import 'package:bilu2/page/videoPage.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for rootBundle
import 'dart:convert';
import 'package:http/http.dart' as http;


class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<dynamic> _videos = [];

  @override
  void initState() {
    super.initState();
    fetchVideos(); // Memanggil fungsi untuk mengambil data video
  }

  Future<void> fetchVideos() async {
  try {
    // Fetch JSON data from server
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/videos.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        _videos = data['videos']; // Store video data in state
      });
    } else {
      print("Failed to load videos: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching videos: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: lightPurple,title: Text('Video Pembelajaran',style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 18))),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: ListView.builder(
            itemCount: _videos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0,5,0,5),
                child: Container(
                  decoration: BoxDecoration(color: lightPurple,borderRadius: BorderRadius.circular(10)),
                  height: 100,
                  alignment: Alignment.center,
                  child: ListTile(
                    title: Text(_videos[index]['title'],style: semiBoldTextStyle.copyWith(color: blackcolor,fontSize: 16),),
                    subtitle: Text(_videos[index]['description']),
                    onTap: () {
                      // Navigasi ke VideoPlayerScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            title: _videos[index]['title'],
                            idVideo: _videos[index]['url'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
