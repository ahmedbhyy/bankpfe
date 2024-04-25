import 'package:bankpfe/controllers/pay_controllers/pay_mobile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldCommon extends GetView<PayMobileControllerImp> {
  final String hint;
  final String mytext;
  final Icon myicon;
  final bool ispass;
  final String? Function(String?)? validator;
  final GestureDetector? mysuffixicon;
  final TextEditingController mycontroller;

  const TextFieldCommon({
    super.key,
    required this.hint,
    required this.mycontroller,
    required this.myicon,
    this.mysuffixicon,
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
        onChanged: (text) {
          controller.updateimage(text);
        },
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: hint,
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
