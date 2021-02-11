import 'package:flutter/material.dart';

class GetPictureWidget extends StatelessWidget {
  @required final VoidCallback action;
  @required final String text;
  @required final IconData icon;

  const GetPictureWidget({
    this.action,
    this.text,
    this.icon,
    Key key,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          action();
        },
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(40, 0, 0, 0),
                  offset: Offset(1, 1),
                  blurRadius: 10.0,
                  spreadRadius: 0.5                          )
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 46,
                ),

                SizedBox(height: 10,),

                Text(
                  text,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

