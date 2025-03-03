
# ec_validator

A library for validating Ecuadorian identification documents (ID card and RUC)."

#### Null-Safety, Dart 3, with zero external dependencies

#### iOS, Android, Linux, Mac, Web, Windows ready

## **Installation**

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    ec_validator: '^1.0.0+1'
```


#### 2. Install it

You can install packages from the command line:

```bash
$ pub get
..
```

Alternatively, your editor might support pub. Check the docs for your editor to learn more.

#### 3. Import it

Now in your Dart code, you can use:

```Dart
import 'package:ec_validator/entities/index.dart';
```

## Usage/Examples

```dart
void main() {
  final result = DniValidator
   .isValid('0105566046');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
  final resultRucPerson = RucValidator
   .validateRucByType('0105566046001', TypeIdentification.rucPersonNatural);
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
  final resultRuc = RucValidator.validateRuc('0105566046001');
  /**
   * isValid: true or false
   * errorMessage: null or error string message
   * typeCodeError: null or error code
  */
}
```

## Running Tests

To run tests, run the following command

```bash
  flutter test
```


## License

[LICENSE](LICENSE)


## Authors

- [@JaviKo500](https://www.github.com/JaviKo500)

