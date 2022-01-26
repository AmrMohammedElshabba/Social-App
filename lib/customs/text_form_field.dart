import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keybordType,
  required String lable,
  required IconData prefix,
  required validateText,
  Function? sufixPressed,
  Function? onTap,
  Function? onChange,
  Function? onSubmitted,
  bool obsecureText = false,
  IconData? sufix,
}) =>
    TextFormField(
        cursorColor: Colors.grey,
        keyboardType: keybordType,
        obscureText: obsecureText,
        onFieldSubmitted: (value) {
          onSubmitted!(value);
        },
        onChanged: (value) {
          onChange!(value);
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return validateText;
          }

          return null;
        },
        controller: controller,
        onTap: () {
          onTap!();
        },
        decoration: InputDecoration(
          labelText: lable,
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            prefix,
            color: Colors.grey,
          ),
          suffixIcon: sufix != null
              ? IconButton(
                  icon: Icon(
                    sufix,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    sufixPressed!();
                  },
                )
              : null,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
        ));
