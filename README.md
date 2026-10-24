# GrevingFit

GrevingFit ist eine installierbare PWA für die Trainingsprofile Carsten, Kathrin, Mathilda und Mariette. Jedes Profil kann ein eigenes vollständiges Farbschema verwenden.

## Start und Installation

Die Dateien über HTTPS bereitstellen, zum Beispiel mit GitHub Pages. Installation und Service Worker funktionieren nur in einem sicheren Browserkontext (HTTPS oder localhost). Nach Änderungen an der App prüft der Service Worker auf eine neue Version. Ist sie heruntergeladen, fragt GrevingFit, ob jetzt aktualisiert und neu geladen werden soll.

Es gibt keinen Build-Schritt. `index.html`, `app.js`, `styles.css`, `manifest.webmanifest`, `service-worker.js` und `icon.svg` bilden die PWA.

## Training

- Wochenplanung entfernt: Einheiten werden am tatsächlichen Speichertag datiert.
- Gespeicherte Vorlagen können wiederverwendet werden.
- Freie Trainings lassen sich spontan aus Katalogübungen zusammenstellen, protokollieren und optional als Vorlage sichern.
- Historie, Gewichte, Wiederholungen, Notizen und Auswertungen bleiben enthalten.
- Der Übungskatalog verwendet ausschließlich Beine, Rumpf, Rücken, Brust, Arme, Schultern und Sonstige. Eine Satzpause wird nicht mehr verwaltet.
- Hamburger-Menü oben links öffnet die Navigation.

## Supabase-Cloud für vier Personen

Die App enthält die URL und den Publishable Key des konfigurierten Supabase-Projekts. Jeder Benutzer erstellt ein eigenes Supabase-Konto mit E-Mail und Passwort. Die Profilwahl ist an die jeweils freigegebene E-Mail-Adresse gebunden; die Zuordnung ist in App und Datenbankregel hinterlegt. Die Datenbank bindet Trainingseinträge an die Supabase-User-ID und schützt sie per Row Level Security.

1. Im Supabase-Projekt unter **SQL Editor** den Inhalt von [`supabase-setup.sql`](supabase-setup.sql) ausführen. Das Skript legt Datentabellen und RLS-Regeln an, einschließlich der Profil-/E-Mail-Zuordnung. Führe es nach Regeländerungen erneut aus; es kann wiederholt werden.
2. Unter **Authentication → Providers** E-Mail-Anmeldung aktivieren. Unter **URL Configuration** die HTTPS-URL von GrevingFit als Site URL setzen.
3. GrevingFit aufrufen, oben rechts auf das Wolkensymbol tippen, Konto erstellen, das zur E-Mail passende Profil auswählen und E-Mail sowie Passwort eingeben. Abweichende Zuordnungen werden abgelehnt. Wenn E-Mail-Bestätigung eingeschaltet ist, erst die Mail bestätigen und danach anmelden.
4. Auf weiteren Geräten dieselbe HTTPS-Adresse öffnen und mit dem Konto dieses Profils anmelden.

Jede Person braucht eigene Zugangsdaten. Ein Profilname kann nur von einem Konto beansprucht werden. Die vier Konten teilen zwar dasselbe Supabase-Projekt, aber die RLS-Regeln erlauben jedem Konto nur den Zugriff auf seine eigene Datenzeile. Verwende niemals einen Supabase-Secret- oder Service-Role-Key im Frontend.

Bei der ersten Anmeldung übernimmt GrevingFit lokale Daten, wenn noch kein anderes Profil mit Cloud-Daten auf dem Gerät verwendet wurde. Wechselt man auf einem Gerät das Profil, wird zuerst eine sichere Auswahl gezeigt, damit Daten nicht versehentlich einem anderen Konto zugeordnet werden.

## Lokale Sicherung

Unter **Settings → Daten auf diesem Gerät** lässt sich eine JSON-Datei mit Trainingsplan, Katalog, Verlauf und Einstellungen exportieren oder importieren. Die App führt weiterhin eine lokale Offline-Kopie.

## Profilgebundene Personalisierung

Unter **Settings → Personalisierung** lassen sich Startbereich, vollständiges Farbschema, Schriftgröße, Darstellungsdichte sowie helles oder dunkles Design einstellen. Die Farbschemata stimmen Hauptfarbe, Akzentfarbe, Hintergründe und Flächen aufeinander ab. Bei einem angemeldeten Familienprofil werden diese Einstellungen zusammen mit dessen Trainingsdaten in der Cloud gespeichert und auf weiteren Geräten übernommen. Das Gastprofil verwendet davon getrennte lokale Einstellungen.


### Übungen und Sätze im Training abschließen

In Vorlagen- und spontanen Trainings kann jeder Satz einzeln abgehakt werden. Sind alle Sätze abgehakt, gilt die Übung automatisch als fertig. Wird ein Haken entfernt, ist die Übung wieder offen. Mit „Fertig“ werden alle vollständig ausgefüllten Sätze gemeinsam abgeschlossen; „Heute auslassen“ protokolliert die Übung als nicht durchgeführt. Der Zwischenstand wird lokal gespeichert. Ausgelassene Übungen zählen nicht zu Satzanzahl, Volumen oder Übungsfortschritt und ersetzen keine bisherigen Katalogwerte. Eine aus dem Verlauf erstellte Vorlage übernimmt nur durchgeführte Übungen.
