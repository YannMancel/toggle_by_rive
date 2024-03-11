import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() => runApp(const MyApp());

const kAppName = 'Toggle by Rive';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: kAppName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool _isSelected;
  late StateMachineController _controller;

  set _toggleValue(bool isSelected) {
    final toggle = _controller.findInput<bool>('IsSelected');
    if (toggle != null && mounted) {
      toggle.value = isSelected;
      setState(() => _isSelected = isSelected);
    }
  }

  @override
  void initState() {
    super.initState();
    _isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _toggleValue = !_isSelected,
          child: RiveAnimation.asset(
            'assets/toggle.riv',
            artboard: 'toggle',
            onInit: (artboard) {
              _controller = StateMachineController.fromArtboard(
                artboard,
                'Animation',
              )!;
              artboard.addController(_controller);
              _toggleValue = _isSelected;
            },
          ),
        ),
      ),
    );
  }
}
