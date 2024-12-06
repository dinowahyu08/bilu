import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For controlling device orientation
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String idVideo;

  VideoPlayerScreen({required this.title, required this.idVideo});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late WebViewController _controller;
  late String videoUrl;

  @override
  void initState() {
    super.initState();

    // Construct video URL with the provided idVideo
    videoUrl = "https://www.youtube.com/embed/${widget.idVideo}?autoplay=1&controls=1&showinfo=0&rel=0&modestbranding=1";
    print('$videoUrl');
    // Set the device to landscape mode when the page opens
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Initialize WebViewController and load the video URL
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(videoUrl));
  }

  @override
  void dispose() {
    // Reset the device orientation back to portrait mode when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightPurple,
          title: Text(
            widget.title,
            style: semiBoldTextStyle.copyWith(color: blackcolor, fontSize: 18),
          ),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
