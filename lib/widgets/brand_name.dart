import 'package:flutter/material.dart';
import 'package:wallpaperflux/widgets/custom_text.dart';

Widget brandName(year,) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const CustomText(text: 'HD',fontSize: 22,),
      const CustomText(text: 'Wallpaper',fontSize: 22,),
      CustomText(text: year, fontSize: 22,color: Colors.blue,)
    ],
  );
}