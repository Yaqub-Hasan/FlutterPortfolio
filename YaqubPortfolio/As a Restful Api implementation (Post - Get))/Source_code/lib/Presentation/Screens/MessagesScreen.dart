import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oswah_test/API/JsonToDart/ChatListJson.dart';
import 'package:oswah_test/Presentation/Screens/ChatScreen.dart';

import '../../API/GetData/GetAllChatsList.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

   late Future<ChatsListJson> getAllChats;

  @override
  void initState() {
    getAllChats = GetChatsList().getAllChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          " Messages ",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<ChatsListJson>(future: getAllChats, builder: (context , snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemExtent: 120.0,
                itemCount: snapshot.data!.result!.length,
                itemBuilder: (context, index) {

                  final data = snapshot.data!.result![index];
                  DateTime? messageTime = DateTime.tryParse(data.lastMessageTime.toString());

                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatScreen(recieveId: data.id, contactId: data.contactId,)));
                    },
                    child: Row(
                      children: [
                        Container(
                            width: 110,
                            height: 110,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black, width: 2)),
                            child: Image(
                              image: AssetImage("assets/image.png"),
                              height: 100,
                              width: 100,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(data.fullName.toString() ,style:  TextStyle(color: Colors.black, fontSize: 20  ,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Text(DateFormat('MMMd , h:mm a').format(messageTime ?? DateTime.now()) , style:  TextStyle(color: Colors.grey , fontSize: 17  ,)) ,
                            SizedBox(height: 5,),
                            Text(data.lastMessage.toString(),style:  TextStyle(color: Colors.black , fontSize: 17,),),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
          else{
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("OOPS!! " ,
                    style: TextStyle(color: Colors.orange ,
                        fontSize: 40 , fontWeight: FontWeight.bold
                  ),),
                  Text("No messages yet" ,
                    style: TextStyle(color: Colors.orange ,
                        fontSize: 25 , fontWeight: FontWeight.bold
                    ),),
                ],
              ),),);
          }
        },)
      ),
    );
  }
}

