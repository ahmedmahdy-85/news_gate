import 'package:flutter/material.dart';

class ErrorLine extends StatelessWidget {
  final List<String> errors;
  ErrorLine({@required this.errors});

  Widget errorLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 10.0, left: 30.0),
      child: Expanded(
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          List.generate(errors.length, (index) => errorLine(errors[index])),
    );
  }
}
