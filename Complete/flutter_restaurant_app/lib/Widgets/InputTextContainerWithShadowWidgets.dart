import 'package:flutter/material.dart';

class OneTextInputContainerWithShadow extends StatelessWidget {
  final String inputOnePlaceholderText;

  const OneTextInputContainerWithShadow({
    this.inputOnePlaceholderText,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5                          )
        ],
      ),
      height: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputOnePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoTextInputContainerWithShadow extends StatelessWidget {
  final String inputOnePlaceholderText;
  final String inputTwoPlaceholderText;

  const TwoTextInputContainerWithShadow({
    this.inputOnePlaceholderText,
    this.inputTwoPlaceholderText,

    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5                          )
        ],
      ),
      height: 165,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                  //border: InputBorder,
                  hintText: inputOnePlaceholderText,
                hintStyle: TextStyle(
                  color: Colors.grey
                )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                  //border: InputBorder.none,
                  hintText: inputTwoPlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SignUpTextInputContainerWithShadow extends StatelessWidget {
  final String inputOnePlaceholderText;
  final String inputTwoPlaceholderText;
  final String inputThreePlaceholderText;
  final String inputFourPlaceholderText;

  const SignUpTextInputContainerWithShadow({
    this.inputOnePlaceholderText,
    this.inputTwoPlaceholderText,
    this.inputThreePlaceholderText,
    this.inputFourPlaceholderText,


    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5                          )
        ],
      ),
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputOnePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder.none,
                  hintText: inputTwoPlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputThreePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder.none,
                  hintText: inputFourPlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChangePasswordTextInputContainerWithShadow extends StatelessWidget {
  final String inputOnePlaceholderText;
  final String inputTwoPlaceholderText;
  final String inputThreePlaceholderText;

  const ChangePasswordTextInputContainerWithShadow({
    this.inputOnePlaceholderText,
    this.inputTwoPlaceholderText,
    this.inputThreePlaceholderText,



    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5                          )
        ],
      ),
      height: 225,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputOnePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder.none,
                  hintText: inputTwoPlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputThreePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class ChangeDeliveryAddressTextInputContainerWithShadow extends StatelessWidget {
  final String inputOnePlaceholderText;
  final String inputTwoPlaceholderText;
  final String inputThreePlaceholderText;
  final String inputFourPlaceholderText;
  final String inputFivePlaceholderText;

  const ChangeDeliveryAddressTextInputContainerWithShadow({
    this.inputOnePlaceholderText,
    this.inputTwoPlaceholderText,
    this.inputThreePlaceholderText,
    this.inputFourPlaceholderText,
    this.inputFivePlaceholderText,

    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5
          )
        ],
      ),
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputOnePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder.none,
                  hintText: inputTwoPlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),

            SizedBox(height: 20,),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      //border: InputBorder,
                        hintText: inputThreePlaceholderText,
                        hintStyle: TextStyle(
                            color: Colors.grey
                        )
                    ),
                  ),
                ),

                SizedBox(width: 20,),

                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      //border: InputBorder,
                        hintText: inputFourPlaceholderText,
                        hintStyle: TextStyle(
                            color: Colors.grey
                        )
                    ),
                  ),
                ),
              ],
            ),



            SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                //border: InputBorder,
                  hintText: inputFivePlaceholderText,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}




