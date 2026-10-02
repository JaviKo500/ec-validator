import 'package:flutter/widgets.dart';

import 'package:ec_validator/shared/messages_locale.dart';

/// Makes [AppStrings.of] rebuild its callers when the language changes.
class AppStringsScope extends InheritedNotifier<ValueNotifier<String>> {
  AppStringsScope({super.key, required super.child})
    : super(notifier: messagesLocale);
}

/// User interface texts of the demo, one instance per language.
///
/// The validation messages come from `ec_validations`; these are only the
/// texts of the app around them.
class AppStrings {
  final String appTitle;
  final String appSubtitle;
  final String languageTooltip;

  final String navDni;
  final String navRuc;
  final String navPhone;

  final String tryIt;
  final String validatedAsYouType;
  final String clear;
  final String emptyResult;
  final String examples;
  final String examplesHint;
  final String valid;
  final String invalid;
  final String normalized;
  final String copy;
  final String codeCopied;

  final String dniTitle;
  final String dniDescription;
  final String dniInputLabel;

  final String rucTitle;
  final String rucDescription;
  final String rucInputLabel;
  final String rucTypeLabel;
  final String rucAnyLabel;
  final String rucAnyDescription;
  final String rucNaturalLabel;
  final String rucNaturalDescription;
  final String rucPrivateLabel;
  final String rucPrivateDescription;
  final String rucPublicLabel;
  final String rucPublicDescription;
  final String rucQuickLabel;
  final String rucQuickDescription;

  final String phoneTitle;
  final String phoneDescription;
  final String phoneInputLabel;
  final String phoneFormatLabel;
  final String phoneAnyLabel;
  final String phoneAnyDescription;
  final String phoneLocalLabel;
  final String phoneLocalDescription;
  final String phoneInternationalLabel;
  final String phoneInternationalDescription;

  final String about;
  final String aboutDescription;
  final String madeBy;
  final String linkPubDev;
  final String linkPackageSource;
  final String linkDemoSource;
  final String linkIssues;

  const AppStrings({
    required this.appTitle,
    required this.appSubtitle,
    required this.languageTooltip,
    required this.navDni,
    required this.navRuc,
    required this.navPhone,
    required this.tryIt,
    required this.validatedAsYouType,
    required this.clear,
    required this.emptyResult,
    required this.examples,
    required this.examplesHint,
    required this.valid,
    required this.invalid,
    required this.normalized,
    required this.copy,
    required this.codeCopied,
    required this.dniTitle,
    required this.dniDescription,
    required this.dniInputLabel,
    required this.rucTitle,
    required this.rucDescription,
    required this.rucInputLabel,
    required this.rucTypeLabel,
    required this.rucAnyLabel,
    required this.rucAnyDescription,
    required this.rucNaturalLabel,
    required this.rucNaturalDescription,
    required this.rucPrivateLabel,
    required this.rucPrivateDescription,
    required this.rucPublicLabel,
    required this.rucPublicDescription,
    required this.rucQuickLabel,
    required this.rucQuickDescription,
    required this.phoneTitle,
    required this.phoneDescription,
    required this.phoneInputLabel,
    required this.phoneFormatLabel,
    required this.phoneAnyLabel,
    required this.phoneAnyDescription,
    required this.phoneLocalLabel,
    required this.phoneLocalDescription,
    required this.phoneInternationalLabel,
    required this.phoneInternationalDescription,
    required this.about,
    required this.aboutDescription,
    required this.madeBy,
    required this.linkPubDev,
    required this.linkPackageSource,
    required this.linkDemoSource,
    required this.linkIssues,
  });

  /// Texts for the selected language; rebuilds [context] when it changes.
  static AppStrings of(BuildContext context) {
    context.dependOnInheritedWidgetOfExactType<AppStringsScope>();
    return forLocale(messagesLocale.value);
  }

  static AppStrings forLocale(String code) => switch (code) {
    'es' => es,
    'pt' => pt,
    _ => en,
  };

