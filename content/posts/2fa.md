---
author: ["Leon Gött"]
title: "2FA Anleitung"
date: "2025-06-11"
description: "Eine Anleitung zur Aktivierung der 2-Faktor-Authentifizierung (2FA) für deinen Account."
summary: "Es wird erklärt, wie du die 2-Faktor-Authentifizierung für deinen Account aktivierst."
tags: ["auth", "2fa", "anleitung"]
categories: ["auth", "anleitung"]
ShowToc: true
TocOpen: true
---

## 2FA Anleitung

Fast alle Dienste benötigen eine 2-Faktor-Authentifizierung (2FA), um die Sicherheit deines Accounts zu erhöhen. Diese Anleitung zeigt dir, wie du die 2FA für deinen Account aktivierst und nutzt.

## Schritt 1: Erstmaliger Login

Um die 2FA zu aktivieren, musst du dich zunächst auf [auth.goett.top](https://auth.goett.top) anmelden.

Wenn du noch keinen Account hast, musst du zuerst mich, den Administrator, kontaktieren, um einen Account zu erhalten. Schreibe mir eine E-Mail an [admin@goett.top](mailto:admin@goett.top) oder kontaktiere mich über andere Kanäle, die dir bekannt sind.

## Schritt 2: 2FA aktivieren

Nach dem Login bei [auth.goett.top](https://auth.goett.top) kannst du die 2FA aktivieren. Klicke hierfür auf den "Manage Devices" Link, der blau unter dem "Authenticated" Text steht. Damit landest du auf der Seite "Settings". Hier klickst du bei der Kategorie "One-Time Password" (OTP) auf den "Add"-Button.

### E-Mail-Bestätigung

Du wirst zunächst aufgefordert, deine E-Mail-Adresse zu bestätigen. Klicke auf "Next" und gib anschließend den Bestätigungscode ein, den du per E-Mail erhalten hast (8-stelliger Code). Dieser Code wird an die E-Mail-Adresse gesendet, die mit deinem Account verknüpft ist.

### QR-Code scannen

Nachdem du deine E-Mail-Adresse bestätigt hast, wird dir ein QR-Code angezeigt. Scanne diesen QR-Code mit einer Authentifizierungs-App, am besten direkt mit Bitwarden (Vorausgesetzt, du nutzt den privaten Vaultwarden-Server bereits) oder nutze eine andere App wie Ente Auth, Google Authenticator, usw. Diese Apps generieren Einmalpasswörter (OTP), die du für die Anmeldung benötigst.

### Einmalpasswort eingeben

Im nächsten Schritt wirst du aufgefordert, ein Einmalpasswort einzugeben, das von deiner Authentifizierungs-App generiert wurde. Dies dient dazu, sicherzustellen, dass die App korrekt eingerichtet ist und funktioniert.
Gib das Einmalpasswort, das von deiner Authentifizierungs-App generiert wurde, in das entsprechende Feld ein und klicke auf "Verify". Wenn alles korrekt ist, wird die 2FA aktiviert.

## Schritt 3: Anmeldung mit 2FA

Nach der Aktivierung der 2FA musst du bei jedem Login zusätzlich zu deinem Passwort ein Einmalpasswort eingeben. Dieses Einmalpasswort wird von deiner Authentifizierungs-App generiert und ist zeitlich begrenzt gültig.

## Schritt 5: Fertig

Jetzt ist die 2-Faktor-Authentifizierung für deinen Account aktiviert. Du kannst dich nun sicherer anmelden und deine Daten besser schützen.

## Fehlerbehebung

Wenn du Probleme bei der Aktivierung oder Nutzung der 2FA hast, überprüfe bitte Folgendes:

- Stelle sicher, dass sowohl die Uhrzeit als auch das Datum auf beiden Geräten (dein Computer und dein Smartphone) korrekt eingestellt sind. Die Authentifizierungs-Apps benötigen eine genaue Zeit, um die Einmalpasswörter korrekt zu generieren.
