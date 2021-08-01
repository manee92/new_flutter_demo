import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:async';
// import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String? base64Image;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    convertTheImage();
  }

    Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    // print(response.bodyBytes);
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  convertTheImage() async{
    final imgBase64Str = await networkImageToBase64("http://eyesofwild.com/wp-content/uploads/photo-gallery/imported_from_media_libray/yja18-7.jpg");
    print(imgBase64Str);
    base64Image = imgBase64Str!;
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  // ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Running on: $_platformVersion\n',
                  textAlign: TextAlign.center,
                ),
                // RaisedButton(
                //   onPressed: () async {
                //     File file = await ImagePicker.pickImage(
                //       source: ImageSource.gallery,
                //     );
                //     SocialShare.shareInstagramStory(
                //       file.path,
                //       backgroundTopColor: "#ffffff",
                //       backgroundBottomColor: "#000000",
                //       attributionURL: "https://deep-link-url",
                //     ).then((data) {
                //       print(data);
                //     });
                //   },
                //   child: Text("Share On Instagram Story"),
                // ),
                // RaisedButton(
                //   onPressed: () async {
                //     await screenshotController.capture().then((image) async {
                //       SocialShare.shareInstagramStory(
                //         image.path,
                //         backgroundTopColor: "#ffffff",
                //         backgroundBottomColor: "#000000",
                //         attributionURL: "https://deep-link-url",
                //         backgroundImagePath: image.path,
                //       ).then((data) {
                //         print(data);
                //       });
                //     });
                //   },
                //   child: Text("Share On Instagram Story with background"),
                // ),
                // RaisedButton(
                //   onPressed: () async {
                //     await screenshotController.capture().then((image) async {
                //       //facebook appId is mandatory for andorid or else share won't work
                //       Platform.isAndroid
                //           ? SocialShare.shareFacebookStory(
                //         image.path,
                //         "#ffffff",
                //         "#000000",
                //         "https://google.com",
                //         appId: "xxxxxxxxxxxxx",
                //       ).then((data) {
                //         print(data);
                //       })
                //           : SocialShare.shareFacebookStory(
                //         image.path,
                //         "#ffffff",
                //         "#000000",
                //         "https://google.com",
                //       ).then((data) {
                //         print(data);
                //       });
                //     });
                //   },
                //   child: Text("Share On Facebook Story"),
                // ),
                // RaisedButton(
                //   onPressed: () async {
                //     SocialShare.copyToClipboard(
                //       "This is Social Share plugin",
                //     ).then((data) {
                //       print(data);
                //     });
                //   },
                //   child: Text("Copy to clipboard"),
                // ),
                TextButton(
                  onPressed: () async {
                    SocialShare.shareTwitter(
                      "This is Social Share twitter example",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on twitter"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareSms(
                      "This is Social Share Sms example",
                      url: "\nhttps://google.com/",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Sms"),
                ),
                // RaisedButton(
                //   onPressed: () async {
                //     await screenshotController.capture().then((image) async {
                //       SocialShare.shareOptions("Hello world").then((data) {
                //         print(data);
                //       });
                //     });
                //   },
                //   child: Text("Share Options"),
                // ),
                TextButton(
                  onPressed: () async {
                    SocialShare.shareWhatsapp(
                      "Hello World \n $base64Image",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Whatsapp"),
                ),
                TextButton(
                  onPressed: () async {
                    SocialShare.shareTelegram(
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Telegram"),
                ),
                TextButton(
                  onPressed: () async {
                    SocialShare.checkInstalledAppsForShare().then((data) {
                      print(data.toString());
                    });
                  },
                  child: Text("Get all Apps"),
                ),
              ],
            ),
          ),
        ),

    );
  }
}