  static const en = AppStrings(
    appTitle: 'ec_validations · Interactive demo',
    appSubtitle: 'Interactive demo',
    languageTooltip: 'Language',
    navDni: 'ID card',
    navRuc: 'RUC',
    navPhone: 'Phone',
    tryIt: 'Try it',
    validatedAsYouType: 'Validated as you type',
    clear: 'Clear',
    emptyResult: 'Type a value or pick an example to see the result.',
    examples: 'Examples',
    examplesHint: 'Tap any example to load it in the form.',
    valid: 'Valid',
    invalid: 'Invalid',
    normalized: 'Normalized',
    copy: 'Copy',
    codeCopied: 'Code copied to clipboard',
    dniTitle: 'ID card (cédula)',
    dniDescription:
        'Validates the 10-digit Ecuadorian ID: province code, third digit '
        'and modulo 10 check digit.',
    dniInputLabel: 'ID number',
    rucTitle: 'RUC',
    rucDescription:
        'Validates the 13-digit taxpayer number (Registro Único de '
        'Contribuyentes) by type.',
    rucInputLabel: 'RUC number',
    rucTypeLabel: 'RUC type',
    rucAnyLabel: 'Any type',
    rucAnyDescription:
        'Accepts a RUC of a natural person, private company or public '
        'entity.',
    rucNaturalLabel: 'Natural person',
    rucNaturalDescription:
        'Third digit 0–5: an ID card number followed by the establishment '
        'code.',
    rucPrivateLabel: 'Private company',
    rucPrivateDescription: 'Third digit 9, modulo 11 check digit.',
    rucPublicLabel: 'Public entity',
    rucPublicDescription:
        'Third digit 6, modulo 11 check digit on the first 8 digits.',
    rucQuickLabel: 'Quick check',
    rucQuickDescription:
        'Checks only the length and the province code, without the check '
        'digit.',
    phoneTitle: 'Phone number',
    phoneDescription:
        'Validates Ecuadorian mobile and landline numbers and returns them '
        'normalized.',
    phoneInputLabel: 'Phone number',
    phoneFormatLabel: 'Phone format',
    phoneAnyLabel: 'Any',
    phoneAnyDescription:
        'Accepts local (0991234567) or international (+593991234567) '
        'notation.',
    phoneLocalLabel: 'Local',
    phoneLocalDescription:
        'Only local notation: 09 for mobile, 02–07 for landlines.',
    phoneInternationalLabel: 'International',
    phoneInternationalDescription:
        'Only international notation with the +593 country code.',
    about: 'About',
    aboutDescription:
        'This demo uses ec_validations, an open source Dart package to '
        'validate Ecuadorian ID cards, RUC and phone numbers.',
    madeBy: 'Made by',
    linkPubDev: 'pub.dev',
    linkPackageSource: 'Package source',
    linkDemoSource: 'Demo source',
    linkIssues: 'Report an issue',
  );

  static const es = AppStrings(
    appTitle: 'ec_validations · Demo interactiva',
    appSubtitle: 'Demo interactiva',
    languageTooltip: 'Idioma',
    navDni: 'Cédula',
    navRuc: 'RUC',
    navPhone: 'Teléfono',
    tryIt: 'Pruébalo',
    validatedAsYouType: 'Se valida mientras escribes',
    clear: 'Borrar',
    emptyResult: 'Escribe un valor o elige un ejemplo para ver el resultado.',
    examples: 'Ejemplos',
    examplesHint: 'Toca un ejemplo para cargarlo en el formulario.',
    valid: 'Válido',
    invalid: 'Inválido',
    normalized: 'Normalizado',
    copy: 'Copiar',
    codeCopied: 'Código copiado al portapapeles',
    dniTitle: 'Cédula de identidad',
    dniDescription:
        'Valida la cédula ecuatoriana de 10 dígitos: código de provincia, '
        'tercer dígito y dígito verificador (módulo 10).',
    dniInputLabel: 'Número de cédula',
    rucTitle: 'RUC',
    rucDescription:
        'Valida el Registro Único de Contribuyentes de 13 dígitos según su '
        'tipo.',
    rucInputLabel: 'Número de RUC',
    rucTypeLabel: 'Tipo de RUC',
    rucAnyLabel: 'Cualquier tipo',
    rucAnyDescription:
        'Acepta el RUC de una persona natural, una sociedad privada o una '
        'entidad pública.',
    rucNaturalLabel: 'Persona natural',
    rucNaturalDescription:
        'Tercer dígito de 0 a 5: un número de cédula seguido del código de '
        'establecimiento.',
    rucPrivateLabel: 'Sociedad privada',
    rucPrivateDescription: 'Tercer dígito 9, dígito verificador módulo 11.',
    rucPublicLabel: 'Entidad pública',
    rucPublicDescription:
        'Tercer dígito 6, dígito verificador módulo 11 sobre los primeros 8 '
        'dígitos.',
    rucQuickLabel: 'Verificación rápida',
    rucQuickDescription:
        'Solo revisa la longitud y el código de provincia, sin el dígito '
        'verificador.',
    phoneTitle: 'Número de teléfono',
    phoneDescription:
        'Valida números móviles y fijos de Ecuador y los devuelve '
        'normalizados.',
    phoneInputLabel: 'Número de teléfono',
    phoneFormatLabel: 'Formato del teléfono',
    phoneAnyLabel: 'Cualquiera',
    phoneAnyDescription:
        'Acepta notación local (0991234567) o internacional '
        '(+593991234567).',
    phoneLocalLabel: 'Local',
    phoneLocalDescription:
        'Solo notación local: 09 para móviles, 02–07 para fijos.',
    phoneInternationalLabel: 'Internacional',
    phoneInternationalDescription:
        'Solo notación internacional con el código de país +593.',
    about: 'Acerca de',
    aboutDescription:
        'Esta demo usa ec_validations, un paquete Dart de código abierto para '
        'validar cédulas, RUC y números de teléfono de Ecuador.',
    madeBy: 'Creado por',
    linkPubDev: 'pub.dev',
    linkPackageSource: 'Código del paquete',
    linkDemoSource: 'Código de la demo',
    linkIssues: 'Reportar un problema',
  );

