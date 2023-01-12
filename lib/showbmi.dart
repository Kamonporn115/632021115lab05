import 'package:flutter/material.dart';

class Showbmi extends StatefulWidget {
  const Showbmi(
      {super.key,
      required this.bminew,
      required this.weightnew,
      required this.heightnew});

  final double bminew;
  final String weightnew;
  final String heightnew;

  @override
  State<Showbmi> createState() => _ShowbmiState();
}

class _ShowbmiState extends State<Showbmi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แสดงค่า"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(widget.weightnew),
              Text(widget.heightnew),
              Text(widget.bminew.toStringAsFixed(3)),
            ],
          ),
        ),
      ),
    );
  }
}
