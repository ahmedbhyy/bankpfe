import 'package:flutter/material.dart';

class TextFieldAuth extends StatelessWidget {
  final String hint;
  final String? mysuffix;
  final Icon myicon;
  final bool ispass;
  final bool readonly ;
  final String? Function(String?)? validator;
  final GestureDetector? mysuffixicon;
  final TextEditingController mycontroller;
  final TextInputType mytype;
  const TextFieldAuth(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.myicon,
      this.mysuffixicon,
      required this.ispass,
      required this.validator,
      required this.mytype,
      this.mysuffix,  required this.readonly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: mycontroller,
        obscureText: ispass,
        keyboardType: mytype,
        readOnly: readonly,
        decoration: InputDecoration(
          labelText: hint,
          suffixText: mysuffix,
          suffixIcon: mysuffixicon,
          prefixIcon: myicon,
          prefixIconColor: Colors.grey[800],
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 1, 81, 70),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 236, 213, 4), width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
