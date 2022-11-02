import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late FlutterGifController controller1;
  bool isSending = true;

  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    moveFiles();
    super.initState();
  }

  moveFiles() {
    controller1.repeat(
      min: 0,
      max: 18,
      period: const Duration(milliseconds: 2000),
    );
    //moving files and stop showing gif in the screen
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        isSending = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("GIF Demo", style: TextStyle(color: Colors.black)),
      ),
      body: isSending
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GifImage(
                    controller: controller1,
                    width: 200,
                    height: 400,
                    image: const AssetImage("assets/moving-files.gif"),
                  ),
                ],
              ),
            )
          : ColoredBox(
              color: const Color(0xff9c9cfb),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "File moving completed",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xff9c9cfb),
                        ),
                        child: const Text("Go Back"))
                  ],
                ),
              ),
            ),
    );
  }
}
