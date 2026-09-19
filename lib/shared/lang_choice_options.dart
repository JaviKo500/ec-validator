import 'package:ec_validator/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ec_validations/ec_validations.dart';

class LangChoiceOptions extends StatelessWidget {
  final void  Function() action;
  const LangChoiceOptions({super.key,  required this.action });

  bool currentLang(String code) {
    return EcValidationsL10n.messages.localeCode == code;
  }

  void selectLang(String code) {
    EcValidationsL10n.use(code);
    action();
  }

  void registerOrUsePt() {
    if ( EcValidationsL10n.use('pt') ) {
      action();
      return;
    }

    EcValidationsL10n.register(EcMessagesPt());
    selectLang('pt');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lang',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          spacing: 12,
          children: [
            ChoiceChip(
              label: const Text('English', style: TextStyle()),
              onSelected: (value) => selectLang('en'),
              selected: currentLang('en'),
            ),
            ChoiceChip(
              label: const Text('Spanish', style: TextStyle()),
              onSelected: (value) => selectLang('es'),
              selected: currentLang('es'),
            ),
            ChoiceChip(
                label: const Text('Português', style: TextStyle()),
                onSelected: (value) => registerOrUsePt(),
                selected: currentLang('pt')),
          ],
        )
      ],
    );
  }
}
