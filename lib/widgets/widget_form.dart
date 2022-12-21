// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:sharetraveyard/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.obsecu,
    required this.changFunc,
  }) : super(key: key);

  final bool? obsecu;
  final Function(String) changFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 8, bottom: 24),
      child: TextFormField(onChanged: changFunc,
        obscureText: obsecu ?? false,
        style: AppConstant().appStyle(),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          fillColor: AppConstant.fieldColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}