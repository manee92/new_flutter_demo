import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
        child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCounter(),
    );
  }
}



class MyCounter extends ConsumerWidget {
  final counterStateProvider = StateProvider<int>((ref){
    return 0;
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print("build");
    final counter = watch(counterStateProvider);

    return ProviderListener<StateController<int>>(
        onChange: (context, counterState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Value${counterState.state}'))
          );
        },
        provider: counterStateProvider,
        child: Scaffold(
          body: Center(
            child: Text('Value: ${counter.state}'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()=> context.read(counterStateProvider).state++,
            child: Icon(Icons.add),
          ),
        )
    );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Center(
    //       child: Text('Value: ${counter.state}'),
    //     ),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: ()=> context.read(counterStateProvider).state++,
    //       child: Icon(Icons.add),
    //     ),
    //   ),
    // );
  }
}


class Clock extends StateNotifier<DateTime> {

  Clock():super (DateTime.now()){
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      state =DateTime.now();
    });
  }

  late final Timer _timer;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}