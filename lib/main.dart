import 'package:flutter/material.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/storage/storage_repo.dart';
import 'package:ids_list/ui/results_table.dart';
import 'package:ids_list/ui/select_storage.dart';

const int _kInitialKey = 4565400000000;
const int _kKeysNumber = 50000;
const int _kKeyToFind = 4567000000 + _kKeysNumber - 1;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fillTimeStr = '';
  String _searchTimeStr = '';
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();

    initDi();
  }

  @override
  void dispose() {
    disposeDi();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SelectStorage(),
            const SizedBox(height: 16),
            Text(
              'Fill time (µs): $_fillTimeStr',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Search time (µs): $_searchTimeStr',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SizedBox.square(
              dimension: 64,
              child:
                  _isBusy ? const CircularProgressIndicator() : const Align(),
            ),
            const ResultsTable(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _fillTimeStr = '';
            _searchTimeStr = '';
          });

          if (!di.isRegistered<StorageRepo>()) {
            return;
          }

          setState(() {
            _isBusy = true;
          });

          final StorageRepo repo = di<StorageRepo>();

          final List<String> values = List<String>.generate(
            _kKeysNumber,
            (int index) => (_kInitialKey + index).toString(),
          );

          final Stopwatch fillTime = Stopwatch();
          fillTime.start();
          await repo.fill(values);
          fillTime.stop();

          final Stopwatch searchTime = Stopwatch();
          searchTime.start();
          await repo.isPresent(_kKeyToFind.toString());
          searchTime.stop();

          setState(() {
            _fillTimeStr = fillTime.elapsed.inMicroseconds.toString();
            _searchTimeStr = searchTime.elapsed.inMicroseconds.toString();
            _isBusy = false;
          });
        },
        autofocus: true,
        child: const Icon(Icons.timer),
      ),
    );
  }
}
