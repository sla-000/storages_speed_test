import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ids_list/di/di.dart';
import 'package:ids_list/logic/settings/settings.dart';
import 'package:ids_list/logic/table_data/table_data.dart';
import 'package:ids_list/storage/storage_repo.dart';
import 'package:ids_list/ui/results_table.dart';
import 'package:ids_list/ui/select_storage.dart';

const int _kInitialKey = 4565486300000;
const int _kKeysNumber = 10000;

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
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Center(
                      child: SizedBox(
                        width: 350,
                        child: SelectStorage(enabled: !_isBusy),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: ResultsTable(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox.square(
              dimension: 128,
              child:
                  _isBusy ? const CircularProgressIndicator() : const Align(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isBusy
            ? null
            : () async {
                if (!di.isRegistered<StorageRepo>()) {
                  return;
                }

                setState(() {
                  _isBusy = true;
                });

                late final StorageRepo repo;

                try {
                  repo = di<StorageRepo>();

                  await repo.init();

                  final math.Random rand =
                      math.Random(DateTime.now().microsecondsSinceEpoch);

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
                  bool found = true;
                  for (int i = 0; i < 1000; ++i) {
                    final int key = _kInitialKey + rand.nextInt(_kKeysNumber);
                    if (!await repo.isPresent(key.toString())) {
                      found = false;
                    }
                  }
                  searchTime.stop();

                  di<TableData>().addData(
                    di<Settings>().state.storage,
                    MeasurementDto(
                      fill: fillTime.elapsed,
                      search: found ? searchTime.elapsed : Duration.zero,
                      size: await repo.dbSize(),
                    ),
                  );
                } on Exception catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: $error'),
                  ));
                } finally {
                  await repo.dispose();

                  setState(() {
                    _isBusy = false;
                  });
                }
              },
        autofocus: true,
        child: const Icon(Icons.timer),
      ),
    );
  }
}
