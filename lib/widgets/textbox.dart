import 'package:flutter/material.dart';

class TextBoxx extends StatelessWidget {
  const TextBoxx({
    super.key,
    required this.text,
    required this.secName,
    this.onPressed,
    this.updatedText,
  });

  final String text;
  final String secName;
  final void Function()? onPressed;
  final String? updatedText;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(left: 20, right: 10, bottom: 17, top: 5),
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(secName, style: TextStyle(color: Colors.grey[600])),
              IconButton(onPressed: onPressed, icon: Icon(Icons.settings)),
            ],
          ),
          Text(
            updatedText ?? text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
