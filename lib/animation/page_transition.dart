import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ListScreen(),
    ),
  );
}

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createRoute(title: 'Taj Mahal'));
          },
          child: SizedBox(
            height: 250,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/img1.jpg",
                    height: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 8),
                    child: Text(
                      'Taj Mahal',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute({required String title}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        DetailScreen(title: title),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(1.0, 1.0);
      // const begin = Offset(0.0, 1.0);
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Image.asset(
              "assets/img1.jpg",
              width: w,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'The Taj Mahal, is an Islamic ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1631 by the Mughal emperor Shah Jahan to house the tomb of his favourite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself.',
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ));
  }
}
