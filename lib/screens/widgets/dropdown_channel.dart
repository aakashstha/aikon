import 'package:flutter/material.dart';

List<String> dropList = <String>['Select channel ...', 'Mobile', 'Computer'];

class DropdownButtonForChannel extends StatefulWidget {
  const DropdownButtonForChannel({super.key});

  @override
  State<DropdownButtonForChannel> createState() =>
      _DropdownButtonForChannelState();
}

class _DropdownButtonForChannelState extends State<DropdownButtonForChannel> {
  String dropdownValue = dropList.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 35,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        style: const TextStyle(color: Colors.black),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: dropList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
