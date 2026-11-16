# GrevingFit

GrevingFit ist eine installierbare PWA für die Trainingsprofile Carsten, Kathrin, Mathilda und Mariette. Jedes Profil kann ein eigenes vollständiges Farbschema verwenden.

## Start und Installation

Die Dateien über HTTPS bereitstellen, zum Beispiel mit GitHub Pages. Installation und Service Worker funktionieren nur in einem sicheren Browserkontext (HTTPS oder localhost). Nach Änderungen an der App prüft der Service Worker auf eine neue Version. Ist sie heruntergeladen, fragt GrevingFit, ob jetzt aktualisiert und neu geladen werden soll.

Es gibt keinen Build-Schritt. `index.html`, `app.js`, `styles.css`, `manifest.webmanifest`, `service-worker.js` und `icon.svg` bilden die PWA.

## Training

- Wochenplanung entfernt: Einheiten werden am tatsächlichen Speichertag datiert.
- Gespeicherte Vorlagen können wiederverwendet werden.
- Freie Trainings lassen sich spontan aus Katalogübungen zusammenstellen, protokollieren und optional als Vorlage sichern.
- Im laufenden Training können Übungen umsortiert und Vorschläge aus den letzten Satzwerten übernommen werden.
- Nach dem Speichern zeigt GrevingFit eine Trainingszusammenfassung mit Dauer, Volumen und neuen Bestleistungen.
- Historie, Gewichte, Wiederholungen, Notizen und Auswertungen bleiben enthalten.
- Die Auswertung enthält einen Monatskalender, persönliche Bestleistungen je Übung und Fortschrittskurven je Muskelgruppe. Diese zeigen die mittlere prozentuale Veränderung vergleichbarer Übungen im gewählten Zeitraum (8 Wochen, 6 Monate oder Gesamt). Einzelheiten der Berechnung und Übungswerte lassen sich aufklappen.
- Löschaktionen für Einheiten, Vorlagen und Übungen können unmittelbar rückgängig gemacht werden.
- Der Übungskatalog verwendet ausschließlich Beine, Rumpf, Rücken, Brust, Arme, Schultern, Cardio und Sonstige. Eine Satzpause wird nicht mehr verwaltet.
- Das Menü öffnet auf Smartphones unten rechts; auf größeren Bildschirmen befindet es sich oben links.

## Supabase-Cloud für vier Personen

Die App enthält die URL und den Publishable Key des konfigurierten Supabase-Projekts. Die vier Familienkonten werden in Supabase administrativ bereitgestellt. Die App bietet keine öffentliche Registrierung; Anmeldung erfolgt mit E-Mail-Adresse und dem aktuellen Kontopasswort (bei der ersten Anmeldung mit dem dort gesetzten Initialpasswort). Die Profilwahl ist an die jeweils freigegebene E-Mail-Adresse gebunden; die Zuordnung ist in App und Datenbankregel hinterlegt. Die Datenbank bindet Trainingseinträge an die Supabase-User-ID und schützt sie per Row Level Security.

1. Im Supabase-Projekt unter **SQL Editor** den Inhalt von [`supabase-setup.sql`](supabase-setup.sql) ausführen. Das Skript legt Datentabellen und RLS-Regeln an, einschließlich der Profil-/E-Mail-Zuordnung. Führe es nach Regeländerungen erneut aus; es kann wiederholt werden.
2. Unter **Authentication → Providers** E-Mail-Anmeldung aktivieren. Unter **URL Configuration** die HTTPS-URL von GrevingFit als Site URL setzen.
3. GrevingFit aufrufen und oben auf **?** oder unter Settings auf **Anmelden** tippen. E-Mail-Adresse und bestehendes Passwort eingeben; das Familienprofil wird automatisch zugeordnet.
4. Auf weiteren Geräten dieselbe HTTPS-Adresse öffnen und mit dem Konto dieses Profils anmelden.

Jede Person braucht eigene Zugangsdaten. Ein Profilname kann nur von einem Konto beansprucht werden. Die vier Konten teilen zwar dasselbe Supabase-Projekt, aber die RLS-Regeln erlauben jedem Konto nur den Zugriff auf seine eigene Datenzeile. Verwende niemals einen Supabase-Secret- oder Service-Role-Key im Frontend.

Bei der ersten Anmeldung übernimmt GrevingFit lokale Daten, wenn noch kein anderes Profil mit Cloud-Daten auf dem Gerät verwendet wurde. Wechselt man auf einem Gerät das Profil, wird zuerst eine sichere Auswahl gezeigt, damit Daten nicht versehentlich einem anderen Konto zugeordnet werden.

## Lokale Sicherung

Unter **Settings → Daten auf diesem Gerät** lässt sich eine JSON-Datei mit Trainingsplan, Katalog, Verlauf und Einstellungen exportieren oder importieren. Die App führt weiterhin eine lokale Offline-Kopie.

## Profilgebundene Personalisierung

Unter **Settings → Personalisierung** lassen sich Startbereich, vollständiges Farbschema, Schriftgröße, Darstellungsdichte sowie helles oder dunkles Design einstellen. Die Farbschemata stimmen Hauptfarbe, Akzentfarbe, Hintergründe und Flächen aufeinander ab. Bei einem angemeldeten Familienprofil werden diese Einstellungen zusammen mit dessen Trainingsdaten in der Cloud gespeichert und auf weiteren Geräten übernommen. Das Gastprofil verwendet davon getrennte lokale Einstellungen.


