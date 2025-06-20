import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  final String? errorText;
  final void Function(String)? onChanged;
  final String? successMessage;
  final Icon? prefixIcon;
  final bool willContainPrefix;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    this.labelText = "",
    required this.hintText,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.name,
    this.validator,
    this.errorText,
    this.onChanged,
    this.successMessage,
    this.prefixIcon,
    this.willContainPrefix = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText!,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          autofocus: true,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          inputFormatters: inputFormatters,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF70d5f8),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
            suffixIcon: icon,
            errorText: errorText,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.grey.shade300,
            contentPadding: const EdgeInsets.all(10),
          ),
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
        ),
        Text(
          successMessage ?? "",
          style: const TextStyle(color: Colors.green),
        )
      ],
    );
  }
}
