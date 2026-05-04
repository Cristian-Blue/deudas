// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get login => 'Iniciar sesión';

  @override
  String get username => 'Usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get usernameRequired => 'El usuario es obligatorio';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get completeFields => 'Por favor completa todos los campos';
}
