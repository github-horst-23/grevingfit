# GrevingFit

Installierbare Trainings-App für Carsten, Kathrin, Mathilda und Mariette. Jedes Konto hat eigene Vorlagen, einen eigenen Übungskatalog, Trainingsverlauf und persönliche Einstellungen.

## Start und Installation

GrevingFit benötigt keinen Build-Schritt. Die Dateien aus `GrevingFit-PWA.zip` direkt im Webverzeichnis bereitstellen, zum Beispiel über GitHub Pages. Für Installation und Offline-Nutzung ist HTTPS oder `localhost` erforderlich.

Im Smartphone-Browser die App installieren oder zum Startbildschirm hinzufügen. Die stabile Manifest-ID `/grevingfit/` unterscheidet sie von GrevingShop (`/grevingshop/`); beide Apps können gleichzeitig installiert werden. Startadresse und Gültigkeitsbereich beziehen sich auf das jeweilige App-Verzeichnis (`./`).

### App aktualisieren

Neue Versionen werden mit **Jetzt aktualisieren** und **Später** angeboten. Ein verschobener Hinweis lässt sich über das Aktualisierungssymbol im Kopfbereich wieder öffnen. Erst nach Zustimmung wird die neue Version aktiviert. Laufende Trainings vorher zwischenspeichern und offene Bearbeitungen schließen.

## Anmeldung und Profile

Über **?** im Kopfbereich oder **Settings → Anmelden** mit E-Mail-Adresse und bestehendem Kontopasswort anmelden. Das freigegebene Familienprofil wird automatisch zugeordnet. Die App bietet keine Registrierung; die vier Konten müssen in Supabase bereitgestellt sein. Bei der ersten Anmeldung gilt das dort eingerichtete Initialpasswort.

GrevingFit und GrevingShop verwenden dieselben Supabase-Konten. Unter **Settings → Passwort ändern** lassen sich aktuelles Passwort, neues Passwort und Wiederholung eingeben. Das neue Passwort muss mindestens acht Zeichen lang sein und gilt für beide Apps.

Anmeldungen werden lokal für 30 Tage seit der letzten Nutzung beziehungsweise Token-Erneuerung aufbewahrt. Serverseitige Sitzungsregeln, widerrufene Sitzungen oder gelöschte Browserdaten können eine frühere Neuanmeldung erfordern. Passwörter werden nicht in den App-Daten gespeichert. Abmelden betrifft nur die aktuelle App-Sitzung.

## Trainingsfunktionen

### Vorlagen und Übungskatalog

- Vorlagen erstellen, bearbeiten und wiederverwenden oder aus einem vergangenen Training übernehmen.
- Übungen hinzufügen, bearbeiten, entfernen und mit **↑ / ↓** umsortieren.
- Übungsnamen in Vorlagen nutzen bis zu zwei Zeilen. Antippen zeigt den vollständigen Namen; **⋯** öffnet **Bearbeiten** und **Entfernen**.
- Neue Katalogübungen über den Knopf oben im Übungskatalog anlegen.
- Muskelgruppen: Beine, Rumpf, Rücken, Brust, Arme, Schultern, Cardio und Sonstige.

Jedes Konto hat einen eigenen Katalog. Beispielübungen werden als eigenständige Kopien übernommen; alternativ ist ein leerer Katalog möglich. Gastdaten und Gast-Einstellungen sind getrennt abgelegt und werden nur nach ausdrücklicher Auswahl in ein Konto kopiert.

### Laufendes Training

Ein Training aus einer Vorlage starten oder als freies Training zusammenstellen. Auch nach dem Start lassen sich weitere Übungen hinzufügen und die Reihenfolge ändern. Neue Übungen werden oben eingefügt.

- **Werte:** Gewicht mit Komma als Dezimaltrennzeichen; je Satz Wiederholungen oder Dauer erfassen. Zuletzt gespeicherte Satzwerte und die letzte Übungsnotiz dienen als Orientierung.
- **Cardio:** Zwischen Sekunden und Minuten wechseln. Minuten erlauben Dezimalwerte wie `12,5`; beim Wechsel wird die Dauer umgerechnet. Zeiten werden intern in Sekunden gespeichert, damit Vergleiche konsistent bleiben. Trainingsziele können beispielsweise `20 Min.` lauten.
- **Sätze abhaken:** Sind alle Sätze abgehakt, gilt die Übung als fertig. Wird ein Haken entfernt, ist sie wieder offen.
- **Fertig:** Schließt eine Übung auch unvollständig ab, ohne weitere Sätze abzuhaken. Nur abgehakte Sätze gehen in den Verlauf ein.
- **Heute auslassen:** Kennzeichnet eine Übung als nicht durchgeführt. Sie zählt nicht zur Trainingsleistung und überschreibt keine früheren Satzwerte.
- **Zwischenspeichern:** Sichert den Zwischenstand lokal auf diesem Gerät, damit das Training später fortgesetzt werden kann.

