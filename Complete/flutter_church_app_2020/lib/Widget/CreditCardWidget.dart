import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Models/CreditCardModel.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    this.mainColor,
    this.subtextColor,
    this.tabColor,
    this.cards,
    Key key,
    @required this.cardTextColor,
    //this.thisUser,
    this.index,
  }) : super(key: key);

  final Color tabColor;
  final Color mainColor;
  final Color subtextColor;
  final Color cardTextColor;
  //final UserModel thisUser;
  final int index;
  final List<CreditCardModel> cards;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: tabColor, //Colors.blue,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(80, 0, 0, 0),
                offset: Offset(1, 1),
                blurRadius: 10.0,
                spreadRadius: 1.0)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.credit_card,
                color: mainColor, //cardTextColor,
                size: 40,
              ),
              SizedBox(height: 20),
              Text(
                cards[index].cardNumber,
                style: TextStyle(
                  fontSize: 24,
                  color: mainColor, //cardTextColor
                ),
              ),
              SizedBox(height: 20),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card Holder",
                        style: TextStyle(
                          fontSize: 14,
                          color: subtextColor, //cardTextColor
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            cards[index].firstName,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor //cardTextColor
                                ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            cards[index].lastName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: mainColor, //cardTextColor
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exp Date",
                        style: TextStyle(
                          fontSize: 14,
                          color: subtextColor, //cardTextColor
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            cards[index].expiryMonth.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: mainColor, //cardTextColor
                            ),
                          ),
                          Text(
                            "/",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: mainColor, //cardTextColor
                            ),
                          ),
                          Text(
                            cards[index].expiryYear.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor //cardTextColor
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
