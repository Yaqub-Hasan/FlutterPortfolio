import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oswah_test/API/GetData/GetPartners.dart';
import 'package:oswah_test/API/JsonToDart/FindPartnerJson.dart';
import 'package:oswah_test/API/PostData/InserNewMessage.dart';
import '../Widgets/CusomButtons.dart';


class SearchPartner extends StatefulWidget {
  const SearchPartner({Key? key, this.cityId, this.countryId}) : super(key: key);
  final cityId;
  final countryId;

  @override
  State<SearchPartner> createState() => _SearchPartnerState();
}

class _SearchPartnerState extends State<SearchPartner> {

  late Future<FindPartnerJson> getAllPartners;
  late int YourId;

  getYourId() async {
    final storage = new FlutterSecureStorage();
    String? id = await storage.read(key: "id");
    YourId = int.parse(id.toString());
    print(YourId);
  }

  @override
  void initState() {
    getAllPartners = FindPartner().FIndPartner(CountryId: widget.countryId, CityId: widget.cityId);
    getYourId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Suggestions partners",
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
        padding: EdgeInsets.all(10),
        child: FutureBuilder<FindPartnerJson>(
          future:getAllPartners ,
          builder: (context , snapshot){
            if(snapshot.hasData){

              return ListView.builder(
                  shrinkWrap: true , itemCount: snapshot.data!.result!.length
                  , itemBuilder: (context , index){
                var size = MediaQuery.of(context).size;
                final data = snapshot.data!.result![index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.black.withOpacity(0.1) , width: 2)
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  width: size.width,
                  height: 180  ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.userName.toString() , style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
                              Text("Age:  ${data.age}" , style: TextStyle(
                                  color: Colors.black, fontSize: 18),),
                              Text("City name:  ${data.cityName}" , style: TextStyle(
                                  color: Colors.black, fontSize: 18),)
                            ],
                          )
                        ],
                      ),
                      ButtonWithIcon(ButtonName: "    send message", icon: Icons.message,height: 35,width: size.width-30 ,OnPressed: (){
                        InsertNewMessage().SendMessage(message: "Hi!", YourId: YourId, recipientID: data.id ?? 0);
                        final snackBar = SnackBar(
                          content: Text(
                            "Message Sent: 'Hi!' Successfully , Go to Messages Screen",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 2500),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },)
                    ],
                  ),
                );
              });
            }
            else{
              return Center(child: CircularProgressIndicator(color: Colors.orange,));
            }
          },

        ),
      )
    );
  }
}
