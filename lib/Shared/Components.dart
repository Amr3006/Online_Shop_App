import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType inputType,
  String? labelText,
  String? hintText,
  Icon? prefixIcon,
  IconData? suffixIcon,
  bool enabled=true,
  bool obsecured = false,
  void Function()? onTap,
  void Function()? onTapSuffix,
  void Function(String)? onChanged,
  void Function(String)? onSubmit,
  String? Function(String?)? validator,
}) =>
    TextFormField(
      enabled: enabled,
      validator: validator,
      controller: controller,
      obscureText: obsecured,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      keyboardType: inputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(fontFamily: "MainFont"),
          hintStyle: const TextStyle(fontFamily: "MainFont"),
          prefixIcon: prefixIcon,
          suffixIcon: IconButton(
            onPressed: onTapSuffix,
            icon: Icon(suffixIcon),
          )),
    );

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToAndErease({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void snackMessage({
  required BuildContext context,
  required String text,
  Color color=Colors.black87
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: color,
  ));
}
