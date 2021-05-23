import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton({
    Key key,
    @required this.onTapped,
    this.buttonText,
  }) : super(key: key);

  final Function onTapped;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTapped,
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
        (states) => Colors.grey,
      )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$buttonText',
          style: TextStyle(
            fontSize: 21,
            color: Colors.blue[900],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
