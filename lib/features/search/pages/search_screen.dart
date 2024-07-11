import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_clone/cores/widgets/custom_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
               children: [
                 IconButton(onPressed: (){},icon: Icon(Icons.arrow_back_ios_new_sharp),
                 ),
                 SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width/1.2,
                   child: TextFormField(
                  
                    decoration: InputDecoration(
                     suffixIcon: Container(
                      width: 2,
                      margin: EdgeInsets.only(right: 2),
                     decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
                     ),
                      
                    
                      child: const Icon(Icons.search_sharp)),
                      hintText: "Search Youtube... ",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          
                        ),
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                   ),
                 ),
               ],
              )    
            ],
          ),
        ),
      ),
    );
  }
}