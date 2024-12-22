import 'dart:io';
import 'dart:math';

List<Map<String, String>> accounts = []; // Liste zur Speicherung der Accounts
List<String> passwords = []; // Liste zur Speicherung der Passwörter.

void main () {
  while (true) {
    print("\nWillkommen bei MysafeLock");
    print("\nWählen Sie eine Option:");
    print("1. Account anlegen");
    print("2. Sicheren Passwort-Generator");
    print("3. Gespeicherte Daten anzeigen");
    print("4. Beenden");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createAccount();
        break;
      case '2':
        generateSecurePassword();
        break;
      case '3':
        showSavedData();
        break;
      case '4':
        print("Programm beendet. Vielen Dank fürs Nutzen von MysafeLock!");
        exit(0);
      default:
        print("Ungültige Auswahl. Bitte versuchen Sie es erneut.");
    }
  }
}

void createAccount() {
  print("\n--- Account erstellen ---");

  stdout.write("Geben Sie Ihren Namen ein: ");
  String? name = stdin.readLineSync();

  stdout.write("Geben Sie Ihr Alter ein: ");
  String? ageInput = stdin.readLineSync();
  int? age = int.tryParse(ageInput ?? "");

  if (age == null) {
    print("Ungültige Eingabe für das Alter.");
    return;
  }

  String accountType = (age < 18) ? "Kinder-Account" : "Erwachsenen-Account";
  print("$accountType für $name wurde erstellt.");

  // Speichern des Accounts in der Liste
  accounts.add({'Name': name ?? "Unbekannt", 'Typ': accountType});
}

void generateSecurePassword() {
  print("\n--- Sicherer Passwort-Generator ---");

  stdout.write("Geben Sie die gewünschte Passwort-Länge ein: ");
  String? lengthInput = stdin.readLineSync();
  int? length = int.tryParse(lengthInput ?? "");

  if (length == null || length < 4) {
    print("Die Passwort-Länge muss eine Zahl größer als 3 sein.");
    return;
  }

  String password = generatePassword(length);
  print("Ihr generiertes Passwort lautet: $password");
  stdout.write("Möchten Sie das Passwort speichern? (ja/Nein): ");
  String? save = stdin.readLineSync();
  if (save?.toLowerCase() == 'ja') {
    passwords.add(password);
    print("Das Passwort wurde lokal gespeichert.");
  } else {
    print("Das Passwort wurde nicht gespeichert.");
  }
}

String generatePassword(int length) {
  const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';
  Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}

void showSavedData() {
  print("\n--- Gespeicherte Accounts ---");
  for (var account in accounts) {
    print("Name: ${account['Name']}, Typ: ${account['Typ']}");
  }

  if (passwords.isNotEmpty) {
    print("\n--- Gespeicherte Passwörter ---");
    for (var password in passwords) {
      print(password);
    }
  } else {
    print("\nKeine Passwörter gespeichert.");
  }
}
