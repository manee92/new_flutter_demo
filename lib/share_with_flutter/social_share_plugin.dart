// // 1775065516014138
// // 2a8ecd6494dd1e49e975408ff9317fff
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter_share_me/flutter_share_me.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(
//       MyApp()
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ShareWithImage(),
//     );
//   }
// }
//
//
// class ShareWithImage extends StatefulWidget {
//   @override
//   _ShareWithImageState createState() => _ShareWithImageState();
// }
//
// class _ShareWithImageState extends State<ShareWithImage> {
//   late String base64Image;
//
//   // getImage(){
//   //   List<int> imageBytes = file.readAsBytesSync();
//   //   String base64Image = base64Encode(imageBytes);
//   // }
//
//   Future<String?> networkImageToBase64(String imageUrl) async {
//     http.Response response = await http.get(Uri.parse(imageUrl));
//     // print(response.bodyBytes);
//     final bytes = response.bodyBytes;
//     return base64Encode(bytes);
//   }
//
//   convertTheImage() async{
//     final imgBase64Str = await networkImageToBase64("http://eyesofwild.com/wp-content/uploads/photo-gallery/imported_from_media_libray/yja18-7.jpg");
//     print(imgBase64Str);
//     base64Image = imgBase64Str!;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     print("init");
//     convertTheImage();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: Column(
//           children: [
//             TextButton(
//               child: Text('share to WhatsApp'),
//               onPressed: () {
//                 print("PRESSED");
//                 FlutterShareMe()
//                     .shareToWhatsApp(base64Image: base64Image, msg: "Hi This is a test");
//               },
//             ),
//           ],
//         ),
//
//       ),
//     );
//   }
// }

