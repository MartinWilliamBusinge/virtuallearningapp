// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;  // Make FocusNode optional

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.focusNode,  // This can be null
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscured,
        focusNode: widget.focusNode,  // Use the provided FocusNode, if any
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 211, 159, 100)),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 77, 41, 17)),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: widget.focusNode?.hasFocus ?? false ? const Color.fromARGB(255, 211, 159, 100) : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
