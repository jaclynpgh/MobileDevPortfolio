import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_wasteagram/screens/new_waste_post.dart';


class WasteListScreen extends StatefulWidget {
  @override
  _WasteListScreen createState() => _WasteListScreen();
}

class _WasteListScreen extends State<WasteListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Wasteagram')),
        floatingActionButton: cameraFab(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts')
          .orderBy('date', descending: false)
          .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.docs != null &&
                snapshot.data!.docs.length > 0) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data!.docs[index];
              //           var postDetails = FoodWastePost(
              //               date: post['date'].toString(),
              //               imageURL: post['url'],
              //               quantity: post['quantity'],
              //               latitude: post['latitude'],
              //               longitude: post['longitude'],
              // );
                        return ListTile(               
                            title: Text(post['date'].toString()),
                            trailing: Text(post['quantity'].toString()),
                    //           onTap: () { Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => WasteDetailScreen(
                    //       post: postDetails
                    //     ))
                    //   );
                    // },
                            
                            );},
                    ),
                  ),
                 
                ],);
            } else {
              return Column(
                children: const [
                  Center(child: CircularProgressIndicator()),
                  
                ],
              );
            }
          }),
    );
  }


    Widget cameraFab(BuildContext context) {
    return Semantics(
      child: FloatingActionButton(
          onPressed: () async {
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => const NewWastePost()));

      },
          child: const Icon(Icons.camera_alt_outlined),
      ),
      onTapHint: 'Select an image',
      enabled: true,
      button: true
    );
  }

}

