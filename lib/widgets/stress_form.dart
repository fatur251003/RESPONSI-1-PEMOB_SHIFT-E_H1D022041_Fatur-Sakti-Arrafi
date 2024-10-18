import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../models/stress_model.dart';

class StressForm extends StatefulWidget {
  final Function onSubmit;

  StressForm({required this.onSubmit});

  @override
  _StressFormState createState() => _StressFormState();
}

class _StressFormState extends State<StressForm> {
  final _formKey = GlobalKey<FormState>();
  final _stressFactorController = TextEditingController();
  final _copingStrategyController = TextEditingController();
  final _stressLevelController = TextEditingController();

  void _saveStress() async {
    if (_formKey.currentState!.validate()) {
      StressModel stress = StressModel(
        stressFactor: _stressFactorController.text,
        copingStrategy: _copingStrategyController.text,
        stressLevel: int.parse(_stressLevelController.text),
      );
      await DatabaseHelper().insertStress(stress);
      widget.onSubmit();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Stress saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _stressFactorController,
              decoration: InputDecoration(labelText: 'Stress Factor'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a stress factor';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _copingStrategyController,
              decoration: InputDecoration(labelText: 'Coping Strategy'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a coping strategy';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stressLevelController,
              decoration: InputDecoration(labelText: 'Stress Level'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a stress level';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveStress,
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}