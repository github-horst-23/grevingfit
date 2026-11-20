# Dorfflohmarkt Dudenhofen

Installierbare Web-App für den Dorfflohmarkt in 67373 Dudenhofen. Die Oberfläche läuft auf GitHub Pages. Supabase verwaltet Veranstaltungseinstellungen, Anmeldungen, veröffentlichte Stände, Nachbefragung und Kartenpositionen.

## Lokal starten

Im Projektordner ausführen:

```sh
python3 -m http.server 8000
```

Anschließend [localhost:8000](http://localhost:8000/) öffnen. Für Datenbankzugriffe und externe Kartendienste sind Internet und eine konfigurierte Supabase-Anbindung erforderlich.

## Supabase einrichten

### Neues Projekt

1. `supabase-setup.sql` vollständig im Supabase SQL Editor ausführen. Es enthält die aktuelle Grundeinrichtung.
2. Unter **Authentication → Users** einen Admin-Benutzer anlegen.
3. `supabase-admin.sql` nach `supabase-admin.local.sql` kopieren, die Auth-UUID eintragen und diese lokale Datei im SQL Editor ausführen.
4. In `supabase-config.js` die öffentliche Projekt-URL und den Publishable Key hinterlegen.
5. Für die HERE-Geocodierung `HERE_API_KEY` als Edge-Function-Secret setzen und die Funktion aus `supabase/functions/geocode-stands/` bereitstellen. Details: [GEOCODING.md](GEOCODING.md).
6. In Supabase Auth die veröffentlichte HTTPS-Adresse als **Site URL** hinterlegen.

### Bestehendes Projekt aktualisieren

Nur noch fehlende Migrationen in dieser Reihenfolge ausführen:

| Datei | Ergänzung |
| --- | --- |
| `supabase-operations-v93.sql` | Nachbefragung, Papierkorb und Aktionsprotokoll |
| `supabase-operations-v94.sql` | Erweiterte Nachbefragung und Adminauswertung |
| `supabase-operations-v96.sql` | Geschützte Löschung der Umfrageantworten |

`supabase-geocoding.sql` aktualisiert die Geocodierung separat. Bei älteren Einzelmigrationen gilt: zuerst die Anmeldungseinstellung, danach die Nachzügler-Tokens. Die ältere Einstellungsmigration kann sonst die neuere Token-Prüfung überschreiben.

**Früheres Testfeedback entfernen:** Falls es eingerichtet wurde, entfernt `supabase-remove-test-feedback-v102.sql` die zugehörigen Funktionen, die Tabelle und den Teststatus. Dabei werden vorhandene Testfeedback-Nachrichten und Screenshots endgültig gelöscht. Die Nachbefragung bleibt erhalten.

## Paket erstellen und veröffentlichen

```sh
python3 tools/package_pwa.py
```

Der Befehl erstellt `Dorfflohmarkt-PWA-GitHub.zip` und übernimmt das vorhandene Benutzerhandbuch-PDF. Das Paket enthält ausschließlich die Dateien aus der festgelegten öffentlichen Positivliste.

Das ZIP entpacken und seine Inhalte in den Stamm des GitHub-Pages-Repositories übernehmen. Die ausführliche Anleitung steht in [GITHUB-PAGES-ANLEITUNG.md](GITHUB-PAGES-ANLEITUNG.md).

## Dateien und Dokumentation

| Bestandteil | Zweck |
| --- | --- |
| `index.html`, `style.css`, `app.js` | Oberfläche, Navigation und App-Logik |
| `routing-client.js` | Fußrouten zu Favoriten |
| `geocoding-client.js` | Browserseitige Kartenpositionierung |
| `supabase/functions/geocode-stands/` | Serverseitige HERE-Geocodierung |
| `supabase-setup.sql`, `supabase-admin.sql` | Datenbank-Grundeinrichtung und Adminvorlage |
| [BENUTZERHANDBUCH.md](BENUTZERHANDBUCH.md) | Quelle der Bedienungsanleitung |
| [APP-DOKUMENTATION.md](APP-DOKUMENTATION.md) | Bedienung, Architektur und Betrieb |
| [TESTBERICHT.md](TESTBERICHT.md) | Prüfergebnisse und offene Grenzen |
| `tests/`, `tools/` | Automatisierte Prüfungen, PDF-Erzeugung und Paketierung |

PDFs werden nur nach ausdrücklicher Zustimmung aktualisiert. Die Dokumentationsquellen werden bei Änderungen gepflegt.

## Prüfungen

```sh
node --test tests/*.test.mjs
```

Dieser Befehl führt die vorhandenen automatisierten Prüfungen aus. Der dokumentierte Prüfstand und die Grenzen der Live-Prüfung stehen im Testbericht.

## Datenschutz und Zugangsdaten

- Namen und E-Mail-Adressen bleiben im geschützten Adminbereich.
- Öffentlich sind nur freigegebene Standangaben und Kartenpositionen sichtbar.
- Adminfunktionen prüfen Anmeldung und Adminzuordnung serverseitig.
- Nachzügler-Tokens und Abmeldephrasen werden nur gehasht gespeichert.
- HERE erhält veröffentlichte Standadressen, keine Kontaktdaten.
- `supabase-config.js` darf nur öffentliche Verbindungseinstellungen enthalten. `service_role`- und HERE-Schlüssel bleiben serverseitig.
- Private Adminzuordnungen, vertrauliche Exporte und Zugangsdaten gehören nicht ins öffentliche Repository oder ZIP.
