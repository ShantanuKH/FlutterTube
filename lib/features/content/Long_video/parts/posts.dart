import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(imageUrl:"https://www.shutterstock.com/image-illustration/abstract-wave-technology-background-blue-260nw-2152448863.jpg",
          ),
          
        ],
      ),
    );
  }
}