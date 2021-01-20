import 'package:flutter/material.dart';

class MenuCategoryWidget extends StatelessWidget {
  const MenuCategoryWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [

          //image

          Container(
            height: 125,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Some Title",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                Text(
                  "Some Sub-Title",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ]
    );
  }
}