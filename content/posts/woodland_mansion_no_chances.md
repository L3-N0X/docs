---
author: ["L3N0X"]
title: "Woodland Mansion Generierung (Ohne Wahrscheinlichkeiten)"
date: "2026-04-09"
description: "Detaillierte Analyse der Raum-Generierung in Woodland Mansions (Ohne Wahrscheinlichkeiten)"
summary: "Dieser Artikel bietet einen detaillierten Einblick in die Raum-Generierung von Woodland Mansions in Minecraft, ohne die Wahrscheinlichkeiten für das Auftreten verschiedener Raumtypen."
tags: ["woodland_mansion", "minecraft"]
categories: ["minecraft"]
ShowToc: true
TocOpen: false
math: true
---

Dieser Artikel erklärt die Generierung von Woodland Mansions in Minecraft. Dabei wird zuerst der Algorithmus zur Generierung der Hallways (Gänge) beschrieben und danach werden ([einzelne Räume](#liste-der-raumtypen-und-deren-platzierung)) genauer analysiert.

> [!MEMO] Zusammenfassung
> Die Generierung einer Woodland Mansion wird primär durch einen „Snake-Algorithmus“ bestimmt, der zuerst die Hallways (Gänge) festlegt. Da alle Räume erst nachträglich in die verbleibenden Lücken gesetzt werden und eine Tür zum Gang benötigen, entstehen Secret Rooms immer dann, wenn ein Raum keinen Kontakt zu einem Hallway hat. Bestimmte Hallway-Muster bedingen dabei die Entstehung dieser geheimen Räume massiv. Im 3. Stock treten Secret Rooms deutlich häufiger auf, da der Hallway dort mit nur einem Startpunkt und maximal 8 Abschnitten wesentlich kürzer ist als in den unteren Etagen, wodurch viel mehr „isolierte“ Zellen ohne Gang-Anschluss entstehen können.

## Generierung einer Woodland Mansion

### Animation der Generierung

Hier ist eine Animation, die die Generierung der Hallways und Räume in einer Woodland Mansion zeigt (2 Beispiele, alle Raum-Typen):

{{< figure src="/woodland_mansion/generation_animation.webp" >}}

> [!Abstract] Legende:
>
> - `GRAU`: Gänge bzw. Hallways
> - `GELB`: Eingang der Mansion / Treppen
> - `ORANGE`: Markierung für den Startpunkt
> - `BLAU`: 1x1 Räume
> - `GRÜN`: 1x2 Räume
> - `LILA`: 2x2 Räume
> - `HELLBLAU`: 1x1 Secret-Räume
> - `HELLGRÜN`: 1x2 Secret-Räume
> - `PINK`: 2x2 Secret-Raum (Lava Room)

### Algorithmus zur Generierung der Hallways

Die Generierung der **Hallways** in Woodland Mansions erfolgt durch einen *Snake-Algorithmus*, der vom Eingang der Mansion aus startet. Der Algorithmus geht dann jeweils einen Schritt weiter in eine zufällige Richtung. Dabei gibt es folgende **Regeln**:

1. Es gibt vier mögliche **Richtungen**: Norden, Osten, Süden und Westen.
2. $180^\circ$-Grad-Wendungen sind **nicht** erlaubt
3. Der Algorithmus darf die **fixen Grenzen** der Mansion **nicht** überschreiten ($7x9$ Zellen, im 3. Stockwerk evtl. weniger)
4. Beim Geradeaus laufen dürfen sich Wege nicht direkt verbinden (Schleifen können nur generieren, wenn sich 2 Wege unterschiedlicher Richtung zufällig berühren)
5. Es gibt eine künstliche $50\\%$ Chance, dass der Algorithmus nicht nach Osten gehen darf (Zurück Richtung Eingang), dadurch gehen Gänge tendenziell eher nach **Westen**.
6. Ein Gang kann maximal 12 bzw. 6 Abschnitte lang sein.
7. Es werden **4 Startpunkte** genutzt (Norden + Süden, Nord-West + Süd-West):

![Platzierung der 4 Startpunkte](/woodland_mansion/initial_snake_placement.png)

> [!Tip] Anmerkung
> Die Gänge sind in Stockwerk 1 und 2 **identisch**, im 3. Stockwerk werden die Gänge **nochmal neu** generiert mit nur einem **einzigen Startpunkt**.
>
> Die Länge für diesen Gang ist auf **8 Abschnitte** begrenzt und Zellen, die bereits in den unteren Stockwerken keinen Raum haben (Komplett leer, generieren keinen Raum, sind leere Ecken der Woodland Mansion) werden zuvor blockiert, sodass dort keine Gänge/Räume generieren können. Da der Hallway im 3. Stockwerk viel kleiner ist (maximal 8 statt 36 Abschnitte), fällt die Grundfläche für reguläre Räume oft deutlich geringer aus.
>
> Die Größe des 3. Stockwerks wird **lediglich** durch die **Generierung der Hallways** bestimmt!
>
> Dies erhöht wiederum die Wahrscheinlichkeit für Secret-Räume: Es entstehen mehr leere Zellen, die nicht an einen Gang grenzen ([mehr dazu unter Details zu den Secret-Räumen](#details-zu-den-secret-räumen)).

### Generierung der Räume

Bei der Generierung der Hallways werden Positionen gespeichert, an denen Räume generiert werden können. Diese Positionen werden später durch verschieden Große Räume belegt, bis alle Zellen belegt sind.

> [!Task]Schritte zur Generierung pro Stockwerk:
>
> 1. Alle Raum-Koordinaten werden in einer Liste gespeichert.
> 2. Die Liste wird **zufällig gemischt** (Pro Stockwerk wird neu gemischt)
> 3. Danach wird diese Liste **iterativ** abgearbeitet, um Räume zu generieren.
> 4. Zuerst wird geschaut, ob ein **2x2 Raum** generiert werden kann, erst danach **1x2 Räume**. **1x1 Räume** werden nur geplaced, wenn kein größerer Raum an dieser Stelle generiert werden kann. (Das geschieht pro Stockwerk, die Aufteilung der Räume auf den Stockwerken ist also nicht die gleiche)
> 5. Anschließend wird eine der Raum-Zellen zufällig ausgewählt, und geprüft, ob diese eine Türe sein kann. Wenn diese Zelle jedoch nicht neben einem Gang liegt, wird eine andere Zelle gewählt und erneut getestet, bis eine Zelle gefunden wird, die neben einem Gang liegt und dadurch zur Türe wird.
> 6. Da der **Hallway-Algorithmus** nicht garantiert, dass alle Räume neben einem Gang liegen, gibt es die Möglichkeit, dass manche Räume keine Tür haben. Diese Räume sind dann die sogenannten **"Secret-Räume"**. (Das genaue Vorgehen wird im Abschnitt [Details zu den Secret-Räumen](#details-zu-den-secret-räumen) erklärt.)
> 7. Bei den restlichen **1x2 Räumen** wird anschließend noch bestimmt, **welche Form der Eingang hat**, es gibt Räume mit einem Eingang auf der **kurzen Seite** (`b` & `d` Raum-Varianten) und Räume mit einem Eingang auf der **langen Seite** (`a` & `c` Raum-Varianten). Die `a` & `b` Raum-Varianten können **nur im Erdgeschoss** generiert werden, die `c` & `d` Raum-Varianten **im 2. und 3. Stockwerk** (ausgenommen `stairs`-Räume, diese können nur im 2. Stockwerk generiert werden).
> 8. Bei den 1x1 und 2x2 Räumen gibt es ebenfalls `a` & `b` Raum-Varianten, diese unterscheiden sich jedoch **nicht** bei der Türen-Platzierung. Die `a` Varianten können **nur im Erdgeschoss** generiert werden, die `b` Varianten **im 2. und 3. Stockwerk**.
> 9. Nur im 2. Stockwerk, Treppen: Es wird nun nach einem Raum gesucht, der **1x2 groß ist und eine Türe** hat. Es kann entweder ein `curved` (`c` Raum-Variante) oder `straight` (`d` Raum-Variante) Staircase (Treppe) generiert werden. Diese Treppe führt dann in das 3. Stockwerk. Wird kein passender Raum für eine Treppe gefunden, tritt ein **seltener Fall** ein: Die Woodland Mansion wird **komplett ohne 3. Stockwerk** generiert.
> 10. Nachdem alle Räume bestimmt wurden, werden diese festgelegt für die Generierung und die anschließende Platzierung der Struktur-Teile und Räume.

Es gibt Woodland Mansions, die **weniger Zellen in der Grundfläche** haben als andere. Das liegt nur daran, dass manche **Hallway-Generierungen** zu einer kleineren Grundfläche führen als andere, da die Hallways die Grundfläche für die Räume bestimmen.

## Liste der Raumtypen und deren Platzierung

Die folgende Tabelle zeigt **alle Raumtypen**, die in Woodland Mansions generiert werden können. Zudem sind die **Stockwerke** angegeben, in denen die Räume generiert werden können sowie die Struktur-Namen, die in den Minecraft-Struktur-Dateien verwendet werden.

### 1x1 Räume

| Struktur + Link | Raum-Name | Stockwerk |
| --- | --- | --- |
| [`1x1_a1`](#1x1_a1---flower-room) | Flower Room | 1. Stock |
| [`1x1_a2`](#1x1_a2---pumpkin-ring-room) | Pumpkin Room | 1. Stock |
| [`1x1_a3`](#1x1_a3---office) | Office | 1. Stock |
| [`1x1_a4`](#1x1_a4---checkerboard-room) | Checkerboard Room | 1. Stock |
| [`1x1_a5`](#1x1_a5---white-tulip-sanctuary) | White Tulip Sanctuary | 1. Stock |
| --- | --- | --- |
| [`1x1_b1`](#1x1_b1---birch-arch-room) | Birch Arch Room | 2. und 3. Stock |
| [`1x1_b2`](#1x1_b2---small-dining-room) | Small Dining Room | 2. und 3. Stock |
| [`1x1_b3`](#1x1_b3---single-bed-bedroom) | Single Bed Bedroom | 2. und 3. Stock |
| [`1x1_b4`](#1x1_b4---small-library) | Small Library | 2. und 3. Stock |
| [`1x1_b5`](#1x1_b5---allium-room) | Allium Room | 2. und 3. Stock |

### 1x2 Räume

| Struktur + Link | Raum-Name | Stockwerk |
| --- | --- | --- |
| [`1x2_a1`](#1x2_a1---gray-banner-room) | Gray Banner Room | 1. Stock |
| [`1x2_a2`](#1x2_a2---wheat-farm) | Wheat Farm | 1. Stock |
| [`1x2_a3`](#1x2_a3---forge-room) | Forge Room (Anvil Room) | 1. Stock |
| [`1x2_a4`](#1x2_a4---sapling-farm) | Sapling Farm | 1. Stock |
| [`1x2_a5`](#1x2_a5---wool-room) | Wool Room | 1. Stock |
| [`1x2_a6`](#1x2_a6---tree-chopping-room) | Tree-Chopping Room | 1. Stock |
| [`1x2_a7`](#1x2_a7---mushroom-farm) | Mushroom Farm | 1. Stock |
| [`1x2_a8`](#1x2_a8---dual-staged-farm) | Dual-staged Farm | 1. Stock |
| [`1x2_a9`](#1x2_a9---small-storage-room) | Small Storage Room | 1. Stock |
| --- | --- | --- |
| [`1x2_b1`](#1x2_b1---redstone-jail) | Redstone Jail | 1. Stock |
| [`1x2_b2`](#1x2_b2---small-jail) | Small Jail | 1. Stock |
| [`1x2_b3`](#1x2_b3---wood-arch-hallway) | Wood Arch Hallway | 1. Stock |
| [`1x2_b4`](#1x2_b4---winding-stairway-room) | Winding Stairway Room | 1. Stock |
| [`1x2_b5`](#1x2_b5---illager-head-room) | Illager Head Room | 1. Stock |
| --- | --- | --- |
| [`1x2_c1`](#1x2_c1---medium-dining-room) | Medium Dining Room | 2. und 3. Stock |
| [`1x2_c2`](#1x2_c2---double-bed-bedroom) | Double Bed Bedroom | 2. und 3. Stock |
| [`1x2_c3`](#1x2_c3---triple-bed-bedroom) | Triple Bed Bedroom | 2. und 3. Stock |
| [`1x2_c4`](#1x2_c4---medium-library) | Medium Library | 2. und 3. Stock |
| --- | --- | --- |
| [`1x2_c_stairs`](#1x2_c_stairs---curved-staircase) | Curved Staircase | 2. Stock |
| --- | --- | --- |
| [`1x2_d1`](#1x2_d1---master-bedroom) | Master Bedroom | 2. und 3. Stock |
| [`1x2_d2`](#1x2_d2---bedroom-with-loft) | Bedroom with Loft | 2. und 3. Stock |
| [`1x2_d3`](#1x2_d3---ritual-room) | Ritual Room | 2. und 3. Stock |
| [`1x2_d4`](#1x2_d4---cat-statue-room) | Cat Statue Room | 2. und 3. Stock |
| [`1x2_d5`](#1x2_d5---chicken-statue-room) | Chicken Statue Room | 2. und 3. Stock |
| --- | --- | --- |
| [`1x2_d_stairs`](#1x2_d_stairs---straight-staircase) | Straight Staircase | 2. Stock |

### 2x2 Räume

| Struktur + Link | Raum-Name | Stockwerk |
| --- | --- | --- |
| [`2x2_a1`](#2x2_a1---large-jail) | Large Jail | 1. Stock |
| [`2x2_a2`](#2x2_a2---large-storage-room) | Large Storage Room | 1. Stock |
| [`2x2_a3`](#2x2_a3---illager-statue-room) | Illager Statue Room | 1. Stock |
| [`2x2_a4`](#2x2_a4---nature-room) | Nature Room | 1. Stock |
| --- | --- | --- |
| [`2x2_b1`](#2x2_b1---large-dining-room) | Large Dining Room | 2. und 3. Stock |
| [`2x2_b2`](#2x2_b2---conference-room) | Conference Room | 2. und 3. Stock |
| [`2x2_b3`](#2x2_b3---large-library) | Large Library | 2. und 3. Stock |
| [`2x2_b4`](#2x2_b4---map-room) | Map Room | 2. und 3. Stock |
| [`2x2_b5`](#2x2_b5---arena-room) | Arena Room | 2. und 3. Stock |

### Secret-Räume

| Struktur + Link | Raum-Name | Stockwerk |
| --- | --- | --- |
| [`1x1_as1`](#1x1_as1---x-room-secret-room) | X Room | 1., 2. und 3. Stock |
| [`1x1_as2`](#1x1_as2---spider-room-secret-room) | Spider Room | 1., 2. und 3. Stock |
| [`1x1_as3`](#1x1_as3---obsidian-room-secret-room) | Obsidian Room | 1., 2. und 3. Stock |
| [`1x1_as4`](#1x1_as4---birch-pillar-room-secret-room) | Birch Pillar Room | 1., 2. und 3. Stock |
| --- | --- | --- |
| [`1x2_s1`](#1x2_s1---clean-chest-room-secret-room) | Clean Chest Room | 1. Stock |
| [`1x2_s2`](#1x2_s2---fake-end-portal-room-secret-room) | Fake End Portal Room | 1. Stock |
| [`1x2_se1`](#1x2_se1---attic-room-secret-room) | Attic Room | 2. und 3. Stock |
| --- | --- | --- |
| [`2x2_s1`](#2x2_s1---lava-room-secret-room) | Lava Room | 1., 2. und 3. Stock |

## Details zu den Secret-Räumen

Die Secret-Räume in Woodland Mansions sind Räume, die generiert werden können, aber **keine Tür** haben. Das bedeutet, dass sie **nicht nur versteckt** generieren, sondern **niemals neben einem Gang** liegen. Secret-Räume können nur gefunden werden, indem man die Grundfläche mit den sichtbaren Räumen vergleicht und versucht, die versteckten Räume dadurch zu identifizieren.

Da Secret-Räume **abhängig von der Generierung der Hallways** sind, kann die Form der Hallways beeinflussen, wie viele Secret-Räume generiert werden. Es gibt **gewisse Formen von Hallways**, die häufiger zu Secret-Räumen führen als andere. Besonders für den 1. Stock und den 2. Stock gibt es bestimmte Hallway-Formen, die es erst möglich machen, dass Secret-Räume generiert werden können.

Für den 3. Stock gibt es **keine großen Ausreißer** in den Hallway-Formen, die zu einer höheren Anzahl von Secret-Räumen führen. Das liegt daran, dass die Hallways im 3. Stock nochmal neu generiert werden und es dort meist eine **viel kleinere Grundfläche** für Räume gibt. Dadurch können auf diesem Stockwerk generell **mehr Secret-Räume** generiert werden, da es dort **mehr Zellen** gibt, die **nicht neben einem Gang** liegen. Zudem sind hier die Secret-Räume auch viel einfacher zu identifizieren, da es auf dem 3. Stockwerk Fenster gibt und hier die meisten Räume auch tatsächlich Räume mit Fenstern sind, da es hier weniger Platz für Räume gibt, die komplett im Inneren der Mansion liegen.

### 1x1 Secret-Räume

Diese Secret-Räume haben eine **Grundfläche** von nur 1 Zelle, dadurch ist es relativ wahrscheinlich, dass sie generieren können, da es nur eine Zelle gibt, die nicht neben einem Gang liegen darf. Da es insgesamt **vier verschiedene** 1x1 Secret-Räume gibt, entscheidet das Spiel per **Zufall** (wie bei einem 4-seitigen Würfel), welcher davon entsteht.

Durch die spezielle Generierung in **Stockwerk 3** generieren dort auch generell **mehr** 1x1 Secret-Räume, während es **im 1. und 2. Stock deutlich weniger** sind. In den unteren Stockwerken gibt es einige Positionen, die häufiger 1x1 Secret-Räume generieren als andere, da es hier bestimmte Hallway-Formen gibt, die es erst ermöglichen, dass 1x1 Secret-Räume generieren können, von denen manche häufiger sind als andere. Dadurch sind die 1x1 Secret-Räume hier auch eher im Westen, da dort tendenziell weniger Gänge generieren.

### 1x2 Secret-Räume

1x2 Secret-Räume (Clean Chest Room, Fake End Portal Room, Attic Room) sind etwas häufiger als 2x2 Secret-Räume, da sie nur eine **Grundfläche** von 2 Zellen haben.

Hier gibt es jedoch auch **Unterschiede zwischen den Stockwerken**:

Der `Attic Room` kann sowohl im 2. als auch im 3. Stock generieren und ist im 3. Stock häufiger, da es hier mehr Platz für Secret-Räume gibt. Er ist der einzige 1x2 Secret-Raum, der im 2. und 3. Stock generieren kann. Damit ist dieser der häufigste 1x2 Secret-Raum.

Die anderen beiden 1x2 Secret-Räume (Clean Chest Room und Fake End Portal Room) können nur im 1. Stock generieren. Dazu kommt, dass sie sich diesen Stock teilen, das bedeutet, dass das Platzieren eines 1x2 Secret-Raums nochmal einen 2-seitigen Würfelwurf erfordert, um zu entscheiden, welcher der beiden generiert wird.

### 2x2 Lava Room

Der 2x2 Lava Room ist **der seltenste Secret-Raum**, da er eine sehr große Grundfläche hat (4 Zellen) und es dadurch sehr unwahrscheinlich ist, dass alle 4 Zellen nicht neben einem Gang liegen. Obwohl er technisch in allen Stockwerken generieren kann, ist er **auf allen Stockwerken nahezu gleich selten**. Für diese Art von Secret-Raum muss es eine **sehr ungünstige Hallway-Form** geben, damit er generieren kann. In den untersuchten $100.000$ generierten Woodland Mansions gab es ein Hallway-Muster, das sehr deutlich auf Stockwerk 1 bzw. 2 zu einem 2x2 Lava Room geführt hat.

Diese Seltenheit liegt nicht nur an der großen Grundfläche, sondern an mehreren Faktoren, die zusammen die Generierung eines 2x2 Lava Rooms extrem unwahrscheinlich machen:

- Es werden immer zuerst 2x2 Räume neben einem Gang generiert, bevor 1x2 oder 1x1 Räume generiert werden. Das bedeutet, dass der Platz für jegliche Secret-Räume so gering gehalten wird wie möglich und vorallem für 2x2 Räume, die ja eine große Grundfläche haben, wird dadurch der Platz für Secret-Räume extrem eingeschränkt.
- Da Hallways möglichst nach Westen generieren und es am Eingang keinen Platz für 2x2 Secret Räume gibt (da hier überall Gänge sind), sind die möglichen Positionen für 2x2 Räume generell schon sehr eingeschränkt und konzentrieren sich auf die Nord-Westseite der Mansion für Stockwerk 1 und 2.

## Spezielle Hallway-Formen, die zu mehr Secret-Räumen führen

Wie bereits bei der [Hallway-Generierung](#algorithmus-zur-generierung-der-hallways) erklärt, gibt es gewisse Formen von Hallways, die häufiger zu Secret-Räumen führen als andere. Besonders für den 1. Stock und den 2. Stock gibt es bestimmte Hallway-Formen, die es erst möglich machen, dass Secret-Räume generiert werden können. Im Folgenden werden für die verschiedenen Secret-Raum-Typen jeweils die häufigsten 6 Hallway-Formen gezeigt, die zu diesem Secret-Raum geführt haben. Zudem wird jeweils auch die Anzahl der unterschiedlichen Hallway-Formen gezeigt, die zu diesem Secret-Raum geführt haben, um die Vielfalt der Hallway-Formen zu verdeutlichen, die zu einem bestimmten Secret-Raum führen können.

Alle Ergebnisse beziehen sich auf die 100.000 generierten Woodland Mansions.

> [!Abstract] Legende:
>
> - `GRAU`: Räume oder Luft
> - `ORANGE`: Gänge bzw. Hallways
> - `GELB`: Eingang der Mansion

### 1x1 Secret-Räume Hallways

#### 1x1 - Stockwerk 1

Es gab nur 159 unterschiedliche Hallway-Formen, die zu einem 1x1 Secret-Raum auf **Stockwerk 1** geführt haben.

Wie man hier sieht, ist die 1. Form deutlich häufiger als andere Formen. Diese Form garantiert jedoch keine 1x1 Secret-Räume, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![1x1 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor1_1x1.png)

#### 1x1 - Stockwerk 2

Es gab nur 157 unterschiedliche Hallway-Formen, die zu einem 1x1 Secret-Raum auf **Stockwerk 2** geführt haben.

Auch hier ist die 1. Form deutlich häufiger als andere Formen, diese Form ist die gleiche wie die häufigste Form auf Stockwerk 1, da die Hallways auf Stockwerk 1 und 2 identisch sind.

![1x1 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor2_1x1.png)

#### 1x1 - Stockwerk 3

Es gab 1803 unterschiedliche Hallway-Formen, die zu einem 1x1 Secret-Raum auf **Stockwerk 3** geführt haben.

Hier gibt es **keine großen Ausreißer** in den Hallway-Formen, die zu einer deutlich höheren Anzahl von 1x1 Secret-Räumen führen, jedoch gibt es 2 Formen die etwas häufiger sind als andere.

![1x1 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor3_1x1.png)

### 1x2 Secret-Räume Hallways

#### 1x2 - Stockwerk 1

Es gab nur 140 unterschiedliche Hallway-Formen, die zu einem 1x2 Secret-Raum auf **Stockwerk 1** geführt haben.

Hier ist die 1. Form deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 1x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![1x2 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor1_1x2.png)

#### 1x2 - Stockwerk 2

Es gab nur 134 unterschiedliche Hallway-Formen, die zu einem 1x2 Secret-Raum auf **Stockwerk 2** geführt haben.

Hier ist die 1. Form deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 1x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![1x2 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor2_1x2.png)

#### 1x2 - Stockwerk 3

Es gab 1651 unterschiedliche Hallway-Formen, die zu einem 1x2 Secret-Raum auf **Stockwerk 3** geführt haben.

Hier gibt es **keine großen Ausreißer** in den Hallway-Formen, die zu einer deutlich höheren Anzahl von 1x2 Secret-Räumen führen, jedoch sind die **Formen** an sich auffällig, es scheint als ob **eine einzige Hallway-Zelle** und **ein L-Förmiger Hallway-Abschnitt** aus 8 Abschnitten besonders häufig zu 1x2 Secret-Räumen führen, da diese Formen mehr Platz für Secret-Räume bieten.

![1x2 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor3_1x2.png)

### 2x2 Secret-Raum (Lava Room) Hallways

#### 2x2 - Stockwerk 1

Es gab nur 10 unterschiedliche Hallway-Formen, die zu einem 2x2 Secret-Raum auf **Stockwerk 1** geführt haben.

Hier ist die 1. Form deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 2x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![2x2 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor1_2x2.png)

#### 2x2 - Stockwerk 2

Es gab nur 13 unterschiedliche Hallway-Formen, die zu einem 2x2 Secret-Raum auf **Stockwerk 2** geführt haben.

Hier ist die Generierung ähnlich zu Stockwerk 1, die 1. Form ist deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 2x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![2x2 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor2_2x2.png)

#### 2x2 - Stockwerk 3

Es gab 85 unterschiedliche Hallway-Formen, die zu einem 2x2 Secret-Raum auf **Stockwerk 3** geführt haben.

Hier sind ebenfalls **keine großen Ausreißer** in den Hallway-Formen, die zu einer deutlich höheren Anzahl von 2x2 Secret-Räumen führen, jedoch gibt es hier wieder einen **bestimmten Hallway-Verlauf**, der besonders häufig zu 2x2 Secret-Räumen führt, da er viel Platz für Secret-Räume bietet. Das ist der gleiche **L-Förmige Hallway-Abschnitt** aus 8 Abschnitten, der auch bei 1x2 Secret-Räumen auffällig war.

![2x2 Secret-Room Hallway Shapes](/woodland_mansion/no_chances/hallways_floor3_2x2.png)

## Detaillierte Analyse jedes Raums pro Stockwerk

### 1x1_a1 - Flower room

![1x1_a1 - Preview](/woodland_mansion/rooms/1x1_a1.png)

Raum-Typ: `1x1`

Ein Raum mit einer Bruchsteinbank, auf der fünf Blumentöpfe mit vier verschiedenen Blumen platziert sind.

![1x1_a1 - Flower room](/woodland_mansion/no_chances/1x1_a1_Flower_room.png)

### 1x1_a2 - Pumpkin ring room

![1x1_a2 - Preview](/woodland_mansion/rooms/1x1_a2.png)

Raum-Typ: `1x1`

Ein Raum mit einem Bruchsteinring an den Wänden, auf dem Schienen liegen und an dessen Innenseiten Leitern angebracht sind. Ein einzelner geschnitzter Kürbis befindet sich in der Mitte des Rings gegenüber dem Eingang.

![1x1_a2 - Pumpkin ring room](/woodland_mansion/no_chances/1x1_a2_Pumpkin_ring_room.png)

### 1x1_a3 - Office

![1x1_a3 - Preview](/woodland_mansion/rooms/1x1_a3.png)

Raum-Typ: `1x1`

Ein Raum mit zwei unterschiedlich hohen Bruchsteintischen und passenden Stühlen. Auf den Tischen befinden sich einige Blumentöpfe und Teppiche.

![1x1_a3 - Office](/woodland_mansion/no_chances/1x1_a3_Office.png)

### 1x1_a4 - Checkerboard room

![1x1_a4 - Preview](/woodland_mansion/rooms/1x1_a4.png)

Raum-Typ: `1x1`

Ein Raum mit einem Schachbrettmuster auf dem Boden, der an eine Küche erinnert. Alle Wände sind mit Eichenzäunen ausgekleidet. Über der Tür ist eine Beutekiste versteckt.

![1x1_a4 - Checkerboard room](/woodland_mansion/no_chances/1x1_a4_Checkerboard_room.png)

### 1x1_a5 - White tulip sanctuary

![1x1_a5 - Preview](/woodland_mansion/rooms/1x1_a5.png)

Raum-Typ: `1x1`

Ein Raum mit einer eingelassenen Bruchsteinstruktur an der Wand und einer einzelnen getopften Tulpe in der Nische.

![1x1_a5 - White tulip sanctuary](/woodland_mansion/no_chances/1x1_a5_White_tulip_sanctuary.png)

### 1x1_b1 - Birch arch room

![1x1_b1 - Preview](/woodland_mansion/rooms/1x1_b1.png)

Raum-Typ: `1x1`

Ein büroähnlicher Raum mit einem Schreibtisch und einem Blumentopf darauf sowie einem markanten Bogen in der Mitte aus Birkenholzzäunen, -stufen und -treppen.

![1x1_b1 - Birch arch room](/woodland_mansion/no_chances/1x1_b1_Birch_arch_room.png)

### 1x1_b2 - Small dining room

![1x1_b2 - Preview](/woodland_mansion/rooms/1x1_b2.png)

Raum-Typ: `1x1`

Ein Raum mit einem teppichbelegten Tisch und Stühlen aus Schwarzeichenholztreppen. Die oberen Wandteile sind mit kaminähnlichen Strukturen verziert.

![1x1_b2 - Small dining room](/woodland_mansion/no_chances/1x1_b2_Small_dining_room.png)

### 1x1_b3 - Single bed bedroom

![1x1_b3 - Preview](/woodland_mansion/rooms/1x1_b3.png)

Raum-Typ: `1x1`

Ein gemütlicher Raum mit einem Wollbett, einem Bruchsteinkamin und einem Bonsai aus einem Zaun und einem Laubblock.

![1x1_b3 - Single bed bedroom](/woodland_mansion/no_chances/1x1_b3_Single_bed_bedroom.png)

### 1x1_b4 - Small library

![1x1_b4 - Preview](/woodland_mansion/rooms/1x1_b4.png)

Raum-Typ: `1x1`

Ein kleiner Arbeitsraum, dessen einzige Besonderheit mehrere Bücherregale in den Ecken sind.

![1x1_b4 - Small library](/woodland_mansion/no_chances/1x1_b4_Small_library.png)

### 1x1_b5 - Allium room

![1x1_b5 - Preview](/woodland_mansion/rooms/1x1_b5.png)

Raum-Typ: `1x1`

Ein Raum mit einem von Ranken umschlungenen Eichenständer, auf dem mehrere getopfte Sternlauche stehen. Ein voller Kessel und eine Truhe mit weiteren Sternlauchen befinden sich in der Nähe. Das Dach besteht aus Eichenzäunen.

![1x1_b5 - Allium room](/woodland_mansion/no_chances/1x1_b5_Allium_room.png)

### 1x2_a1 - Gray banner room

![1x2_a1 - Preview](/woodland_mansion/rooms/1x2_a1.png)

Raum-Typ: `1x2`

Ein Raum mit einer altarähnlichen Konstruktion aus Bruchstein in der Mitte, die einen kurzen, schmalen Durchgang mit einem grauen Banner am Ende bildet. Hinter der Konstruktion ist eine Truhe versteckt. Hier spawnt immer ein Diener (Vindicator).

![1x2_a1 - Gray banner room](/woodland_mansion/no_chances/1x2_a1_Gray_banner_room.png)

### 1x2_a2 - Wheat farm

![1x2_a2 - Preview](/woodland_mansion/rooms/1x2_a2.png)

Raum-Typ: `1x2`

Ein Raum mit einer Weizenfarm und einem kleinen Tisch mit Stuhl in der Ecke. Das Wasser der Farm ist mit Seerosenblättern bedeckt. Einige oder alle Nutzpflanzen können fehlen. Die Farm ähnelt einer Dorffarm, verwendet jedoch Schwarzeichenstämme.

![1x2_a2 - Wheat farm](/woodland_mansion/no_chances/1x2_a2_Wheat_farm.png)

### 1x2_a3 - Forge room

![1x2_a3 - Preview](/woodland_mansion/rooms/1x2_a3.png)

Raum-Typ: `1x2`

Ein Raum mit Bögen aus poliertem Andesit. Am Ende des Raums befinden sich ein beschädigter Amboss und ein Lavabecken, das von poliertem Andesit umgeben ist, um das Brennen der umliegenden Bretter zu verhindern. Hier spawnt immer ein Diener.

![1x2_a3 - Forge room](/woodland_mansion/no_chances/1x2_a3_Forge_room.png)

### 1x2_a4 - Sapling farm

![1x2_a4 - Preview](/woodland_mansion/rooms/1x2_a4.png)

Raum-Typ: `1x2`

Ein Raum mit zwei Ebenen voller Schwarzeichensetzlinge, die durch Leitern bis zur Decke verbunden sind. Eine Truhe mit Schwarzeichensetzlingen steht in der Nähe des Eingangs.

![1x2_a4 - Sapling farm](/woodland_mansion/no_chances/1x2_a4_Sapling_farm.png)

### 1x2_a5 - Wool room

![1x2_a5 - Preview](/woodland_mansion/rooms/1x2_a5.png)

Raum-Typ: `1x2`

Ein Raum mit einem unordentlichen Haufen aus verschiedenen blauen Wolltönen.

![1x2_a5 - Wool room](/woodland_mansion/no_chances/1x2_a5_Wool_room.png)

### 1x2_a6 - Tree-chopping room

![1x2_a6 - Preview](/woodland_mansion/rooms/1x2_a6.png)

Raum-Typ: `1x2`

Ein Raum mit einem künstlichen Baum auf einer Erdplattform und einer Truhe, die immer eine Eisenaxt mit Effizienz I enthält. Der Eingang ist durch eine Wand aus Schwarzeichenbrettern verschlossen.

> [!Note] Achtung:
> Dieser Raum hat eine versiegelte Tür. Dieses Feature wird oft verwechselt mit den "Secret-Räumen", die gar keine Türen haben!

![1x2_a6 - Tree-chopping room](/woodland_mansion/no_chances/1x2_a6_Tree_chopping_room.png)

### 1x2_a7 - Mushroom farm

![1x2_a7 - Preview](/woodland_mansion/rooms/1x2_a7.png)

Raum-Typ: `1x2`

Ein Raum mit einer Pilzfarm sowie einem Tisch, einem Stuhl und einer leeren Truhe.

![1x2_a7 - Mushroom farm](/woodland_mansion/no_chances/1x2_a7_Mushroom_farm.png)

### 1x2_a8 - Dual-staged farm

![1x2_a8 - Preview](/woodland_mansion/rooms/1x2_a8.png)

Raum-Typ: `1x2`

Ein Raum mit einer zweistufigen Farm; auf der unteren wachsen Kürbisse und auf der oberen Melonen. Hier spawnt immer ein Diener.

![1x2_a8 - Dual-staged farm](/woodland_mansion/no_chances/1x2_a8_Dual_staged_farm.png)

### 1x2_a9 - Small storage room

![1x2_a9 - Preview](/woodland_mansion/rooms/1x2_a9.png)

Raum-Typ: `1x2`

Ein Raum mit Regalen, in denen viele leere einzelne Truhen stehen. Hier spawnt immer ein Diener.

![1x2_a9 - Small storage room](/woodland_mansion/no_chances/1x2_a9_Small_storage_room.png)

### 1x2_b1 - Redstone jail

![1x2_b1 - Preview](/woodland_mansion/rooms/1x2_b1.png)

Raum-Typ: `1x2`

Ein Raum mit einem großen Bruchsteingefängnis, das über eine mit einem Hebel verbundene Redstone-Schaltung zugänglich ist, die zwei Eisentüren öffnet. Im Inneren befinden sich ein kleiner Bruchsteintisch, braune Teppiche und ein Kessel. Hier spawnt immer ein Diener.

![1x2_b1 - Redstone jail](/woodland_mansion/no_chances/1x2_b1_Redstone_jail.png)

### 1x2_b2 - Small jail

![1x2_b2 - Preview](/woodland_mansion/rooms/1x2_b2.png)

Raum-Typ: `1x2`

Ein Raum mit einem Bruchsteingefängnis, das einen Kessel und braune Teppiche enthält. Außerhalb befinden sich ein Tisch und ein Stuhl, in deren Nähe immer ein Diener spawnt.

![1x2_b2 - Small jail](/woodland_mansion/no_chances/1x2_b2_Small_jail.png)

### 1x2_b3 - Wood arch hallway

![1x2_b3 - Preview](/woodland_mansion/rooms/1x2_b3.png)

Raum-Typ: `1x2`

Ein Raum mit mehreren Bögen aus Schwarzeichenstämmen sowie einer Beutekiste am Ende. Hier spawnt immer ein Diener.

![1x2_b3 - Wood arch hallway](/woodland_mansion/no_chances/1x2_b3_Wood_arch_hallway.png)

### 1x2_b4 - Winding stairway room

![1x2_b4 - Preview](/woodland_mansion/rooms/1x2_b4.png)

Raum-Typ: `1x2`

Ein Raum mit einer ein Block breiten, eingemauerten Wendeltreppe, die zu einer Beutekiste führt.

![1x2_b4 - Winding stairway room](/woodland_mansion/no_chances/1x2_b4_Winding_stairway_room.png)

### 1x2_b5 - Illager head room

![1x2_b5 - Preview](/woodland_mansion/rooms/1x2_b5.png)

Raum-Typ: `1x2`

Ein ansonsten leerer Raum mit Illager-Pixelkunst.

![1x2_b5 - Illager head room](/woodland_mansion/no_chances/1x2_b5_Illager_head_room.png)

### 1x2_c1 - Medium dining room

![1x2_c1 - Preview](/woodland_mansion/rooms/1x2_c1.png)

Raum-Typ: `1x2`

Ein Raum mit einem Tisch aus Eichentreppen, dekoriert mit einer Blume im Topf; in der Ecke scheint eine Anrichte zu sein. Ein Kronleuchter hängt von der Decke.

![1x2_c1 - Medium dining room](/woodland_mansion/no_chances/1x2_c1_Medium_dining_room.png)

### 1x2_c2 - Double bed bedroom

![1x2_c2 - Preview](/woodland_mansion/rooms/1x2_c2.png)

Raum-Typ: `1x2`

Ein Raum mit rosa und lila Betten am Ende sowie einem Tisch mit Blumentopf in der Ecke.

![1x2_c2 - Double bed bedroom](/woodland_mansion/no_chances/1x2_c2_Double_bed_bedroom.png)

### 1x2_c3 - Triple bed bedroom

![1x2_c3 - Preview](/woodland_mansion/rooms/1x2_c3.png)

Raum-Typ: `1x2`

Ein Raum mit drei blauen Betten und einem Schreibtisch. Hier spawnen immer drei Diener.

![1x2_c3 - Triple bed bedroom](/woodland_mansion/no_chances/1x2_c3_Triple_bed_bedroom.png)

### 1x2_c4 - Medium library

![1x2_c4 - Preview](/woodland_mansion/rooms/1x2_c4.png)

Raum-Typ: `1x2`

Ein lounge-artiger Raum mit vielen Bücherregalen, schaukelähnlichen Sitzstrukturen an den Wänden und einem Tisch in der Mitte mit vier nach Größe geordneten Blumentöpfen.

![1x2_c4 - Medium library](/woodland_mansion/no_chances/1x2_c4_Medium_library.png)

### 1x2_c_stairs - Curved staircase

![1x2_c_stairs - Preview](/woodland_mansion/rooms/1x2_c_stairs.png)

Raum-Typ: `1x2`

Eine Treppe, die nach oben führt und am Fuß nach links oder rechts gebogen ist, darüber hängt ein Illager-Kopf aus Wolle. Jedes Waldanwesen generiert einen von zwei Treppenhaustypen. Nur eine Treppe führt in den dritten Stock, falls mehrere vorhanden sind.

![1x2_c_stairs - Curved staircase](/woodland_mansion/no_chances/1x2_c_stairs_Curved_staircase.png)

### 1x2_d1 - Master bedroom

![1x2_d1 - Preview](/woodland_mansion/rooms/1x2_d1.png)

Raum-Typ: `1x2`

Ein Raum mit einem prunkvollen Himmelbett. Über dem Türrahmen hängen graue Banner an einer verzierten Wanddekoration.

![1x2_d1 - Master bedroom](/woodland_mansion/no_chances/1x2_d1_Master_bedroom.png)

### 1x2_d2 - Bedroom with loft

![1x2_d2 - Preview](/woodland_mansion/rooms/1x2_d2.png)

Raum-Typ: `1x2`

Ein zweistöckiges Schlafzimmer mit einem Schrank aus Birkenbrettern und Schwarzeichentüren auf der ersten Ebene. Eine Leiter am Eingang führt zu einer Empore mit Beutekiste und Wollbett.

![1x2_d2 - Bedroom with loft](/woodland_mansion/no_chances/1x2_d2_Bedroom_with_loft.png)

### 1x2_d3 - Ritual room

![1x2_d3 - Preview](/woodland_mansion/rooms/1x2_d3.png)

Raum-Typ: `1x2`

Ein Raum mit einer komplexen Altarstruktur und einem markanten, erhöhten Block unter einem schwarzen Teppich. Bruchsteinbänke verlaufen an beiden Seiten, und eine Konstruktion aus Bruchstein mit zwei schwarzen Bannern hängt über dem Altar. Hier spawnen immer zwei Diener und ein Magier (Evoker).

![1x2_d3 - Ritual room](/woodland_mansion/no_chances/1x2_d3_Ritual_room.png)

### 1x2_d4 - Cat statue room

![1x2_d4 - Preview](/woodland_mansion/rooms/1x2_d4.png)

Raum-Typ: `1x2`

Ein Raum mit einer großen Statue einer Katze aus schwarzer Wolle in der Mitte.

![1x2_d4 - Cat statue room](/woodland_mansion/no_chances/1x2_d4_Cat_statue_room.png)

### 1x2_d5 - Chicken statue room

![1x2_d5 - Preview](/woodland_mansion/rooms/1x2_d5.png)

Raum-Typ: `1x2`

Ein Raum mit einer großen Statue eines Huhns aus Wolle in der Mitte.

![1x2_d5 - Chicken statue room](/woodland_mansion/no_chances/1x2_d5_Chicken_statue_room.png)

### 1x2_d_stairs - Straight staircase

![1x2_d_stairs - Preview](/woodland_mansion/rooms/1x2_d_stairs.png)

Raum-Typ: `1x2`

Eine gerade Treppe, die in den dritten Stock führt, darüber befindet sich Illager-Pixelkunst. Jedes Waldanwesen generiert einen von zwei Treppenhaustypen.

![1x2_d_stairs - Straight staircase](/woodland_mansion/no_chances/1x2_d_stairs_Straight_staircase.png)

### 2x2_a1 - Large jail

![2x2_a1 - Preview](/woodland_mansion/rooms/2x2_a1.png)

Raum-Typ: `2x2`

Ein Raum mit vier Bruchsteingefängniszellen von leicht unterschiedlicher Größe. Hier spawnt immer ein Diener. In den Zellen besteht die Chance, dass Hilfsgeister (Allays) spawnen.

![2x2_a1 - Large jail](/woodland_mansion/no_chances/2x2_a1_Large_jail.png)

### 2x2_a2 - Large storage room

![2x2_a2 - Preview](/woodland_mansion/rooms/2x2_a2.png)

Raum-Typ: `2x2`

Ein Raum mit Regalen, die viele leere Doppeltruhen enthalten. Hier spawnt immer ein Diener.

![2x2_a2 - Large storage room](/woodland_mansion/no_chances/2x2_a2_Large_storage_room.png)

### 2x2_a3 - Illager statue room

![2x2_a3 - Preview](/woodland_mansion/rooms/2x2_a3.png)

Raum-Typ: `2x2`

Ein Raum mit einer riesigen Statue des Oberkörpers eines Illagers aus Wolle, inklusive Händen, die in der linken Hand ein fackelähnliches Objekt halten. Ein Lapislazuliblock ist im Inneren des Kopfes versteckt.

![2x2_a3 - Illager statue room](/woodland_mansion/no_chances/2x2_a3_Illager_statue_room.png)

### 2x2_a4 - Nature room

![2x2_a4 - Preview](/woodland_mansion/rooms/2x2_a4.png)

Raum-Typ: `2x2`

Ein Raum mit einem Wasserspiel aus Andesit in einer Ecke und einem künstlichen Baum aus Schwarzeichenholz in der anderen.

![2x2_a4 - Nature room](/woodland_mansion/no_chances/2x2_a4_Nature_room.png)

### 2x2_b1 - Large dining room

![2x2_b1 - Preview](/woodland_mansion/rooms/2x2_b1.png)

Raum-Typ: `2x2`

Ein großer Speisesaal mit mehreren Tischen für drei Personen und einem Kronleuchter an der Decke. Eine kleine Anrichte sowie Fackeln in der Mitte jeder Wand sind ebenfalls vorhanden. Hier spawnen immer zwei Diener und ein Magier.

![2x2_b1 - Large dining room](/woodland_mansion/no_chances/2x2_b1_Large_dining_room.png)

### 2x2_b2 - Conference room

![2x2_b2 - Preview](/woodland_mansion/rooms/2x2_b2.png)

Raum-Typ: `2x2`

Ein großer Versammlungssaal mit einem U-förmigen Tisch, der mit getopften Tulpen dekoriert ist, sowie zwei Kronleuchtern an der Decke. Hier spawnen immer zwei Diener und ein Magier.

![2x2_b2 - Conference room](/woodland_mansion/no_chances/2x2_b2_Conference_room.png)

### 2x2_b3 - Large library

![2x2_b3 - Preview](/woodland_mansion/rooms/2x2_b3.png)

Raum-Typ: `2x2`

Ein großer Raum mit drei Bücherregal-Einheiten sowie einem Sitzbereich mit drei großen Sesseln.

![2x2_b3 - Large library](/woodland_mansion/no_chances/2x2_b3_Large_library.png)

### 2x2_b4 - Map room

![2x2_b4 - Preview](/woodland_mansion/rooms/2x2_b4.png)

Raum-Typ: `2x2`

Ein Raum mit einem großen Tisch, auf dem farbige Teppiche liegen, deren Muster anscheinend eine Karte darstellen. Ein kleines Bücherregal steht an einer der Wände. Hier spawnen immer zwei Diener und ein Magier.

![2x2_b4 - Map room](/woodland_mansion/no_chances/2x2_b4_Map_room.png)

### 2x2_b5 - Arena room

![2x2_b5 - Preview](/woodland_mansion/rooms/2x2_b5.png)

Raum-Typ: `2x2`

Ein großer Raum mit einer arena-ähnlichen Plattform aus glatten Steinplatten, die von einem Ring aus Schwarzeichenzäunen umgeben ist. Eine Leiter führt zu einer Empore mit einer versteckten Beutekiste.

![2x2_b5 - Arena room](/woodland_mansion/no_chances/2x2_b5_Arena_room.png)

### 1x1_as1 - X room (Secret Room)

![1x1_as1 - Preview](/woodland_mansion/rooms/1x1_as1.png)

Raum-Typ: `1x1`

Ein Geheimraum mit dekorativen "X"-Mustern aus Bruchstein an den Wänden. In der Ecke befindet sich eine Truhe. Diese Räume können auf jeder Etage generiert werden.

![1x1_as1 - X room](/woodland_mansion/no_chances/1x1_as1_X_room.png)

### 1x1_as2 - Spider room (Secret Room)

![1x1_as2 - Preview](/woodland_mansion/rooms/1x1_as2.png)

Raum-Typ: `1x1`

Ein Geheimraum voller Spinnweben mit einem Spinnen-Monsterspawner in der Mitte. Diese Räume können auf jeder Etage generiert werden.

![1x1_as2 - Spider room](/woodland_mansion/no_chances/1x1_as2_Spider_room.png)

### 1x1_as3 - Obsidian room (Secret Room)

![1x1_as3 - Preview](/woodland_mansion/rooms/1x1_as3.png)

Raum-Typ: `1x1`

Ein Geheimraum mit einer oktaederförmigen Obsidianmasse, in deren Innerem sich ein Diamantblock verbirgt. Diese Räume können auf jeder Etage generiert werden.

![1x1_as3 - Obsidian room](/woodland_mansion/no_chances/1x1_as3_Obsidian_room.png)

### 1x1_as4 - Birch pillar room (Secret Room)

![1x1_as4 - Preview](/woodland_mansion/rooms/1x1_as4.png)

Raum-Typ: `1x1`

Ein Geheimraum mit vier bis zur Decke ragenden Säulen aus Birkenholzbrettern. Diese Räume können auf jeder Etage generiert werden.

![1x1_as4 - Birch pillar room](/woodland_mansion/no_chances/1x1_as4_Birch_pillar_room.png)

### 1x2_s1 - Clean chest room (Secret Room)

![1x2_s1 - Preview](/woodland_mansion/rooms/1x2_s1.png)

Raum-Typ: `1x2`

Ein Geheimraum mit einer einsamen Beutekiste, umgeben von vier Fackeln auf Schwarzeichenzäunen in jeder Ecke des ansonsten leeren Raums. Diese Räume generieren nur im ersten Stock.

![1x2_s1 - Clean chest room](/woodland_mansion/no_chances/1x2_s1_Clean_chest_room.png)

### 1x2_s2 - Fake End portal room (Secret Room)

![1x2_s2 - Preview](/woodland_mansion/rooms/1x2_s2.png)

Raum-Typ: `1x2`

Ein Geheimraum mit einer Plattform aus orangefarbener Wolle in der Mitte und einem Ring aus grüner Wolle darüber, was wie ein End-Portal in einer Festung mit Lava darunter aussieht. Bruchsteintreppen und befallener Bruchstein ermöglichen den Zugang zum Ring, auf dem sich eine Redstone-Truhe mit zwei Enderperlen zwischen zwei TNT-Blöcken befindet. Wenn die Falle ausgelöst wird, zerstört das TNT den befallenen Bruchstein und setzt Silberfischchen frei. Diese Räume generieren nur im ersten Stock.

![1x2_s2 - Fake End portal room](/woodland_mansion/no_chances/1x2_s2_Fake_End_portal_room.png)

### 1x2_se1 - Attic room (Secret Room)

![1x2_se1 - Preview](/woodland_mansion/rooms/1x2_se1.png)

Raum-Typ: `1x2`

Ein Geheimraum, der in zwei Ebenen unterteilt ist. Die untere Ebene ist leer, während die verborgene obere Ebene an beiden Enden eine Truhe enthält. Diese Räume generieren in den oberen zwei Stockwerken.

![1x2_se1 - Attic room](/woodland_mansion/no_chances/1x2_se1_Attic_room.png)

### 2x2_s1 - Lava room (Secret Room)

![2x2_s1 - Preview](/woodland_mansion/rooms/2x2_s1.png)

Raum-Typ: `2x2`

Ein Geheimraum mit einer lavagefüllten Vitrine aus Glas, die von großen Obsidian-Fundamenten an Boden und Decke gehalten wird. In der Glasvitrine ist ein Diamantblock versteckt. Diese Räume können auf jeder Etage generiert werden.

![2x2_s1 - Lava room](/woodland_mansion/no_chances/2x2_s1_Lava_room.png)
