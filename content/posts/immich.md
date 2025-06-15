---
author: ["Leon Gött"]
title: "Immich Anleitung"
date: "2025-06-11"
description: "Eine kleine Anleitung, wie man sich bei Immich anmeldet und Bilder hochlädt."
summary: "Es wird erklärt, wie jeder sich bei Immich anmeldet und den Upload für Bilder nutzt."
tags: ["immich", "anleitung", "bilder"]
categories: ["immich", "anleitung"]
series: ["Immich Anleitung"]
ShowToc: true
TocOpen: true
---

Immich ist eine Open-Source-Lösung für die Verwaltung und Speicherung von Fotos und Videos. In dieser Anleitung wird erklärt, wie du dich bei Immich anmeldest und den automatischen Upload für Bilder nutzt.

## Installation und Login (Immich App)

### Schritt 1: Account verfollständigen

Falls du deinen Account noch nicht vervollständigt hast, gehe auf [auth.goett.top](https://auth.goett.top) um die 2-Faktor-Authentifizierung zu aktivieren und deinen Account zu vervollständigen. Dies ist wichtig, um die Sicherheit deines Kontos zu gewährleisten.

Siehe auch die Anleitung zur [2-Faktor-Authentifizierung](https://goett.top/posts/2fa/).

### Schritt 2: Immich App herunterladen

Lade die Immich App aus dem [Google Play Store](https://play.google.com/store/apps/details?id=app.alextran.immich&hl=de) oder dem [Apple App Store](https://apps.apple.com/us/app/immich/id1613945652) herunter, je nach deinem Gerät.

### Schritt 3: Anmeldung bei Immich

Um dich bei Immich anzumelden, folge diesen Schritten:

1. Öffne die Immich App auf deinem Gerät.
2. Gib die URL `https://photos.goett.top` in das entsprechende Feld für die Serveradresse ein.
3. Nutze den Button "Login with Authelia" um dich mit deinem Hauptaccount anzumelden. Du wirst zu [auth.goett.top](https://auth.goett.top) weitergeleitet, wo du deine Anmeldedaten eingeben kannst.
4. Nach erfolgreicher Anmeldung und Bestätigung der Zugriffsrechte wirst du zurück zur Immich App geleitet und bist nun angemeldet.

### Spracheinstellungen

Falls die App nicht auf Deutsch eingestellt ist, kannst du die Sprache in den Einstellungen der App ändern:

1. Gehe zu den Einstellungen der Immich App. Klicke dazu oben rechts auf dein Profilbild und wähle "Settings".
2. Klicke auf "Language" und wähle "Deutsch" aus der Liste der verfügbaren Sprachen.
3. Klicke auf "Save" um die Änderungen zu übernehmen.

## Bilder hochladen

Gehe zunächst zurück zum Startbildschirm der Immich App (Fotos Tab). Hier kannst du deine Bilder und Videos sehen, die du hochgeladen hast.
Um zur Sicherung zu gelangen, klicke oben auf die Wolke.

### Schritt 1: Auswählen der gesicherten Alben

1. Klicke im ersten Sektor auf "Auswählen" um die Alben auszuwählen, die du sichern möchtest.
2. Wähle die Alben aus, die du sichern möchtest. Du kannst mehrere Alben auswählen, indem du sie antippst.
3. Du kannst Alben auch abwählen, indem du sie doppelt antippst.
4. Am besten wählst du nicht "Recent" aus, da dieses Album alle Bilder enthält, die auf deinem Gerät gespeichert sind. Meistens reicht der DCIM und der Pictures Ordner aus.
5. Wenn du mit der Auswahl fertig bist, klicke oben auf den Zurück-Pfeil, um zur vorherigen Seite zurückzukehren.

### Schritt 2: Sicherung aktivieren

Klicke nun oben rechts auf das Zahnrad-Symbol, um die Einstellungen für die Sicherung zu öffnen. Hier kannst du verschiedene Optionen für die Sicherung deiner Bilder festlegen.

1. Aktiviere die Option "Sicherung im Vordergrund" um die Sicherung automatisch beim nutzen der App zu starten.
2. Aktiviere die Option "Sicherung im Hintergrund" um die Sicherung auch dann durchzuführen, wenn die App im Hintergrund läuft.
3. Dazu kannst du auch die Option "Nur im WLAN sichern" aktivieren, um sicherzustellen, dass die Sicherung nur über WLAN durchgeführt wird und nicht über mobile Daten. Zudem geht auch "Nur während des Ladens" um die Sicherung nur dann durchzuführen, wenn dein Gerät aufgeladen wird.
4. Du musst nun der App erlauben, im Hintergrund zu laufen. Gehe dazu in die Einstellungen deines Geräts und suche nach "Apps" oder "Anwendungen". Wähle die Immich App aus und aktiviere die Option "Hintergrundaktivität zulassen" oder ähnliches, je nach deinem Gerät. Meist ist diese Option bei den AppInformationen der Immich App unter "Akku" zu finden.
5. Falls du die Option nicht findest, gehe auf [dontkillmyapp](https://dontkillmyapp.com/) und wähle dein Gerät aus, um eine Anleitung zu erhalten, wie du die Hintergrundaktivität für die Immich App aktivieren kannst.
6. Klicke auf "Sicherung starten" um die Sicherung zu starten. Die App wird nun beginnen, die ausgewählten Alben zu sichern.

Die Sicherung sollte nun automatisch im Hintergrund laufen, wenn du die App nutzt oder dein Gerät aufgeladen wird. Du kannst den Fortschritt der Sicherung in der App verfolgen.

## Personen-Erkennung

Immich bietet eine Funktion zur Personen-Erkennung, die es dir ermöglicht, Bilder von bestimmten Personen zu finden und zu organisieren.

Du findest die erkannten Personen im Tab "Bibliothek" unter "Personen". Hier kannst du die erkannten Personen sehen und verwalten.

Am besten benennst du die Personen, damit du sie später leichter finden kannst. Klicke dazu auf das Profilbild der Person und wähle "Name hinzufügen" aus. Gib den Namen der Person ein und klicke auf "Speichern".

Das zusammenführen von Personen ist nur über die Web-App möglich. Gehe dazu auf [photos.goett.top](https://photos.goett.top) und melde dich an. Klicke links auf "Erkunden" und dann bei Personen auf "Alles anzeigen". Hier kannst du die Personen sehen, die Immich erkannt hat. Gehe mit der Maus über die Person und klicke auf die drei Punkte, um das Menü zu öffnen. Wähle "Personen zusammenführen" aus, um die Person mit einer anderen Person zusammenzuführen. Du kannst auch mehrere Personen auswählen und sie zusammenführen.

## Album erstellen, freigeben und teilen

Du kannst Alben in Immich erstellen, um deine Bilder zu organisieren und sie mit anderen zu teilen. Hier ist eine Anleitung, wie du Alben erstellst, sie intern freigibst und wie du sie anderen zur Verfügung stellst (Sowohl für Download als auch zum Hochladen von Bildern).

### Alben erstellen

Um ein neues Album zu erstellen, gehe zum Tab "Alben" und klicke auf das "+" Symbol oben. Gib dem Album einen Titel und wähle die Bilder aus, die du in das Album aufnehmen möchtest. Klicke auf "Erstellen" um das Album zu erstellen.

### Alben intern freigeben

Um ein Album freizugeben, öffne das Album und klicke auf "Nutzer hinzufügen". Hier kannst du andere Immich-Nutzer hinzufügen, die Zugriff auf das Album haben sollen.

### Alben teilen

Um ein Album zu teilen, öffne das Album und klicke oben rechts auf die drei Punkte. Wähle "Link teilen" aus, um einen Link zum Album zu erstellen.

Im neuen Fenster kannst du dem Link eine Beschreibung geben und optional ein Passwort festlegen, um den Zugriff auf das Album zu schützen.

Hier kannst du auch festlegen, ob öffentliche Nutzer (ohne Immich Account)

- Metadaten wie Kameradaten und Standortinformationen sehen können
- Bilder herunterladen können
- Bilder hochladen können

Zudem kann ein Verfallsdatum für den Link festgelegt werden, nach dem der Link nicht mehr gültig ist.
Klicke auf "Link erstellen" um den Link zu generieren. Du kannst den Link dann kopieren und teilen.

## Probleme und Lösungen

Falls du Probleme mit der Immich App hast, hier sind einige häufige Probleme und deren Lösungen:

- Server ist nicht erreichbar: Stelle sicher, dass du die richtige URL eingegeben hast und dass der Server online ist. Du kannst auch versuchen, die App neu zu starten oder dein Gerät neu zu starten.
- Bilder werden nicht hochgeladen: Überprüfe, ob du die richtigen Alben ausgewählt hast und ob die Sicherung aktiviert ist. Stelle sicher, dass du eine Internetverbindung hast und dass die App im Hintergrund laufen darf.
- Bei anderen Problemen kannst du die Logs in der App überprüfen. Gehe dazu oben rechts auf dein Profilbild und wähle "Logs". Hier kannst du die Logs der App einsehen und nach Fehlern suchen. Sollten hier Fehler aufgelistet sein, könnten diese hilfreich sein, um das Problem zu lösen.

## Web-App

Viele Funktionen von Immich sind auch über oder sogar nur über die Web-App verfügbar. Du kannst die Web-App unter [photos.goett.top](https://photos.goett.top) erreichen. Melde dich mit deinem Account an, um auf deine Bilder und Alben zuzugreifen.

## Weitere Funktionen

Immich bietet viele weitere Funktionen, die du nutzen kannst, um deine Bilder zu organisieren und zu verwalten. Hier sind einige der wichtigsten Funktionen:

- **Suchen**: Du kannst nach Bildern suchen, indem du einfach nach einem Begriff suchst, z.B. nach "Fahrrad" oder "Urlaub". Immich wird dir alle Bilder anzeigen, die zu diesem Begriff passen. Dabei funktioniert meist die Suche auf Englisch am besten. Zudem kannst du nach Personen, Kamera-Modell, Ort und Datum filtern.
- **Favoriten**: Du kannst Bilder als Favoriten markieren, indem du auf das Herz-Symbol tippst. Diese Bilder werden dann im Tab "Favoriten" angezeigt.
- **Gesperrter Ordner**: Du kannst Bilder in einem gesperrten Ordner speichern, um sie vor anderen Nutzern zu schützen. Gehe dazu in die Einstellungen der App und aktiviere den gesperrten Ordner. Du musst dann ein Pin festlegen, um auf den Ordner zuzugreifen. Bilder in diesem Ordner sind nur für dich sichtbar und können nicht von anderen Nutzern gesehen werden.
- **Archiv**: Du kannst Bilder in ein Archiv verschieben, um sie aus der normalen Ansicht zu entfernen. Gehe dazu in die Einstellungen der App und aktiviere das Archiv. Du kannst dann Bilder in das Archiv verschieben, indem du sie auswählst und auf "Archivieren" tippst. Bilder im Archiv sind weiterhin verfügbar, aber nicht mehr in der normalen Ansicht sichtbar.
- **Duplikate**: Immich bietet eine Funktion zum Finden von Duplikaten.
- **Kartenansicht**: Du kannst die Bilder in einer Kartenansicht anzeigen lassen, um zu sehen, wo sie aufgenommen wurden. Gehe dazu auf den Tab "Bibliothek" und wähle Orte aus (In der Web-App unter "Karte"). Hier kannst du die Bilder auf einer Karte sehen und nach Orten filtern.
- **Einstellungen**: Du kannst die Einstellungen der App anpassen, um die App nach deinen Wünschen zu konfigurieren. Gehe dazu oben rechts auf dein Profilbild und wähle "Settings". Hier kannst du verschiedene Optionen anpassen, z.B. die Sprache, die Benachrichtigungen und die Sicherungseinstellungen.
