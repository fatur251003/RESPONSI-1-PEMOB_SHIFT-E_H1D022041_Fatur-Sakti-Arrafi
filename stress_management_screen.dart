import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../models/stress_model.dart';
import '../widgets/stress_form.dart';

class StressManagementScreen extends StatefulWidget {
  @override
  _StressManagementScreenState createState() => _StressManagementScreenState();
}

class _StressManagementScreenState extends State<StressManagementScreen> {
  List<StressModel> _stressList = [];

  @override
  void initState() {
    super.initState();
    _fetchStressList();
  }

  _fetchStressList() async {
    List<StressModel> list = await DatabaseHelper().getStresses();
    setState(() {
      _stressList = list;
    });
  }

  _deleteStress(int id) async {
    await DatabaseHelper().deleteStress(id);
    _fetchStressList();
  }

  _editStress(StressModel stress) async {
    // Implement edit functionality
    // Show form with current data and update on submit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stress Management')),
      body: Column(
        children: [
          StressForm(onSubmit: _fetchStressList),
          Expanded(
            child: ListView.builder(
              itemCount: _stressList.length,
              itemBuilder: (context, index) {
                StressModel stress = _stressList[index];
                return ListTile(
                  title: Text(stress.stressFactor),
                  subtitle: Text(stress.copingStrategy),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editStress(stress),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteStress(stress.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}