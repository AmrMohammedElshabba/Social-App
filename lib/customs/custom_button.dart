import 'package:flutter/material.dart';

Widget customButton ({
  required Function onTap,
  required BuildContext context,
  required Color color,
  required String title,
}){
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: color),
        child: Center(
          child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
              .copyWith(color: Colors.white),
        ),
      ),
    ),
  ),
  );
}

