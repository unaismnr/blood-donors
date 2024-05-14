import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  String? selectedGroup;
  final donorNameController = TextEditingController();
  final donorPhoneController = TextEditingController();

  // ValueNotifier dropSelect = ValueNotifier('A+');

  void updateDonor(docId) {
    final data = {
      "Name": donorNameController.text,
      "Phone": donorPhoneController.text,
      "Blood Group": selectedGroup,
    };
    donor.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorNameController.text = args['name'];
    donorPhoneController.text = args['phone'];
    selectedGroup = args['blood'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Donor'),
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
              // child: ValueListenableBuilder(
              //     valueListenable: dropSelect,
              //     builder: (context, value, _) {
              child: DropdownButtonFormField(
                value: selectedGroup,
                decoration: const InputDecoration(
                  label: Text('Select Blood Group'),
                ),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGroup = newValue;
                  });
                },
              ),
              // }),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                updateDonor(docId);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 45),
                ),
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
