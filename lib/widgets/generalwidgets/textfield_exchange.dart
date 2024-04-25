import 'package:bankpfe/controllers/profil_controllers/exchange_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldExchange extends GetView<ExchangeControllerImp> {
  final String label;
  final String hint2;
  final String mytext;
  final Icon myicon;
  final bool ispass;
  final bool readonly;
  final String? Function(String?)? validator;
  final GestureDetector? mysuffixicon;
  final TextEditingController mycontroller;

  const TextFieldExchange({
    super.key,
    required this.readonly,
    required this.label,
    required this.mycontroller,
    required this.myicon,
    this.mysuffixicon,
    required this.hint2,
    required this.ispass,
    required this.validator,
    required this.mytext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: mycontroller,
        obscureText: ispass,
        readOnly: readonly,
        onChanged: (text) {
          controller.updateamount(text);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint2,
          suffixIcon: mysuffixicon,
          prefixIcon: myicon,
          prefixText: mytext,
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
