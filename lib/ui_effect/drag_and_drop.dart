import 'package:flutter/material.dart';

void main() async {
  runApp(const FruitGame());
}

class FruitGame extends StatelessWidget {
  const FruitGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Drag and Drop",
      home: FruitSelectApp(),
    );
  }
}

class FruitSelectApp extends StatefulWidget {
  const FruitSelectApp({Key? key}) : super(key: key);

  @override
  _FruitSelectAppState createState() => _FruitSelectAppState();
}

class _FruitSelectAppState extends State<FruitSelectApp> {
  void _itemNameDroppedOnImage({
    required FruitImage fruitImage,
    required FruitItem fruitItem,
  }) {
    if (fruitImage.name == fruitItem.name) {
      setState(() {
        fruitImage.isCorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag and Drop"),
        centerTitle: false,
        backgroundColor: const Color(0xFF32a852),
      ),
      body: Row(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: fruitNameList.length,
            itemBuilder: (context, index) {
              FruitItem item = fruitNameList[index];
              return Draggable<FruitItem>(
                  data: item,
                  dragAnchorStrategy: pointerDragAnchorStrategy,
                  feedback: FruitNameCard(item: item),
                  child: FruitNameCard(item: item));
            },
          )),
          Expanded(
              child: ListView.builder(
            itemCount: fruitImages.length,
            itemBuilder: (context, index) {
              return buildFruitImageColumn(fruitImages[index]);
            },
          )),
        ],
      ),
    );
  }

  Widget buildFruitImageColumn(FruitImage fruitImage) {
    return DragTarget<FruitItem>(
      builder: (context, acceptedItems, rejectedItems) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FruitImagesView(
            fruitImage: fruitImage,
            highlighted: acceptedItems.isNotEmpty,
          ),
        );
      },
      onAccept: (item) {
        _itemNameDroppedOnImage(fruitImage: fruitImage, fruitItem: item);
      },
    );
  }
}

class FruitNameCard extends StatelessWidget {
  const FruitNameCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FruitItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 140,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(20),
      child: Text(
        item.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
      ),
    );

  }
}

class FruitImagesView extends StatelessWidget {
  const FruitImagesView({
    Key? key,
    required this.fruitImage,
    this.highlighted = false,
  }) : super(key: key);

  final FruitImage fruitImage;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.white : Colors.black87;

    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8.0 : 4.0,
        borderRadius: BorderRadius.circular(18.0),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(fruitImage.image),
                fit: BoxFit.cover,
                height: 60,
              ),
              const SizedBox(height: 8.0),
              Visibility(
                visible: fruitImage.isCorrect,
                child: Text(
                  fruitImage.name,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: textColor,
                        fontWeight: fruitImage.isCorrect
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<FruitItem> fruitNameList = [
  FruitItem(name: 'Grapes', id: 1, color: Color(0xFFcf8c82)),
  FruitItem(name: 'Apple', id: 1, color: Color(0xFFFF9C99)),
  FruitItem(name: 'Mango', id: 1, color: Color(0xFFdcccff)),
  FruitItem(name: 'Strawberry', id: 1, color: Color(0xFF8ac2ed)),
  FruitItem(name: 'Banana', id: 1, color: Color(0xFFfcf000)),
];

List<FruitImage> fruitImages = [
  FruitImage(name: 'Apple', image: "assets/apple.png"),
  FruitImage(name: 'Banana', image: "assets/banana.png"),
  FruitImage(name: 'Grapes', image: "assets/grape.png"),
  FruitImage(name: 'Mango', image: "assets/mango.png"),
  FruitImage(name: 'Strawberry', image: "assets/strawberry.png"),
];

class FruitItem {
  const FruitItem({
    required this.name,
    required this.id,
    required this.color,
  });
  final int id;
  final String name;
  final Color color;
}

class FruitImage {
  FruitImage({required this.name, required this.image, this.isCorrect = false});

  final String name;
  final String image;
  bool isCorrect;
}
