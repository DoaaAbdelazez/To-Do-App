import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class AddTaskComponent extends StatelessWidget {
  const AddTaskComponent({super.key, required this.title, required this.hintText,  this.controller, this.suffixIcon,  this.readOnly=false});
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final bool readOnly ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          readOnly:readOnly ,
          controller: controller,
          decoration: InputDecoration(
            //hint
            hintText: hintText,
            suffixIcon:suffixIcon, 
          ),
        ),
      ],
    );
  }
}