### Übungen und Sätze im Training abschließen

In Vorlagen- und spontanen Trainings kann jeder Satz einzeln abgehakt werden. Sind alle Sätze abgehakt, gilt die Übung automatisch als fertig. Wird ein Haken entfernt, ist die Übung wieder offen. Mit „Fertig“ wird eine Übung auch unvollständig geschlossen, ohne weitere Sätze abzuhaken; nur abgehakte Sätze werden gewertet; „Heute auslassen“ protokolliert die Übung als nicht durchgeführt. Der Zwischenstand wird lokal gespeichert. Ausgelassene Übungen zählen nicht zu Satzanzahl, Volumen oder Übungsfortschritt und ersetzen keine bisherigen Katalogwerte. Eine aus dem Verlauf erstellte Vorlage übernimmt nur durchgeführte Übungen.


### Persönliche Übungskataloge

Jedes Familienkonto hat einen eigenen Übungskatalog, lokal und in seiner Cloud-Datenzeile. Neue, geänderte und gelöschte Übungen wirken nur auf dieses Konto. Das Gastprofil hat eine getrennte lokale Ablage. Bestehende kontogebundene Kataloge bleiben erhalten. Neue Profile können mit eigenständigen Kopien der Beispiele oder mit leerem Katalog starten. Gastdaten werden nur nach ausdrücklicher Auswahl kopiert. Auch Synchronisierungsstände sind kontogebunden.


### Eigenständige App-Installation

Die stabile Manifest-ID lautet `/grevingfit/`. GrevingFit verwendet `/grevingfit/`, Greving.Shop `/grevingshop/`; beide Apps werden dadurch getrennt erkannt. Die IDs bleiben bei künftigen Updates unverändert. Startadresse und Gültigkeitsbereich bleiben relativ zum jeweiligen App-Verzeichnis (`./`). Die aktualisierten Dateien müssen zuerst auf der jeweiligen App-Webadresse veröffentlicht werden. Bei einer bisherigen Installation ohne diese ID kann eine erneute Installation erforderlich sein; vorher die Daten sichern.

## Gemeinsames Konto und Passwort ändern

GrevingFit und GrevingShop nutzen dasselbe Supabase-Auth-Projekt und damit dieselben Konten. Angemeldet unter **Settings → Passwort ändern** das Formular öffnen. Alternativ in der Cloud-Kontoverwaltung **Passwort ändern** wählen. Aktuelles Passwort, neues Passwort (mindestens 8 Zeichen) und Wiederholung eingeben. Nach dem Speichern gilt das neue Passwort für beide Apps. Passwörter werden nicht in App-Daten oder im ZIP gespeichert.

Auf ausdrücklichen Wunsch ist die E-Mail-Bestätigung im gemeinsamen Projekt ausgeschaltet. Neue Registrierungen benötigen dadurch keine Bestätigungsmail. Die Datenfreigaben bleiben bestehen, prüfen aber die E-Mail-Adresse ohne Besitznachweis. Noch nicht registrierte freigegebene Adressen können deshalb von Dritten beansprucht werden. Bestehende Konten wurden nicht zurückgesetzt. Für neue Konten wird das gewünschte Initialpasswort bei der Registrierung selbst eingegeben; es ist nicht öffentlich im Code hinterlegt.

Die Navigationssymbole für Settings, Übungskatalog und Einheiten/Vorlagen entsprechen den Symbolen von GrevingShop (Regler, Katalogbuch und Liste), mit derselben SVG-Geometrie und Strichstärke.


### Anmeldung und Katalog ab Version 77

Der Anmeldedialog entspricht GrevingShop: E-Mail-Adresse, Passwort, Abbrechen und Anmelden. Es gibt keine Kontoerstellung in der App. Die Profile werden anhand der vorhandenen Konten zugeordnet. Der Knopf **Neue Katalogübung** befindet sich direkt oben im Übungskatalog.

## Anmeldung für 30 Tage beibehalten

Version 79: Die bestehende Supabase-Sitzung wird für 30 Tage seit der letzten Nutzung lokal aufbewahrt. Nutzung und Token-Erneuerung verlängern diese Frist. Bestehende Anmeldungen werden ohne erzwungenen Wechsel übernommen. Passwörter werden nicht gespeichert; kurze Zugangstokens werden weiterhin automatisch erneuert. Nach Standby und Verbindungswechsel wird die Sitzung erneut aus dem sicheren Auth-Ablauf aufgenommen. „Abmelden“ beendet nur die aktuelle App-Sitzung, nicht die anderen Apps oder Geräte.

Eine serverseitig widerrufene Sitzung, gelöschte Browserdaten oder ein kürzeres Supabase-Limit können eine frühere Neuanmeldung erfordern. Im gemeinsamen Supabase-Projekt unter Authentication → Sessions dürfen Time-box und Inactivity timeout nicht kürzer als 30 Tage sein; Single session per user muss für parallele Apps/Geräte ausgeschaltet sein. Diese Serverwerte wurden nicht geändert oder überprüft. Keine 30-Tage-Verlängerung der JWT-Laufzeit vornehmen.
