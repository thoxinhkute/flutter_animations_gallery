import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/page_scaffold.dart';
import 'package:flutter_animations_gallery/samples/curves.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedPositionedPage extends ConsumerStatefulWidget {
  const AnimatedPositionedPage({Key? key}) : super(key: key);

  @override
  _AnimatedPositionedPageState createState() => _AnimatedPositionedPageState();
}

class _AnimatedPositionedPageState
    extends ConsumerState<AnimatedPositionedPage> {
  late Offset _playerAlignment = Offset(0, 0);

  // This method contains most of the game logic
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _playerAlignment = Offset(
        details.localPosition.dx,
        details.localPosition.dy,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final curve = ref.watch(curveProvider);
    return PageScaffold(
      title: 'AnimatedPositioned',
      body: Stack(
        children: [
          // Handle taps anywhere
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) => _handleTapDown(details),
            ),
          ),
          // Player
          AnimatedPositioned(
            left: _playerAlignment.dx - 50,
            top: _playerAlignment.dy - 50,
            duration: Duration(milliseconds: 250),
            curve: curve,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}