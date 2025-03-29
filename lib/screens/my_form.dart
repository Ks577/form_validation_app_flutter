import 'package:flutter/material.dart';

enum GenderList { male, female }

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender = GenderList.female;
  final List<bool> _dietPreferences = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My form', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              _buildTextField(
                Icons.pets,
                "Your dog's name",
                "Please enter your dog's name",
              ),
              SizedBox(height: 10),
              _buildTextField(
                Icons.person,
                "Your name",
                "Please enter your name",
              ),
              SizedBox(height: 10),
              _buildEmailField(),
              SizedBox(height: 10),
              _buildTextField(
                Icons.phone,
                "Phone number",
                "Please enter your phone number",
              ),
              SizedBox(height: 10),
              _buildTextField(
                Icons.pets,
                "Breed of dog",
                "Please enter your dog's breed",
              ),
              const SizedBox(height: 40),
              _buildGenderSelection(),
              const SizedBox(height: 30),
              _buildDietSelection(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, String errorMessage) {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(icon), labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.mail),
        labelText: "E-mail",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email';
        }
        if (!value.contains('@')) {
          return 'Please enter a valid Email';
        }
        return null;
      },
    );
  }

  // Выбор пола собаки
  Widget _buildGenderSelection() {
    return Column(
      children: [
        const Text(
          "Your dog's gender",
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        _buildRadioTile('Male', GenderList.male),
        _buildRadioTile('Female', GenderList.female),
      ],
    );
  }

  Widget _buildRadioTile(String title, GenderList value) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: _gender,
      onChanged: (GenderList? newValue) {
        setState(() {
          _gender = newValue!;
        });
      },
    );
  }

  // Выбор диеты
  Widget _buildDietSelection() {
    final List<String> dietOptions = ['Dry food', 'Wet food', 'Homemade food'];
    return Column(
      children: [
        const Text(
          "Your dog's diet",
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        for (int i = 0; i < dietOptions.length; i++)
          CheckboxListTile(
            title: Text(dietOptions[i]),
            value: _dietPreferences[i],
            activeColor: Colors.blue,
            onChanged: (bool? value) {
              setState(() {
                _dietPreferences[i] = value ?? false;
              });
            },
          ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.lightBlue),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final bool hasDietPreference = _dietPreferences.contains(true);
          final String text =
              hasDietPreference
                  ? 'Thank you! Your submission has been saved.'
                  : 'Please select at least one diet option.';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(text)));
        }
      },
      child: const Text(
        'Submit',
        style: TextStyle(fontSize: 19, color: Colors.white),
      ),
    );
  }
}