Beim Speichern erhält die Einheit das aktuelle Datum. Freie Trainings können zusätzlich als Vorlage gesichert werden. Anschließend erscheint eine Zusammenfassung mit Dauer, Volumen und neuen persönlichen Bestleistungen.

### Verlauf und Auswertung

Der Verlauf zeigt gespeicherte Einheiten mit Satzwerten und Übungsnotizen. Daraus lassen sich Vorlagen mit den durchgeführten Übungen erstellen. Einheiten desselben Tages können zusammengeführt werden; die App schlägt dies vor. Löschaktionen für Einheiten, Vorlagen und Übungen lassen sich unmittelbar rückgängig machen.

Die Auswertung bietet:

- Trainingskennzahlen und wöchentliches Volumen.
- Fortschrittskurven je Übung und persönliche Bestleistungen, nach Muskelgruppen eingeklappt.
- Fortschritt nach Muskelgruppen als prozentuale Veränderung mit aufklappbaren Kurven und Details. Zeiträume: acht Wochen, sechs Monate oder gesamte Historie.
- Einen Monatskalender: Je mehr Übungen an einem Tag ausgeführt wurden, desto kräftiger die Farbe. Vergleichsmaßstab ist der höchste Tageswert der **gesamten Historie**, sodass die Farben über Monate vergleichbar bleiben. Mehrere Einheiten pro Tag werden addiert; ausgelassene Übungen zählen nicht.

## Einstellungen und Sicherung

Unter **Settings → Personalisierung** Startbereich, Farbschema, Schriftgröße, Darstellungsdichte sowie helles oder dunkles Design wählen. Einstellungen angemeldeter Profile werden zusammen mit den Trainingsdaten synchronisiert. Das Gastprofil verwendet getrennte lokale Einstellungen.

Unter **Settings → Daten auf diesem Gerät** lassen sich Vorlagen, Katalog, Verlauf und Einstellungen als JSON exportieren oder importieren. Die Sicherung enthält keine Login-Passwörter. Trainingsentwürfe bleiben lokal auf dem jeweiligen Gerät.

## Supabase einrichten

Die App enthält die konfigurierte Projekt-URL und einen öffentlichen Publishable Key. Kontodaten werden in `fitness_data` über die Supabase-User-ID getrennt; Row Level Security schützt den Zugriff.

1. [supabase-setup.sql](supabase-setup.sql) im Supabase SQL Editor ausführen. Das Skript kann erneut ausgeführt werden, um die enthaltenen Regeln einzurichten.
2. E-Mail-Anmeldung aktivieren und die HTTPS-Adresse der App als Site URL konfigurieren.
3. Die vier Familienkonten administrativ bereitstellen. Freigegebene E-Mail-Adressen müssen mit der Zuordnung in App und Datenbankregeln übereinstimmen.
4. Auf jedem Gerät mit dem jeweiligen Konto anmelden. Bei einer Datenauswahl prüfen, ob lokale Daten oder Cloud-Daten übernommen werden sollen.

Für parallele Nutzung von GrevingFit, GrevingShop und mehreren Geräten darf **Single session per user** nicht aktiviert sein. Für die gewünschte 30-Tage-Anmeldung dürfen serverseitige Time-box- und Inactivity-Limits diese Frist nicht verkürzen. Diese Serverwerte werden von der App nicht gesetzt; die JWT-Laufzeit muss dafür nicht auf 30 Tage verlängert werden.

Secret- und Service-Role-Keys gehören niemals ins Frontend oder ins ZIP. Das SQL-Setup erstellt keine Auth-Konten und setzt keine Initialpasswörter.

## Projektdateien

| Datei | Zweck |
| --- | --- |
| `index.html` | App-Grundgerüst |
| `app.js` | Training, Profile, Synchronisierung und Bedienung |
| `auth-session.js` | Lokale Aufbewahrung der Anmeldesitzung |
| `styles.css` | Darstellung, Smartphone-Layout und Farbschemata |
| `service-worker.js` | Offline-Dateien und bestätigte App-Updates |
| `manifest.webmanifest`, `icon.svg` | PWA-Installation und App-Symbol |
| `supabase-setup.sql` | Tabellen und Zugriffsregeln |

Bei App-Änderungen Versionsangaben in `app.js`, `service-worker.js` und den Dateiverweisen in `index.html` konsistent erhöhen. Das vollständige Auslieferungs-ZIP enthält die oben genannten Dateien und diese README direkt auf Hauptebene. Veröffentlichungen erfolgen durch den Betreiber.
