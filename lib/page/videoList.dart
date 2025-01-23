import 'package:bilu2/page/videoPage.dart';
import 'package:bilu2/provider/videoProvider.dart';
import 'package:bilu2/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _loadBannerAd();
    super.initState();
    _fetchVideos();
  }

  void _fetchVideos() {
    final videoProvider = Provider.of<VideoProvider>(context, listen: false);
    videoProvider.fetchVideos(); 
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-7987994707204046/3547451662', 
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Failed to load a banner ad: ${error.message}');
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightPurple,
        title: Text('Video Pembelajaran',
            style: semiBoldTextStyle.copyWith(color: blackcolor, fontSize: 18)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: videoProvider.videos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(10)),
                      height: 100,
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(
                          videoProvider.videos[index]['title'],
                          style: semiBoldTextStyle.copyWith(
                              color: blackcolor, fontSize: 16),
                        ),
                        subtitle:
                            Text(videoProvider.videos[index]['description']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                title: videoProvider.videos[index]['title'],
                                idVideo: videoProvider.videos[index]['url'],
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
          if (_isBannerAdReady)
            Container(
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),
    );
  }
}

