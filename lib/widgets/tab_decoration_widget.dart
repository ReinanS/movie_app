import 'package:flutter/material.dart';

class TabDecorationWidget extends StatelessWidget {
  final String title;

  TabDecorationWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // border: Border.all(
        //   width: 0.1,
        //   color: AppColors.black,
        // ),
      ),
      child: Tab(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
