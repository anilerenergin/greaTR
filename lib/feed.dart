import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({ Key? key }) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
        
            color: Colors.purple,
            child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.blue),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Anıl Eren Ergin"),
                      Text("Amerika Birleşik Devletleri"),
                    ],
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 150,
                    color: Colors.white,),
                ),
              ),
                Text("Açıklama açıklama jdbak aksudb od ı sıb. Anskj  sı kıds os ond!"),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.heart),
                    Text("20")
                  ],
                ),
                GestureDetector(
                  
                  child: Text("Yorumlar..."))

            ],),
          ),
        );
      })),
    );
  }
}