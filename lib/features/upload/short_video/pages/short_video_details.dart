import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/widgets/flat_button.dart';

class ShortVideoDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Video Details",
            style: TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Caption",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(15)

                  )
                ),
              ),
              Spacer(),
              FlatButton(text: "PUBLISH", onPressed: (){}, colour: Colors.green)
            ],
          ),
        ),
      ),
    );
  }
}
