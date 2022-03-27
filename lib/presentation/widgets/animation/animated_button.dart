import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key? key,
    required void Function() onTap,
    String title = '',
  })  : _onTap = onTap,
        _title = title,
        super(key: key);

  final void Function() _onTap;
  final String _title;

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  late final List<Color> _colorList;
  late final List<Alignment> _alignmentList;
  late int _index;
  late Color _bottomColor;
  late Color _topColor;
  late Alignment _begin;
  late Alignment _end;

  @override
  void initState() {
    super.initState();
    _colorList = [
      Colors.blueAccent,
      Colors.yellow,
    ];
    if (_colorList.length < 2) {
      throw RangeError('_colorList length should be more than or equals 2');
    }

    _alignmentList = [
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.topRight,
      Alignment.topLeft,
    ];
    if (_alignmentList.length != 4) {
      throw RangeError('_alignmentList length should equals 4');
    }

    _index = 0;
    _bottomColor = _colorList.first;
    _topColor = _colorList.last;
    _begin = _alignmentList.first;
    _end = Alignment.topRight;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        _bottomColor = _colorList[_index + 1];
      });
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget._onTap,
        child: AnimatedContainer(
          height: 40.0,
          duration: const Duration(seconds: 2),
          onEnd: () {
            setState(() {
              _index++;
              // animate the color
              _bottomColor = _colorList[_index % _colorList.length];
              _topColor = _colorList[(_index + 1) % _colorList.length];

              // animate the alignment
              _begin = _alignmentList[_index % _alignmentList.length];
              _end = _alignmentList[(_index + 2) % _alignmentList.length];
            });
          },
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(begin: _begin, end: _end, colors: [_bottomColor, _topColor]),
          ),
          child: Center(
            child: AutoSizeText(
              widget._title,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}
