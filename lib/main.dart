import 'package:flutter/material.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/logic/settings/settings.dart';
import 'package:ids_list/logic/table_data/table_data.dart';
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox.square(
                dimension: 64,
                child:
                    _isBusy ? const CircularProgressIndicator() : const Align(),
              ),
            ),
            const SelectStorage(),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ResultsTable(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
            _isBusy = false;
          });

          di<TableData>().addData(
            di<Settings>().state.storage,
            MeasurementDto(
              fill: fillTime.elapsed,
              search: searchTime.elapsed,
            ),
          );
        },
        autofocus: true,
        child: const Icon(Icons.timer),
      ),
    );
  }
}
