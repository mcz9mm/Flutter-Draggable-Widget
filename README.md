# Flutter-Draggable-Widget

## Ref
widget-in-flutter-such-that-is-stays-at-the-position-it?answertab=trending#tab-top

## 🎥
![Jul-06-2022 10-23-34](https://user-images.githubusercontent.com/11751495/177447408-e7bf2b7a-8726-476b-b6f9-6616f4e40cb2.gif)

## Usage

```
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
```


```
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
```
