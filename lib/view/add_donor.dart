import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDonor extends StatefulWidget {
  const AddDonor({super.key});

  @override
  State<AddDonor> createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  final bloodGroups = ['A+', 'A-', 'B+', 'A-', 'O+', 'O-', 'AB+', 'AB-'];

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  String? selectedGroup;
  final donorNameController = TextEditingController();
  final donorPhoneController = TextEditingController();

  void addDonor() {
    final data = {
      "Name": donorNameController.text,
      "Phone": donorPhoneController.text,
      "Blood Group": selectedGroup,
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Donor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: donorNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: donorPhoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone'),
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Select Blood Group'),
                ),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGroup = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                addDonor();
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 45),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
