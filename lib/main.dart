import 'package:ec_validator/validators/dni_validator.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> identifications = [
      '0105566046',
      '01A5566046',
      '01A511',
      ''
      '001 '
    ];
    
    return MaterialApp(
      title: 'EC Validator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ec Validator'),
        ),
        body: ListView.builder(
          itemCount: identifications.length,
          itemBuilder: (context, index) {
            final identification = identifications[index];
            final result = DniValidator.isValid(identification);
            return Card(
              child: ListTile(
                title: Text(identification),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'isValid: ${result.isValid.toString()}',
                      style: const TextStyle()
                    ),
                    Text(
                      'Error code: ${result.typeCodeError?.toString() ?? ''}',
                      style: const TextStyle()
                    ),
                    Text(
                       'Error message: ${result.errorMessage ?? ''}',
                      style: const TextStyle()
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}