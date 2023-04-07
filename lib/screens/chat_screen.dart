import 'package:flutter/material.dart';
import 'package:chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import "package:firebase_auth/firebase_auth.dart";

class ChatScreen extends StatefulWidget {
  static const String id='/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late CrossAxisAlignment xx ;
  late BorderRadius br;
  //isAlignedRight ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  late Color y;
 final messageTextController= TextEditingController();
  final messageref = FirebaseFirestore.instance;
  String messageText="";
   final FirebaseAuth _auth = FirebaseAuth.instance;
  late User loggedInUser;
  @override
void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(    loggedInUser.email);
      }

    } catch (e) {
      print(e);
    }
  }

//   void getMessages()async{
//
// final messages= await messageref.collection("messages").get();
// for(var message in messages.docs)
// {
//
//   print(message.data);
// }
//   } 

  void messagesStream()async{
await for (var snapshot in messageref.collection("messages").snapshots() )
{
for (var message in snapshot.docs){
  print(message.data);
}

}

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pop();
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream:messageref.collection("messages").snapshots(),
              builder:(context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data?.docs;
                List<BubbleText> messagesWidgets = [];
                for (var message in messages ?? []) {
                  final messageText = message.data()['text'] ?? '';
                  final messageSender = message.data()['sender'] ?? '';
final currentUser=loggedInUser.email;

if(currentUser==messageSender){
  y=Colors.blue;
  xx= CrossAxisAlignment.end;
  br=BorderRadius.only(
      topLeft:Radius.circular(30),bottomLeft:
  Radius.circular(30),bottomRight:Radius.circular(30.0));
}
else {
  xx= CrossAxisAlignment.start;
   y=Colors.white60;
  br=BorderRadius.only(
      topRight:Radius.circular(30),bottomLeft:
  Radius.circular(30),bottomRight:Radius.circular(30.0));
}

                  final messagesWidget= BubbleText(messageText, messageSender,y,xx,br);
                  messagesWidgets.add(messagesWidget);
                }
                  return Expanded(child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messagesWidgets,
                  ),
                  );

              }
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        setState(() {
                          messageText=value;
                        });
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
messageTextController.clear();
                        messageref.collection('messages').add({
                          "text": messageText,
                          "sender": loggedInUser.email,
                        } );

                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BubbleText extends StatelessWidget {
  String text;
  String sender;
Color x;
  CrossAxisAlignment xx;
  BorderRadius br;
BubbleText(this.text,this.sender, this.x,this.xx,this.br);
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: xx,
          children: [
            Text(sender,
              style: TextStyle(
                fontSize: 12.0,
                color:Colors.black26,
              ),

            ),
            Material(
                elevation:(20),
                borderRadius:br,
                color:x,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
                  child: Text('$text',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                )),
          ],
        ),
      );


  }
}


