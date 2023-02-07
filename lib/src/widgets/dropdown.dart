import 'package:flutter/material.dart';

String selectedCategory = "0";

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key, required this.list});
  final List<String> list;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      hint: const Text("Choose an category"),
      //style: const TextStyle(color: Color.fromARGB(255, 3, 140, 129)),
      underline: Container(
        height: 1,
        color: const Color.fromARGB(255, 156, 156, 156),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          selectedCategory = value;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
