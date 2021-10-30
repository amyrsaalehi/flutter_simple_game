import 'package:flutter/material.dart';
import 'dart:math';
import 'components/TextFieldButton.dart';

const int min = 0, max = 100;
Random rnd = new Random();

class App extends StatefulWidget {
  final String title;

  App({Key key, this.title}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController _textFieldController = TextEditingController();
  int _exact = min + rnd.nextInt(max - min);
  int _guess;
  int _attempts = 0;
  String _hint = '';
  FocusNode _focusNode;
  bool _enableTextField = true;
  String _buttonTitle = 'Check';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _textFieldHandler(text) {
    setState(() {
      _guess = int.parse(text);
    });
  }

  void _guessHandler() {
    setState(() {
      _buttonTitle = 'Check';
      if (_guess > _exact) {
        _hint = 'Choose smaller!';
      } else if (_guess < _exact) {
        _hint = 'Choose Bigger!';
      } else {
        _hint = 'You won!!!';
        _enableTextField = false;
        _buttonTitle = 'Reset';
      }
      _guess = null;
      _attempts++;
    });
    _textFieldController.clear();
  }

  void _resetHandler() {
    setState(() {
      _attempts = 0;
      _exact = min + rnd.nextInt(max - min);
      _enableTextField = true;
      _hint = '';
      _buttonTitle = 'Check';
    });
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Center(
              widthFactor: double.infinity,
              heightFactor: 4,
              child: Text(
                'attempts: $_attempts',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            TextFieldButton(
              enableTextField: _enableTextField,
              guessHandler: _guessHandler,
              textFieldHandler: _textFieldHandler,
              textFieldController: _textFieldController,
              resetHandler: _resetHandler,
              buttonTitle: _buttonTitle,
              focusNode: _focusNode,
            ),
            Center(
              heightFactor: 10,
              widthFactor: double.infinity,
              child: Text(
                '$_hint',
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
