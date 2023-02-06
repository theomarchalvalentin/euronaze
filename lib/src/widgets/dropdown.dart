import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Oneoisabigoneaverybigone',
  'Two',
  'Three',
  'Four'
];

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key, required this.list});
  final List<String> list;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 3, 140, 129)),
      underline: Container(
        height: 2,
        color: Color.fromARGB(255, 3, 140, 129),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
