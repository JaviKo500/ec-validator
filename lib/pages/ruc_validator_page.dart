import 'package:ec_validator/shared/lang_choice_options.dart';
import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

class RucValidatorPage extends StatefulWidget {
  const RucValidatorPage({super.key});

  @override
  State<RucValidatorPage> createState() => _RucValidatorPageState();
}

class _RucValidatorPageState extends State<RucValidatorPage> {
  final _formKey = GlobalKey<FormState>();

  TypeIdentification typeIdentification = TypeIdentification.ruc;

  final List<String> identifications = [
    '0105566046000',
    '3095566046001',
    '95566046001',
    '0105566039001',
    '0105566046001',
  ];

  final List<String> identificationsPrivate = [
    '1790011674001',
    '09A2256230001',
    '3092256230001',
    '0992256230000',
    '0982256230001',
    '0992256230001',
    '1790450635001',
    '0992256234001',
    '1790450637001',
  ];

  final List<String> identificationsPublic = [
    '1760004650001',
    '1760001120001',
    '1760001120000',
    '1770001120001',
    '3060001120001',
    '17600011200',
    '1760004680001',
    '1760001110001',
  ];

  final List<String> listRuc = [
    '0105566046001',
    '1760004650001',
    '0992256230001',
    '0105566001',
    '1760004611001',
    '0992256223001',
  ];

  /// Validates using the method that matches the selected type.
  IdentificationResult validate(String ruc) {
    switch (typeIdentification) {
      case TypeIdentification.possiblyValidRuc:
        return RucValidator.isPossiblyValidRuc(ruc);
      case TypeIdentification.ruc:
        return RucValidator.validateRuc(ruc);
      default:
        return RucValidator.validateRucByType(ruc, typeIdentification);
    }
  }

  /// Sample RUC numbers shown for the selected type.
  List<String> get listRucTest {
    switch (typeIdentification) {
      case TypeIdentification.rucPersonNatural:
        return identifications;
      case TypeIdentification.rucSocietyPrivate:
        return identificationsPrivate;
      case TypeIdentification.rucPublicSociety:
      case TypeIdentification.possiblyValidRuc:
        return identificationsPublic;
      default:
        return listRuc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('EC RUC Validator', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LangChoiceOptions(
                  action: () => setState(() {}),
                ),
                const Text(
                  'Form',
                  style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    const SizedBox(height: 6,),
                    DropdownButtonFormField<TypeIdentification>(
                      decoration: InputDecoration(
                        labelText: 'Identification type',
                        hintText: 'Identification type',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        )
                      ),
                      initialValue: typeIdentification,
                      items: TypeIdentification.values.where( (item) => item != TypeIdentification.dni ).map( (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.name),
                      )).toList(),
                      onChanged: (value) {
                        if ( value != null ) {
                          setState(() {
                            typeIdentification = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 6,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'RUC',
                        hintText: '0100000000001',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        errorMaxLines: 3,
                      ),
                      validator: (value) {
                        final result = validate(value ?? '');
                        return result.isValid ? null : result.errorMessage;
                      },
                    ),
                    const SizedBox(height: 10),
                    _formKey.currentState?.validate() == true
                        ? const Text(
                          'Valid RUC',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )
                        )
                        : const SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.validate();
                        setState(() {});
                      },
                      child: const Text('Validate'),
                    ),
                    TextButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.purple,),),
                    )
                  ],
                )),
                const Text(
                  'Examples',
                  style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listRucTest.length,
                itemBuilder: (context, index) {
                  final identification = listRucTest[index];
                  final result = validate(identification);
                  return Card(
                    child: ListTile(
                      title: Text(identification),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('isValid: ${result.isValid.toString()}',
                              style: const TextStyle()),
                          Text(
                              'Error code: ${result.typeCodeError?.toString() ?? ''}',
                              style: const TextStyle()),
                          Text('Error message: ${result.errorMessage ?? ''}',
                              style: const TextStyle()),
                          Text(
                              'Message in EN: ${result.messageIn(EcMessagesEn()) ?? ''}',
                              style: const TextStyle()),
                        ],
                      ),
                    ),
                  );
                },
                              ),
              ],
            ),
          ),
        ));
  }
}
