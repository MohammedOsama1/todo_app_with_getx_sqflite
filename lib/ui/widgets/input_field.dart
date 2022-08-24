import 'package:flutter/material.dart';

import 'package:todo_app/ui/theme.dart';


  Column inputField(  String title, String hint, {TextEditingController? controller,Widget ? widget}) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(title,style: title1,),

      ),
      const SizedBox(height: 5,),

      Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              child: TextFormField(
                style: title1,
                readOnly: widget != null ? true: false,
                controller: controller,
                autofocus: false,
                decoration: InputDecoration(
                  iconColor: Colors.grey,
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                    hintText: hint, hintStyle: subTitle,
                  suffixIcon: widget,

                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
  }




