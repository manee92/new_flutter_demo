import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class BulbState extends ChangeNotifier {
  var isOn = false;

  void changeBulb() {
    isOn = !isOn;
    notifyListeners();
  }
}

final bulbStateNotifier =
    ChangeNotifierProvider<BulbState>((ref) => BulbState());

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bulbState = ref.watch(bulbStateNotifier);

    return Scaffold(
        appBar: AppBar(title: const Text('Riverpod example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              bulbState.isOn
                  ? const Icon(
                      Icons.lightbulb,
                      size: 150,
                      color: Colors.amberAccent,
                    )
                  : const Icon(
                      Icons.lightbulb_outline,
                      size: 150,
                      color: Colors.amberAccent,
                    ),
              Switch(
                value: bulbState.isOn,
                onChanged: (enabled) {
                  ref.read(bulbStateNotifier).changeBulb();
                },
              )
            ],
          ),
        ));
  }
}
