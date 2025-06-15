---
author: ["Leon Gött"]
title: "Vaultwarden einrichten"
date: "2025-06-11"
description: "So richtest du Vaultwarden ein, um deine Passwörter sicher zu verwalten."
summary: "Hier erfährst du, wie du Vaultwarden einrichtest, um deine Passwörter sicher zu verwalten."
tags: ["auth", "passwort", "anleitung"]
categories: ["auth", "anleitung"]
ShowToc: true
TocOpen: true
---

## Vaultwarden einrichten

Vaultwarden ist eine Open-Source-Passwortverwaltung, die auf Bitwarden basiert. Sie ermöglicht es dir, deine Passwörter sicher zu speichern und zu verwalten. Hier erfährst du, wie du Vaultwarden einrichtest und nutzt.

### Schritt 1: Bitwarden installieren

Um Vaultwarden zu nutzen, musst du zunächst Bitwarden installieren. Du kannst Bitwarden auf verschiedenen Plattformen installieren, einschließlich Windows, macOS, Linux, Android und iOS. Besuche die [offizielle Bitwarden-Website](https://bitwarden.com/download/) und lade die passende Version für dein Betriebssystem herunter. Es gibt auch Browsererweiterungen für Chrome, Firefox, Edge und andere Browser.

### Schritt 2: Vaultwarden-Server einrichten

Um Vaultwarden zu nutzen, musst du zuerst einen Account auf unserem Vaultwarden-Server erstellen. Gehe dazu auf [vault.goett.top](https://vault.goett.top) und klicke auf "Konto erstellen". Fülle das Registrierungsformular aus und klicke auf "Fortsetzen".
Erstelle ein neues sicheres Master-Passwort, das du dir gut merken kannst. Achte darauf, dass es stark genug ist, um deine Daten zu schützen.
Lege auch ein Master-Passwort Hinweis fest, der dir hilft, dein Passwort wiederzufinden, falls du es vergisst. Dieser Hinweis wird nur angezeigt, wenn du dein Passwort vergessen hast und es zurücksetzen möchtest. Der Hinweis sollte jedoch nicht zu offensichtlich sein, um die Sicherheit deines Kontos zu gewährleisten.

### Schritt 3: Vaultwarden nutzen

Nachdem du deinen Account erstellt hast, kannst du Vaultwarden nutzen, um deine Passwörter zu speichern und zu verwalten.

Um dich in einer der Bitwarden-Apps oder Browsererweiterungen anzumelden, wähle zuerst unseren Vaultwarden-Server aus. Dazu musst du unten bei der Anmeldung auf "Server auswählen" oder "Zugriff auf: " klicken und dann "Benutzerdefinierter Server" bzw "Selbst gehostet" auswählen. Gib die URL `https://vault.goett.top` ein und klicke auf "Speichern". Jetzt kannst du dich mit deiner E-Mail-Adresse und dem Master-Passwort anmelden, das du bei der Registrierung festgelegt hast. Ohne diesen Schritt kannst du dich nicht anmelden, da die Apps standardmäßig auf den offiziellen Bitwarden-Server zugreifen.

### Schritt 4: Passwörter hinzufügen

Um Passwörter zu Vaultwarden hinzuzufügen, kannst du nun alle deine Browser-Passwörter importieren oder manuell neue Passwörter hinzufügen. In der Web-App kannst du auf "Neues Element" klicken und dann den Typ des Elements auswählen, das du hinzufügen möchtest (z.B. Login, Notiz, Kreditkarte). Fülle die erforderlichen Felder aus und klicke auf "Speichern".

Um von einem anderen Bitwarden-Server zu migrieren, kannst du auch die Importfunktion nutzen. Gehe dazu in der Web-App auf "Werkzeuge" und wähle "Daten Importieren". Wähle das Format deines alten Passwortmanagers aus und lade die Datei hoch. Vaultwarden wird die Daten importieren und du kannst sie dann in deiner Vault verwalten.

Stelle sicher dass du unverschlüsselte Exporte von anderen Passwortmanagern nach dem Import löschst, um deine Daten zu schützen. Vaultwarden speichert deine Passwörter verschlüsselt, sodass sie nur für dich zugänglich sind.

## Funktionen von Vaultwarden

Vaultwarden bietet viele nützliche Zusatzfunktionen:

- **Zwei-Faktor-Authentifizierung (2FA)**: Du kannst die Zwei-Faktor-Authentifizierung aktivieren, um dein Konto zusätzlich abzusichern. Dies kann über die Einstellungen in der Web-App erfolgen.
- **Passwortgenerator**: Vaultwarden verfügt über einen integrierten Passwortgenerator, der dir hilft, starke Passwörter zu erstellen. Du kannst die Länge und die verwendeten Zeichen anpassen.
- **Sichere Notizen**: Du kannst sichere Notizen erstellen, um wichtige Informationen zu speichern, die nicht unbedingt Passwörter sind.
- **Kreditkarten und Identitäten**: Vaultwarden ermöglicht es dir, Kreditkarteninformationen und Identitäten zu speichern, um sie bei Online-Einkäufen schnell zur Hand zu haben.
- **Sends**: Du kannst Dateien und Text über die "Send" Funktion sicher teilen. Dies ist nützlich, um sensible Informationen mit anderen zu teilen, ohne sie per E-Mail oder anderen unsicheren Kanälen zu versenden. Dabei kannst du die Sichtbarkeit und das Ablaufdatum der Sendings festlegen.
- **Organisationen**: Du kannst Organisationen erstellen, um Passwörter und andere Daten mit anderen Benutzern zu teilen. Dies ist besonders nützlich für Teams oder Familien, die gemeinsame Konten verwalten möchten. Hierfür gibt es bereits eine Familienorganisation, in der du deine Passwörter mit anderen Familienmitgliedern teilen kannst. Innerhalb der Organisation kannst du auch Sammlungen erstellen, um Passwörter zu gruppieren und den Zugriff zu steuern.
- **Berichte**: Vaultwarden bietet eine Ansicht, die dir hilft, schwache Passwörter zu identifizieren und zu ändern. Dabei wird auch angezeigt, ob deine Passwörter in Datenlecks gefunden wurden. Du kannst diese Berichte nutzen, um die Sicherheit deiner Passwörter zu verbessern.
