import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildPage extends StatelessWidget {
  Color? color;
  String? urlImage;
  String? title;
  String? subtitle;
  Color? titleColor;

  buildPage({Key? key, this.color, this.urlImage, this.title, this.subtitle,this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 64),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54,fontSize: 16, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
