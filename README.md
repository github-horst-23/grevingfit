# GrevingFit

GrevingFit ist eine installierbare PWA für die Trainingsprofile Carsten, Kathrin, Mathilda und Mariette. Appsymbol und blau-pinkes Farbschema bleiben erhalten.

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

## Spotify Premium Player

Die Musikansicht enthält Spotify-Katalogsuche für Tracks und Playlists, einen GrevingFit-Player mit Cover, Fortschritt, Vor/Zurück und Suche sowie Spotify-Links zu den Originalinhalten. Der Player nutzt den Spotify Web Playback SDK; damit kann ein Spotify-Premiumkonto vollständige Titel im Browser wiedergeben. Spotify verlangt dafür Premium, ein Spotify-Developer-App-Client und die passende Redirect URI; der SDK streamt nicht mit einem beliebigen Embed-Link allein.

1. Im [Spotify Developer Dashboard](https://developer.spotify.com/dashboard) eine App anlegen und **Web Playback SDK** aktivieren.
2. Als Redirect URI exakt die von GrevingFit in **Settings → Spotify** angezeigte HTTPS-Adresse eintragen (inklusive App-Pfad, ohne `#`-Route). Die URI muss exakt übereinstimmen.
3. Wenn die Spotify-App im Entwicklungsmodus ist, die benötigten Spotify-Konten im Dashboard als Nutzer/Testnutzer freigeben.
4. In GrevingFit unter **Settings → Spotify** die Client ID eintragen und mit Spotify verbinden. Die Anmeldung verwendet Authorization Code mit PKCE; ein Client Secret wird nicht in die App geschrieben.

Für jedes Familienprofil wird das eigene Spotify-Refresh-Token getrennt auf dem jeweiligen Gerät gespeichert. Spotify-Wiedergabe erfordert eine Internetverbindung und einen unterstützten Browser mit verschlüsselter Medienwiedergabe.

## Lokale Sicherung

Unter **Settings → Daten auf diesem Gerät** lässt sich eine JSON-Datei mit Trainingsplan, Katalog, Verlauf und Einstellungen exportieren oder importieren. Die App führt weiterhin eine lokale Offline-Kopie.


### Übungen im Vorlagen-Training abschließen

Jede Übung kann als „Fertig“ oder „Heute auslassen“ markiert werden. Über denselben Knopf lässt sich die Auswahl zurücknehmen; eingegebene Werte bleiben erhalten. Vor dem Speichern muss für jede Übung eine Auswahl getroffen sein. Der Zwischenstand wird mit dem Training lokal gespeichert. Im Verlauf sind beide Zustände sichtbar. Ausgelassene Übungen zählen nicht zu Satzanzahl, Volumen oder Übungsfortschritt und ersetzen keine bisherigen Katalogwerte. Eine aus dem Verlauf erstellte Vorlage übernimmt nur durchgeführte Übungen. Die ursprüngliche Trainingsvorlage bleibt unverändert.
