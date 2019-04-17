<meta charset="utf-8"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/3.0.3/normalize.css">
<link rel="stylesheet" href="/Users/ms1/Programmierung/Sprachen/milligram/milligram.min.css">

# soacsv2mt940

## Übersicht
Convert Statement Of Account .CSV to MT940 (swift) format -- Konvertierung Bankauszüge im .CSV-Format ins MT940-Format (SWIFT)

## Aufruf
Aufruf:

    soacsv2mt940 -c, --csv <file> [-m, --mt940 <file>] [-n, --nbr <number>] [-b, --balance <amount>]

Beispiel:

    soacsvmt940 -c bank.csv --mt940 bank.txt -n 001 --balance -1523,89

Parameter:

- `-c, --csv <filename>`: Name der Eingabe-Datei im .csv-Format, welche ins mt940-Format konvertiert werden soll.
- `-m, --mt940 <filename>`: optionaler Name der Ausgabe-Datei; falls nicht angegeben, wird die Endung Eingabe-Datei durch .mt940 ersetzt.
- `-n, --nbr <number>`: optionale Kontoauszugs-Nr., welche im Kopf-Bereich der mt940-Datei (Satzart :28c:) vermerkt wird. Wird der Parameter nicht angegeben, wird 0 genommen.
- `-b, --balance <amount>`: optionaler Eröffungs-Saldo des Kontoauszugs. Wird dieser nicht mit übergeben, so wird 0 genommen.
- `-h, --help`: Anzeigen der Hilfe.

## Hintergrund
Einsatz-Szenario: Konto bei der Commerzbank, Buchhaltung mittels Collmex; automatische Übernahme der Auszüge der Commerzbank in die Collmex-Buchhaltung.

Die Commerzbank liefert Bankauszüge aktuell in zwei Formaten aus: als .CSV-Datei oder per HBCI mit Chipkarte (!). In Collmex können sie allerdings entweder als MT940-Datei importiert oder per HBCI mit PIN (!) eingelesen werden, so dass keine direkte Möglichkeit besteht, die Auszüge von der Commerzbank in Collmex zu importieren.

Eine Option ist, die Kontoauszüge  zunächst per HBCI mit Chipkarte in ein kommerzielles Programm wie bspw. Bank X zu importieren und dann von dort ins MT940-Format zu exportieren, um sie so wiederum nach Collmex zu bekommen.

Da eine entsprechende Software dann aber ausschließlich zu diesem Zweck im Einsatz wäre, kostenpflichtig ist und der für HBCI mit Chipkarte notwendige Chipkartenleser unterwegs nur schwerlich einsetzbar ist, wird ein Konvertierungsprogramm benötigt, welches die [.CSV-Kontoauszugsdatei] [1] der Commerzbank entsprechend ins [MT940-Format] [2] ([Details] [3])/ eine [MT940-Datei] [4] für den Import nach Collmex umwandelt. 

## Umsetzung
Das Programm soll später nicht nur lokal sondern ggf. auch als Dienst / Webservice laufen, weshalb es in Ruby umgesetzt ist.

### Eingabe
Die Eingabe des Namens der zu verarbeitenden .CSV-Kontoauszugsdatei erfolgt zunächst per Kommandozeile beim Aufruf des Programms durch Übergabe des Dateinamens. Später soll die Datei per Datei-Browser ausgewählt werden können.

Die Eingabedatei wird diversen Prüfungen unterzogen (Datei nicht vorhanden, leer, etc.)

### Verarbeitung
Parsen .CSV - ermitteln der Felder mit diversen Prüfungen (Überschriftszeile, etc.)

Umwandeln ins Format mt940 in den Schritten (gemäß [mt940-Dateiaufbau] [3]):

* Kopf
* Rumpf
* Fuss

### Ausgabe
Die Ausgabe erfolgt im gleichen Verzeichnis und unter gleichem Namen wie die Eingabe-Datei, nur mit der Endung .mt940. Falls die Ausgabedatei schon vorhanden ist, wird der Dateiname um eine lfd. Nr. erweitert.

### ToDo
Folgende Punkte sind noch umzusetzen:

v1.0:

- Abhängigkeit auf Filesystem/Verzeichnisstruktur aus Rakefile raus nehmen
- Namensgebung Klassen, Methoden, Variablen optimieren
- strftime auf .year, etc. umstellen?
- GVC anhand :umsatzart setzen
- Auf GEM umstellen

v2.0:

- Datei per Dialog auswählen
- Server-Version
- Heroku-Deployment


---

[1]:data/test.csv
[2]:http://de.wikipedia.org/wiki/MT940
[3]:data/datenstruktur-mt940-swift.pdf
[4]:data/soamt940_test_template.mt940