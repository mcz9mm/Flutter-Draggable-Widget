import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset _offset = const Offset(100, 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DragArea(
              callback: (Offset offset) {
                setState(() => _offset = offset);
              },
              child: Container(
                color: Colors.cyan,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            left: _offset.dx,
            top: _offset.dy,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Positioned(
            left: 90,
            top: 40,
            child: Center(
              child: Text(
                '$_offset',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DragArea extends StatefulWidget {
  final Widget child;
  final Function(Offset) callback;

  const DragArea({
    Key? key,
    required this.child,
    required this.callback,
  }) : super(key: key);

  @override
  DragAreaState createState() => DragAreaState();
}

class DragAreaState extends State<DragArea> {
  Offset position = const Offset(100, 100);
  void updatePosition(Offset newPosition) {
    setState(() => position = newPosition);
    widget.callback(position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.cyan.withOpacity(.4))),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              maxSimultaneousDrags: 1,
              feedback: widget.child,
              childWhenDragging: Opacity(
                opacity: .3,
                child: widget.child,
              ),
              onDragEnd: (details) => updatePosition(details.offset),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
