import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class UserChannelPage extends StatefulWidget {
  
  const UserChannelPage({super.key});

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
  
  }
  class _UserChannelPageState extends State<UserChannelPage>{

    bool haveVideos = false;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/images/flutter background.png"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shantanu Khadse",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("@khadseshantanu",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey)),
                    RichText(
                        text: TextSpan(
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                      children: [
                        TextSpan(
                          text: "No Subscriptions • ",
                        ),
                        TextSpan(
                          text: "No Videos",
                        )
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
            child: FlatButton(
                text: "SUBSCRIBE", onPressed: () {}, colour: Colors.black),
          ),

          haveVideos ? SizedBox(): Center(
            child: Padding(
              padding:EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.2),
              child: Text(
                "No Videos", 
                style: 
                TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                        ),),
            ))
        ],
      ),
    ));
  }
}


  