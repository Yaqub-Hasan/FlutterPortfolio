import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import '../../API/GetData/GetChatDialogs.dart';
import '../../API/JsonToDart/DialogsJson.dart';
import '../../API/PostData/InserNewMessage.dart';
import '../Widgets/MessageTextFieldRow.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, this.recieveId, this.contactId})
      : super(key: key);
  final recieveId;
  final contactId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  InsertNewMessage insertNewMessage = InsertNewMessage();
  late Future<DialogJson> getAllChatsDialogs;
  late int YourId;

  getYourId() async {
    final storage = new FlutterSecureStorage();
    String? id = await storage.read(key: "id");
    YourId = int.parse(id.toString());
    print(YourId);
  }

  @override
  void initState() {
    getAllChatsDialogs = GetChatDialogs().getAllChatsDialogs(ChatId: widget.recieveId);
    getYourId();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    getAllChatsDialogs =  GetChatDialogs().getAllChatsDialogs(ChatId: widget.recieveId);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image(
              image: AssetImage("assets/back.png"),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            " User name ",
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
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<DialogJson>(
            future: getAllChatsDialogs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: MessageBubble(snapshot)),
                    ),
                    MessageTextFieldRow(
                      accountId: widget.contactId,
                      chatID: widget.recieveId,
                      styleColor: Colors.black,
                      borderColor: Colors.orange,
                      hintText: "Write a message ...",
                      cntrol: messageController,
                      onChange: () {
                        setState(() {});
                      },
                      InkWellTap: () {
                        setState(() {
                          insertNewMessage.SendMessage(
                              message: messageController.text,
                              YourId: YourId,
                              recipientID: widget.contactId);
                          messageController.clear();
                        });
                      },
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }
            },
          ),
        ));
  }


  /// Messages Widget:
  MessageBubble(AsyncSnapshot<DialogJson> snapshot) {
    List<Widget> WidgetsList = [];
    Widget customWidget;
    bool isMe = false;


    for (int i = 0; i < snapshot.data!.result!.dialogs!.length; i++) {
      DateTime? messageTime = DateTime.tryParse(snapshot.data!.result!.dialogs![i].time.toString());
      if (YourId == snapshot.data!.result!.dialogs![i].who) {
        isMe = true;
      } else {
        isMe = false;
      }
      customWidget = Column(
        crossAxisAlignment:
            isMe == false ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            shadowColor: Colors.orange,
            elevation: 12,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                snapshot.data!.result!.dialogs![i].message.toString(),
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: isMe ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(10),
                    bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                  )),
            ),
          ),
          Text(DateFormat('MMMd , h:mm a').format(messageTime ?? DateTime.now()) , style:  TextStyle(color: Colors.grey , fontSize: 13  ,)),
          SizedBox(
            height: 10,
          ),

        ],
      );
      WidgetsList.add(customWidget);
    }

    return WidgetsList;
  }
}
