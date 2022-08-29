import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.fieldController,
  }) : super(key: key);

  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: fieldController,
        keyboardType: TextInputType.number,
        maxLength: 5,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Enter weight.');
          } else if (!value.contains(
              RegExp('^([1-9]|[1-9][0-9]|[1-9][0-9][0-9])')
          )) {
            return ('Enter valid weight.');
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Enter weight',
          labelStyle: TextStyle(color: Colors.orange),
          prefixIcon: Icon(Icons.scale_sharp),
          hintText: 'Enter your weight',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            gapPadding: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
