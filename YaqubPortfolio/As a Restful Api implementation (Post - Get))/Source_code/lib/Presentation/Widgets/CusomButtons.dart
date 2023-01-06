import 'package:flutter/material.dart';

class NormalButtonWidget extends StatelessWidget {

  NormalButtonWidget({required this.ButtonName, required this.OnPressed});
  final String ButtonName;
  final Function OnPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        primary: Colors.orange,
        onPrimary: Colors.white,
        elevation: 12.0,
        minimumSize: Size(300,50)
      ),
      onPressed: (){
      OnPressed();
    }, child: Text(ButtonName , style: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),)
    );
  }
}


class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({Key? key, required this.ButtonName, required this.OnPressed}) : super(key: key);
  final String ButtonName;
  final Function OnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        OnPressed();
      },
      child: Container(
      alignment: Alignment.center,
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange , width: 2)
      ),
      child: Text(ButtonName , style: TextStyle(color: Colors.orange , fontSize: 25 , fontWeight: FontWeight.bold),)
    ));
  }
}



class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({Key? key, required this.ButtonName, required this.OnPressed, required this.icon, this.width, this.height}) : super(key: key);
  final String ButtonName;
  final Function OnPressed;
  final IconData icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          OnPressed();
        },
        child: Container(
            width: width ?? 300,
            height: height ?? 50,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15),
                //border: Border.all(color: Colors.orange , width: 2)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon , color: Colors.white, size: 25,),
                SizedBox(width: 5,),
                Text(ButtonName , style: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),),
              ],
            )
        ));
  }
}