  static const pt = AppStrings(
    appTitle: 'ec_validations · Demonstração interativa',
    appSubtitle: 'Demonstração interativa',
    languageTooltip: 'Idioma',
    navDni: 'Cédula',
    navRuc: 'RUC',
    navPhone: 'Telefone',
    tryIt: 'Experimente',
    validatedAsYouType: 'Validado enquanto você digita',
    clear: 'Limpar',
    emptyResult: 'Digite um valor ou escolha um exemplo para ver o resultado.',
    examples: 'Exemplos',
    examplesHint: 'Toque em um exemplo para carregá-lo no formulário.',
    valid: 'Válido',
    invalid: 'Inválido',
    normalized: 'Normalizado',
    copy: 'Copiar',
    codeCopied: 'Código copiado para a área de transferência',
    dniTitle: 'Cédula de identidade',
    dniDescription:
        'Valida a cédula equatoriana de 10 dígitos: código da província, '
        'terceiro dígito e dígito verificador (módulo 10).',
    dniInputLabel: 'Número da cédula',
    rucTitle: 'RUC',
    rucDescription:
        'Valida o Registro Único de Contribuyentes (RUC) de 13 dígitos por '
        'tipo.',
    rucInputLabel: 'Número do RUC',
    rucTypeLabel: 'Tipo de RUC',
    rucAnyLabel: 'Qualquer tipo',
    rucAnyDescription:
        'Aceita o RUC de uma pessoa física, empresa privada ou entidade '
        'pública.',
    rucNaturalLabel: 'Pessoa física',
    rucNaturalDescription:
        'Terceiro dígito de 0 a 5: um número de cédula seguido do código do '
        'estabelecimento.',
    rucPrivateLabel: 'Empresa privada',
    rucPrivateDescription: 'Terceiro dígito 9, dígito verificador módulo 11.',
    rucPublicLabel: 'Entidade pública',
    rucPublicDescription:
        'Terceiro dígito 6, dígito verificador módulo 11 sobre os 8 '
        'primeiros dígitos.',
    rucQuickLabel: 'Verificação rápida',
    rucQuickDescription:
        'Verifica apenas o comprimento e o código da província, sem o '
        'dígito verificador.',
    phoneTitle: 'Número de telefone',
    phoneDescription:
        'Valida números de celular e fixos do Equador e os retorna '
        'normalizados.',
    phoneInputLabel: 'Número de telefone',
    phoneFormatLabel: 'Formato do telefone',
    phoneAnyLabel: 'Qualquer',
    phoneAnyDescription:
        'Aceita notação local (0991234567) ou internacional '
        '(+593991234567).',
    phoneLocalLabel: 'Local',
    phoneLocalDescription:
        'Apenas notação local: 09 para celular, 02–07 para fixo.',
    phoneInternationalLabel: 'Internacional',
    phoneInternationalDescription:
        'Apenas notação internacional com o código do país +593.',
    about: 'Sobre',
    aboutDescription:
        'Esta demonstração usa o ec_validations, um pacote Dart de código '
        'aberto para validar cédulas, RUC e números de telefone do Equador.',
    madeBy: 'Criado por',
    linkPubDev: 'pub.dev',
    linkPackageSource: 'Código do pacote',
    linkDemoSource: 'Código da demonstração',
    linkIssues: 'Relatar um problema',
  );
}
