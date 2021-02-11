import 'package:flutter/material.dart';
import 'package:flutter_church_app_2020/Models/UserAddressModel.dart';
//import 'package:flutter_restaurant_backend_app/Globals/GlobalVariables.dart';

class AddressWidget extends StatefulWidget {
  //final UserModel thisUser;
  final int index;
  final VoidCallback deleteAction;
  final Color mainColor;
  final Color subtextColor;
  final Color tabColor;
  final List<UserAddressModel> deliveryAddresses;

  AddressWidget(
      {
        this.index,
        this.deleteAction,
        this.mainColor,
        this.subtextColor,
        this.tabColor,
        this.deliveryAddresses
      });

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  //UserModel thisUser;

  checkApartment(UserAddressModel address) {
    if (address.apartmentNumber != null && address.apartmentNumber != "") {
      print("the number ${address.apartmentNumber}");
      return ", ${address.apartmentNumber}";
    }else{
      return "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //thisUser = widget.thisUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.tabColor, //Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5)
        ],
      ),
      height: 100,
      width: MediaQuery.of(context).size.width - 40,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: (Container(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.deliveryAddresses[widget.index].address,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.mainColor),
                        ),
                        Text(
                          checkApartment(
                              widget.deliveryAddresses[widget.index]),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.mainColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.deliveryAddresses[widget.index].city,
                      style: TextStyle(
                          fontSize: 16, color: widget.subtextColor //Colors.grey
                          ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 36,
                  color: widget.mainColor,
                  onPressed: () {
                    print("Delete Address");
                    setState(() {
                      //addressIndex = widget.index;
                      widget.deleteAction();
                    });
                  },
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}
