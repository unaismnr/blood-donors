import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Blood Donation'),
      ),
      body: StreamBuilder(
          stream: donor.orderBy('Name').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final donor = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 20),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 191, 191, 191),
                                    blurRadius: 15,
                                    spreadRadius: 0.1,
                                    offset: Offset(0, 5))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  maxRadius: 25,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    donor['Blood Group'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      donor['Name'].toString(),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      donor['Phone'].toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            '/UpdateDonor',
                                            arguments: {
                                              'name': donor['Name'],
                                              'phone':
                                                  donor['Phone'].toString(),
                                              'blood': donor['Blood Group'],
                                              'id': donor.id,
                                            });
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteDonor(donor.id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              const Center(
                child: Text('Something Error'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/AddDonor');
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, size: 35),
      ),
    );
  }
}
