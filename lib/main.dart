import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_flutter_bloc/blocs/counter/counter_bloc.dart';

import 'other_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'My Counter Bloc',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Counter Bloc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<CounterBloc, CounterState>(
          listener: (context, state) {
            if (state.counter == 3) {
              showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        content: Text('Counter is ${state.counter}'),
                      )));
            } else if (state.counter == -1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const OtherPage())));
            }
          },
          child: Center(
            child: Text(
              '${context.watch<CounterBloc>().state.counter}',
              style: const TextStyle(fontSize: 50.0),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context)
                  .add(IncrementCounterEvent());
            },
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
