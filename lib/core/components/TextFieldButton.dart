import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  final enableTextField;
  final textFieldHandler;
  final guessHandler;
  final resetHandler;
  final textFieldController;
  final buttonTitle;
  final focusNode;

  TextFieldButton(
      {Key key,
      this.textFieldHandler,
      this.enableTextField,
      this.guessHandler,
      this.resetHandler,
      this.textFieldController,
      this.buttonTitle,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter Number',
            ),
            style: TextStyle(fontSize: 21),
            focusNode: focusNode,
            controller: textFieldController,
            enabled: enableTextField,
            maxLength: 2,
            keyboardType: TextInputType.number,
            onChanged: textFieldHandler,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Expanded(
            flex: 2,
            child: ElevatedButton(
              child: Text(buttonTitle),
              onPressed: () {
                if (buttonTitle == 'Check') {
                  guessHandler();
                } else if (buttonTitle == 'Reset') {
                  resetHandler();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
