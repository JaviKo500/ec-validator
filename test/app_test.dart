import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/l10n.dart';
import 'package:ec_validator/main.dart';
import 'package:ec_validator/shared/messages_locale.dart';

Future<void> pumpAppAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  useMessagesLocale('en');
  await tester.pumpWidget(const MyApp());
}

void main() {
  setUpAll(() => EcValidationsL10n.register(EcMessagesPt()));

  for (final size in const [Size(360, 800), Size(800, 1000), Size(1440, 900)]) {
    group('at ${size.width.toInt()}px', () {
      testWidgets('validates the ID typed in the form', (tester) async {
        await pumpAppAt(tester, size);

        expect(find.textContaining('Type a value'), findsOneWidget);

        await tester.enterText(find.byType(TextField).first, '0105566039');
        await tester.pumpAndSettle();
        expect(find.text('Invalid'), findsOneWidget);
        expect(find.text('ErrorCode.invalidVerificationDigit'), findsOneWidget);

        await tester.enterText(find.byType(TextField).first, '0105566046');
        await tester.pumpAndSettle();
        expect(find.text('Valid'), findsWidgets);
      });

      testWidgets('loads a tapped example and switches language', (
        tester,
      ) async {
        await pumpAppAt(tester, size);

        final example = find.text('01A5566046');
        await tester.ensureVisible(example);
        await tester.tap(example);
        await tester.pumpAndSettle();
        expect(find.text('errorMessage (EN)'), findsOneWidget);

        useMessagesLocale('pt');
        await tester.pumpAndSettle();
        expect(find.text('errorMessage (PT)'), findsOneWidget);
        expect(find.textContaining('Identificação inválida'), findsWidgets);
      });

      testWidgets('translates the app texts with the language', (tester) async {
        await pumpAppAt(tester, size);
        expect(find.text('Try it'), findsOneWidget);

        useMessagesLocale('es');
        await tester.pumpAndSettle();
        expect(find.text('Pruébalo'), findsOneWidget);
        expect(find.text('Ejemplos'), findsOneWidget);
        expect(find.text('Teléfono'), findsOneWidget);
        expect(find.text('Cédula de identidad'), findsOneWidget);

        await tester.tap(find.text('Teléfono'));
        await tester.pumpAndSettle();
        expect(find.text('Internacional'), findsOneWidget);

        useMessagesLocale('pt');
        await tester.pumpAndSettle();
        expect(find.text('Telefone'), findsOneWidget);
        expect(find.text('Experimente'), findsWidgets);
        expect(find.text('Try it'), findsNothing);
      });

      testWidgets('credits the author and links the project', (tester) async {
        await pumpAppAt(tester, size);

        final credit = find.text('@JaviKo500').first;
        await tester.ensureVisible(credit);
        expect(credit, findsOneWidget);
        expect(find.text('pub.dev'), findsWidgets);
        expect(find.text('Report an issue'), findsWidgets);

        if (size.width < 900) {
          await tester.tap(find.byTooltip('About'));
          await tester.pumpAndSettle();
          expect(find.byType(BottomSheet), findsOneWidget);
        }
      });

      testWidgets('navigates to the RUC and phone pages', (tester) async {
        await pumpAppAt(tester, size);

        await tester.tap(find.text('RUC').first);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Private company'));
        await tester.pumpAndSettle();
        expect(find.textContaining('Third digit 9'), findsOneWidget);

        await tester.tap(find.text('Phone').first);
        await tester.pumpAndSettle();
        await tester.tap(find.text('International'));
        await tester.enterText(find.byType(TextField).last, '0991234567');
        await tester.pumpAndSettle();
        expect(find.text('ErrorCode.invalidCountryCode'), findsNothing);
        expect(find.textContaining('PhoneErrorCode.'), findsWidgets);
      });
    });
  }
}
