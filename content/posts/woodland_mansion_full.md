---
author: ["L3N0X"]
title: "Woodland Mansion (mit Wahrscheinlichkeiten)"
date: "2026-04-09"
description: "Detaillierter Report zu der Raum-Generierung in Woodland Mansions, inklusive der Wahrscheinlichkeiten"
summary: "Dieser Artikel bietet einen detaillierten Einblick in die Raum-Generierung von Woodland Mansions in Minecraft, einschließlich der Wahrscheinlichkeiten für das Auftreten verschiedener Raumtypen."
tags: ["woodland_mansion", "minecraft"]
categories: ["minecraft"]
ShowToc: true
TocOpen: true
---

Dieser Artikel erklärt die Generierung von Woodland Mansions in Minecraft. Dabei wird zuerst der Algorithmus zur Generierung der Hallways (Gänge) beschrieben und danach werden einzelne Räume genauer analysiert, um genaue Wahrscheinlichkeiten für das Auftreten verschiedener Raumtypen zu ermitteln.

## Generierung einer Woodland Mansion

### Algorithmus zur Generierung der Hallways

Die Generierung der Hallways in Woodland Mansions erfolgt durch einen Snake-Algorithmus, der vom Eingang der Mansion aus startet. Der Algorithmus geht dann jeweils einen Schritt weiter in eine zufällige Richtung. Dabei gibt es folgende Regeln:

1. Es gibt vier mögliche Richtungen: Norden, Osten, Süden und Westen.
2. 180-Grad-Wendungen sind nicht erlaubt
3. Beim Geradeaus laufen dürfen sich Wege nicht direkt verbinden (Schleifen können nur generieren, wenn sich 2 Wege unterschiedlicher Richtung zufällig berühren)
4. Es gibt eine künstliche 50% Chance, dass der Algorithmus nicht nach Osten gehen darf (Zurück Richtung Eingang), dadurch gehen Gänge tendenziell eher nach Westen.
5. Ein Gang kann maximal 12 bzw. 6 Abschnitte lang sein.
6. Es werden 4 Startpunkte genutzt (Norden + Süden, Nord-West + Süd-West):

![Platzierung der 4 Startpunkte](/woodland_mansion/initial_snake_placement.png)

**Anmerkung:** Die Gänge sind in Stockwerk 1 und 2 identisch, im 3. Stockwerk werden die Gänge nochmal neu generiert mit nur einem einzigen Startpunkt. Die Länge für diesen Gang ist auf 8 Abschnitte begrenzt und Zellen, die bereits in den unteren Stockwerken keinen Raum haben (Komplett leer, generieren keinen Raum, sind leere Ecken außerhalb der Woodland Mansion) werden zuvor blockiert, sodass dort keine Gänge generieren können. Dadurch, dass der Hallway viel kleiner ist (36 vs. 8 Abschnitte) und dieser nicht immer alle Abschnitte erfolgreich platzieren kann, gibt es im 3. Stockwerk meist eine viel kleinere Grundfläche für Räume, was wiederum die Wahrscheinlichkeit für Secret-Räume erhöht, da es dort mehr Zellen gibt, die nicht neben einem Gang liegen (wird weiter unten nochmal genauer beschrieben).

### Generierung der Räume

Bei der Generierung der Hallways werden Positionen gespeichert, an denen Räume generiert werden können. Es gibt 6 Arten von Räumen:

1. **Normale 1x1 Räume**: Diese Räume haben eine Zellengröße von 1x1 und jeweils 1 Tür

Schritte zur Generierung pro Stockwerk:

1. Alle Raum-Koordinaten werden in einer Liste gespeichert.
2. Die Liste wird zufällig gemischt (Pro Stockwerk wird neu gemischt)
3. Danach wird diese Liste iterativ abgearbeitet, um Räume zu generieren.
4. Zuerst wird geschaut, ob ein 2x2 Raum generiert werden kann, erst danach 1x2 Räume, 1x1 Räume werden nur geplaced, wenn kein größerer Raum an dieser Stelle generiert werden kann. (Das geschieht pro Stockwerk, die Aufteilung der Räume auf den Stockwerken ist also nicht die gleiche)
5. Anschließend wird eine der Raum-Zellen bestimmt, die dann die Türe wird. Wenn diese Zelle jedoch nicht neben einem Gang liegt, wird eine andere Zelle gewählt und erneut getestet, bis eine Zelle gefunden wird, die neben einem Gang liegt.
6. Da der Hallway-Algorithmus nicht garantiert, dass alle Räume neben einem Gang liegen, gibt es die Möglichkeit, dass manche Räume keine Tür haben. Diese Räume sind dann die sogenannten **"Secret-Räume"**. Das Generieren wird später nochmal genau beschrieben.
7. Bei den restlichen 1x2 Räumen wird anschließend noch bestimmt, welche Form der Eingang hat, es gibt Räume mit einem Eingang auf der kurzen Seite (`b` & `d` Raum-Varianten) und Räume mit einem Eingang auf der langen Seite (`a` & `c` Raum-Varianten). Dies hat einen Einfluss auf die Wahrscheinlichkeit, wird ebenfalls später genauer beschrieben. Die `a` & `b` Raum-Varianten können nur im Erdgeschoss generiert werden, die `c` & `d` Raum-Varianten im 1. und 2. Obergeschoss (ausgenommen `stairs`-Räume, diese können nur im 1. Obergeschoss generiert werden).
8. Bei den 1x1 und 2x2 Räumen gibt es ebenfalls `a` & `b` Raum-Varianten, diese unterscheiden sich jedoch nicht bei der Türen-Platzierung. Die `a` Varianten können nur im Erdgeschoss generiert werden, die `b` Varianten im 1. und 2. Obergeschoss.
9. Nur im 1. Obergeschoss: Es wird nun nach einem Raum gesucht, der 1x2 groß ist und eine Türe hat. Es kann entweder ein `curved` (`c` Raum-Variante) oder `straight` (`d` Raum-Variante) Staircase (Treppe) generiert werden. Diese Treppe führt dann in das 2. Obergeschoss. Wird kein passender Raum gefunden, dann tritt der seltene Fall ein, dass eine Woodland Mansion ganz ohne 3. Stockwerk generiert wird.
10. Nachdem alle Räume bestimmt wurden, werden diese festgelegt für die Generierung und die anschließende Platzierung der Struktur-Teile und Räume.

### Animation der Generierung

Hier ist eine Animation, die die Generierung der Hallways und Räume in einer Woodland Mansion zeigt (2 Beispiele):

![Animation der Generierung](/woodland_mansion/generation_slowmo.webp)

**Legende:**

- `GRAU`: Gänge bzw. Hallways
- `GELB`: Eingang der Mansion / Treppen
- `ORANGE`: Markierung für den Startpunkt
- `BLAU`: 1x1 Räume
- `GRÜN`: 1x2 Räume
- `LILA`: 2x2 Räume
- `HELLBLAU`: 1x1 Secret-Räume
- `HELLGRÜN`: 1x2 Secret-Räume
- `PINK`: 2x2 Secret-Raum (Lava Room)

## Liste der Raumtypen und deren Platzierung

Die folgende Tabelle zeigt alle Raumtypen, die in Woodland Mansions generiert werden können, inklusive der Wahrscheinlichkeit, mit der sie generiert werden. Diese Wahrscheinlichkeiten wurden durch die Analyse von 100.000 generierten Woodland Mansions ermittelt und geben an, wie wahrscheinlich es ist, dass eine Mansion den jeweiligen Raumtyp enthält. Zudem sind die Stockwerke angegeben, in denen die Räume generiert werden können sowie die Struktur-Namen, die in den Minecraft-Struktur-Dateien verwendet werden.

### 1x1 Räume

| Struktur-Name | Raum-Name | Stockwerk | Wahrscheinlichkeit |
| --- | --- | --- | --- |
| `1x1_a1` | Flower Room | 1. Stock | 56.43% |
| `1x1_a2` | Pumpkin Room | 1. Stock | 56.08% |
| `1x1_a3` | Office | 1. Stock | 56.11% |
| `1x1_a4` | Checkerboard Room | 1. Stock | 55.97% |
| `1x1_a5` | White Tulip Sanctuary | 1. Stock | 56.51% |
| --- | --- | --- | --- |
| `1x1_b1` | Birch Arch Room | 2. und 3. Stock | 65.61% |
| `1x1_b2` | Small Dining Room | 2. und 3. Stock | 65.41% |
| `1x1_b3` | Single Bed Bedroom | 2. und 3. Stock | 65.65% |
| `1x1_b4` | Small Library | 2. und 3. Stock | 65.36% |
| `1x1_b5` | Small Storage Room | 2. und 3. Stock | 65.68% |

### 1x2 Räume

| Struktur-Name | Raum-Name | Stockwerk | Wahrscheinlichkeit |
| --- | --- | --- | --- |
| `1x2_a1` | Gray Banner Room | 1. Stock | 39.62% |
| `1x2_a2` | Wheat Farm | 1. Stock | 39.47% |
| `1x2_a3` | Forge Room (Anvil Room) | 1. Stock | 39.68% |
| `1x2_a4` | Sapling Farm | 1. Stock | 39.84% |
| `1x2_a5` | Wool Room | 1. Stock | 39.27% |
| `1x2_a6` | Tree-Chopping Room | 1. Stock | 39.50% |
| `1x2_a7` | Mushroom Farm | 1. Stock | 39.40% |
| `1x2_a8` | Dual-staged Farm | 1. Stock | 39.72% |
| `1x2_a9` | Small Storage Room | 1. Stock | 39.36% |
| --- | --- | --- | --- |
| `1x2_b1` | Redstone Jail | 1. Stock | 26.87% |
| `1x2_b2` | Small Jail | 1. Stock | 26.78% |
| `1x2_b3` | Wood Arch Hallway | 1. Stock | 26.77% |
| `1x2_b4` | Winding Stairway Room | 1. Stock | 26.61% |
| `1x2_b5` | Illager Head Room | 1. Stock | 26.66% |
| --- | --- | --- | --- |
| `1x2_c1` | Medium Dining Room | 2. und 3. Stock | 76.34% |
| `1x2_c2` | Double Bed Bedroom | 2. und 3. Stock | 76.33% |
| `1x2_c3` | Triple Bed Bedroom | 2. und 3. Stock | 76.36% |
| `1x2_c4` | Medium Library | 2. und 3. Stock | 76.24% |
| --- | --- | --- | --- |
| `1x2_c_stairs` | Curved Staircase | 2. Stock | 73.52% |
| --- | --- | --- | --- |
| `1x2_d1` | Master Bedroom | 2. und 3. Stock | 41.49% |
| `1x2_d2` | Bedroom with Loft | 2. und 3. Stock | 41.40% |
| `1x2_d3` | Ritual Room | 2. und 3. Stock | 41.57% |
| `1x2_d4` | Cat Statue Room | 2. und 3. Stock | 41.48% |
| `1x2_d5` | Chicken Statue Room | 2. und 3. Stock | 41.34% |
| --- | --- | --- | --- |
| `1x2_d_stairs` | Straight Staircase | 2. Stock | 26.48% |

### 2x2 Räume

| Struktur-Name | Raum-Name | Stockwerk | Wahrscheinlichkeit |
| --- | --- | --- | --- |
| `2x2_a1` | Large Jail | 1. Stock | 57.48% |
| `2x2_a2` | Large Storage Room | 1. Stock | 57.43% |
| `2x2_a3` | Illager Statue Room | 1. Stock | 57.50% |
| `2x2_a4` | Nature Room | 1. Stock | 57.43% |
| --- | --- | --- | --- |
| `2x2_b1` | Large Dining Room | 2. und 3. Stock | 62.84% |
| `2x2_b2` | Conference Room | 2. und 3. Stock | 62.54% |
| `2x2_b3` | Large Library | 2. und 3. Stock | 62.72% |
| `2x2_b4` | Map Room | 2. und 3. Stock | 62.40% |
| `2x2_b5` | Arena Room | 2. und 3. Stock | 62.61% |

### Secret-Räume

| Struktur-Name | Raum-Name | Stockwerk | Wahrscheinlichkeit |
| --- | --- | --- | --- |
| `1x1_as1` | X Room | 1., 2. und 3. Stock | 14.54% |
| `1x1_as2` | Spider Room | 1., 2. und 3. Stock | 14.65% |
| `1x1_as3` | Obsidian Room | 1., 2. und 3. Stock | 14.48% |
| `1x1_as4` | Birch Pillar Room | 1., 2. und 3. Stock | 14.63% |
| --- | --- | --- | --- |
| `1x2_s1` | Clean Chest Room | 1. Stock | 6.24% |
| `1x2_s2` | Fake End Portal Room | 1. Stock | 6.29% |
| `1x2_se1` | Attic Room | 2. und 3. Stock | 35.08% |
| --- | --- | --- | --- |
| `2x2_s1` | Lava Room | 1., 2. und 3. Stock | 3.76% |

## Details zu den Secret-Räumen

Die Secret-Räume in Woodland Mansions sind Räume, die generiert werden können, aber keine Tür haben. Das bedeutet, dass sie nicht nur versteckt generieren, sondern niemals neben einem Gang liegen. Secret-Räume können nur gefunden werden, indem man die Grundfläche mit den sichtbaren Räumen vergleicht und versucht, die versteckten Räume dadurch zu identifizieren.

Da Secret-Räume abhängig von der Generierung der Hallways sind, kann die Form der Hallways beeinflussen, wie viele Secret-Räume generiert werden. Es gibt gewisse Formen von Hallways, die häufiger zu Secret-Räumen führen als andere. Besonders für den 1. Stock und den 2. Stock gibt es bestimmte Hallway-Formen, die es erst möglich machen, dass Secret-Räume generiert werden können.

Für den 3. Stock gibt es keine großen Ausreißer in den Hallway-Formen, die zu einer höheren Anzahl von Secret-Räumen führen. Das liegt daran, dass die Hallways im 3. Stock nochmal neu generiert werden und es dort meist eine viel kleinere Grundfläche für Räume gibt. Dadurch können auf diesem Stockwerk generell mehr Secret-Räume generiert werden, da es dort mehr Zellen gibt, die nicht neben einem Gang liegen. Zudem sind hier die Secret-Räume auch viel einfacher zu identifizieren, da es auf dem 3. Stockwerk Fenster gibt und hier die meisten Räume auch tatsächlich Räume mit Fenstern sind, da es hier weniger Platz für Räume gibt, die komplett im Inneren der Mansion liegen.

### 1x1 Secret-Räume

Diese Secret-Räume haben eine Grundfläche von nur 1 Zelle, dadurch ist es relativ wahrscheinlich, dass sie generieren können, da es nur eine Zelle gibt, die nicht neben einem Gang liegen darf. Es gibt jedoch 4 verschiedene 1x1 Secret-Räume, das bedeutet, dass ein bestimmter Raum nur mit ca. 14.5% Wahrscheinlichkeit generieren kann, da es hier einen 4-Seitigen Würfelwurf gibt, um zu entscheiden, welcher der 4 Räume generiert wird, wenn ein 1x1 Secret-Raum generieren kann.

Durch die spezielle Generierung in Stockwerk 3 generieren dort auch generell mehr 1x1 Secret-Räume, während es im 1. und 2. Stock deutlich weniger sind. In den unteren Stockwerken gibt es einige Positionen, die häufiger 1x1 Secret-Räume generieren als andere, da es hier bestimmte Hallway-Formen gibt, die es erst ermöglichen, dass 1x1 Secret-Räume generieren können, von denen manche häufiger sind als andere. Dadurch sind die 1x1 Secret-Räume hier auch eher im Westen, da dort tendenziell weniger Gänge generieren.

### 1x2 Secret-Räume

1x2 Secret-Räume (Clean Chest Room, Fake End Portal Room, Attic Room) sind etwas häufiger als 2x2 Secret-Räume, da sie nur eine Grundfläche von 2 Zellen haben.

Hier gibt es jedoch auch unterschiede zwischen den Stockwerken:

Der `Attic Room` kann sowohl im 2. als auch im 3. Stock generieren und ist im 3. Stock häufiger, da es hier mehr Platz für Secret-Räume gibt. Der `Attic Room` ist der häufigste 1x2 Secret-Raum mit ca. 35% Wahrscheinlichkeit (11.75% auf Stockwerk 2, 26.40% auf Stockwerk 3), da er der einzige 1x2 Secret-Raum ist, der im 2. und 3. Stock generieren kann.

Die anderen beiden 1x2 Secret-Räume (Clean Chest Room und Fake End Portal Room) können nur im 1. Stock generieren. Dazu kommt, dass sie sich diesen Stock teilen, das bedeuted, dass das Platzieren eines 1x2 Secret-Raums nochmal einen 2-Seitigen Würfelwurf erfordert, um zu entscheiden, welcher der beiden generiert wird. Dadurch sind diese beiden Räume mit ca. 6% Wahrscheinlichkeit deutlich seltener als der `Attic Room` mit 11.75% auf Stockwerk 2 (6% + 6% = 12% für einen 1x2 Secret-Raum in Stockwerk 1 bzw. 2)

### 2x2 Lava Room

Der 2x2 Lava Room ist der seltenste Secret-Raum, da er eine sehr große Grundfläche hat (4 Zellen) und es dadurch sehr unwahrscheinlich ist, dass alle 4 Zellen nicht neben einem Gang liegen. Obwohl er technisch in allen Stockwerken generieren kann, ist er auf allen Stockwerken nahezu gleich selten. Für diese Art von Secret-Raum muss es eine sehr ungünstige Hallway-Form geben, damit er generieren kann. In den untersuchten 100.000 generierten Woodland Mansions gab es ein Hallway-Muster, das zu ca. 89% auf Stockwerk 1 bzw. 2 zu einem 2x2 Lava Room geführt hat.
Diese Seltenheit liegt nicht nur an der großen Grundfläche, sondern an mehreren Faktoren, die zusammen die Generierung eines 2x2 Lava Rooms extrem unwahrscheinlich machen:

- Es werden immer zuerst 2x2 Räume neben einem Gang generiert, bevor 1x2 oder 1x1 Räume generiert werden. Das bedeutet, dass der Platz für jegliche Secret-Räume so gering gehalten wird wie möglich und vorallem für 2x2 Räume, die ja eine große Grundfläche haben, wird dadurch der Platz für Secret-Räume extrem eingeschränkt.
- Da Hallways möglichst nach Westen generieren und es am Eingang keinen Platz für 2x2 Secret Räume gibt (da hier überall Gänge sind), sind die möglichen Positionen für 2x2 Räume generell schon sehr eingeschränkt und konzentrieren sich auf die Nord-Westseite der Mansion für Stockwerk 1 und 2.

## Spezielle Hallway-Formen, die zu mehr Secret-Räumen führen

Wie bereits zuvor erklärt, gibt es gewisse Formen von Hallways, die häufiger zu Secret-Räumen führen als andere. Besonders für den 1. Stock und den 2. Stock gibt es bestimmte Hallway-Formen, die es erst möglich machen, dass Secret-Räume generiert werden können. Im Folgenden werden für die verschiedenen Secret-Raum-Typen jeweils die häufigsten 6 Hallway-Formen gezeigt, die zu diesem Secret-Raum geführt haben. Zudem wird jeweils auch die Anzahl der unterschiedlichen Hallway-Formen gezeigt, die zu diesem Secret-Raum geführt haben, um die Vielfalt der Hallway-Formen zu verdeutlichen, die zu einem bestimmten Secret-Raum führen können.

Alle Häufigkeiten und Prozent-Zahlen beziehen sich auf die 100.000 generierten Woodland Mansions.

**Legende:**

- `GRAU`: Räume oder Luft
- `ORANGE`: Gänge bzw. Hallways
- `GELB`: Eingang der Mansion

### 1x1 Secret-Räume Hallways

#### Stockwerk 1

Generierungen mit mindestens einem 1x1 Secret-Raum: 6219 / 100.000 (6.22%)

Es gab nur 159 unterschiedliche Hallway-Formen, die zu einem 1x1 Secret-Raum auf Stockwerk 1 geführt haben.

Wie man hier sieht, ist die 1. Form deutlich häufiger mit ca. 31% als andere Formen. Diese Form garantiert jedoch keine 1x1 Secret-Räume, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![1x1 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor1_1x1.png)

#### Stockwerk 2

Generierungen mit mindestens einem 1x1 Secret-Raum: 6154 / 100.000 (6.15%)

Es gab nur 157 unterschiedliche Hallway-Formen, die zu einem 1x1 Secret-Raum auf Stockwerk 2 geführt haben.

Auch hier ist die 1. Form deutlich häufiger mit ca. 30% als andere Formen, diese Form ist die gleiche wie die häufigste Form auf Stockwerk 1, da die Hallways auf Stockwerk 1 und 2 identisch sind.

![1x1 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor2_1x1.png)

#### Stockwerk 3

Generierungen mit mindestens einem 1x1 Secret-Raum: 42468 / 100.000 (42.47%)

Es gab 1803 unterschiedliche Hallway-Formen, die zu einem 1x1 Secret-Raum auf Stockwerk 3 geführt haben.

Hier gibt es keine großen Ausreißer in den Hallway-Formen, die zu einer deutlich höheren Anzahl von 1x1 Secret-Räumen führen, jedoch gibt es 2 Formen die etwas häufiger sind als andere.

![1x1 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor3_1x1.png)

### 1x2 Secret-Räume Hallways

#### Stockwerk 1

Generierungen mit mindestens einem 1x2 Secret-Raum: 11687 / 100.000 (11.69%)

Es gab nur 140 unterschiedliche Hallway-Formen, die zu einem 1x2 Secret-Raum auf Stockwerk 1 geführt haben.

Hier ist die 1. Form mit ca. 27% deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 1x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![1x2 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor1_1x2.png)

#### Stockwerk 2

Generierungen mit mindestens einem 1x2 Secret-Raum: 11754 / 100.000 (11.75%)

Es gab nur 134 unterschiedliche Hallway-Formen, die zu einem 1x2 Secret-Raum auf Stockwerk 2 geführt haben.

Hier ist die 1. Form mit ca. 26% deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 1x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![1x2 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor2_1x2.png)

#### Stockwerk 3

Generierungen mit mindestens einem 1x2 Secret-Raum: 26399 / 100.000 (26.40%)

Es gab 1651 unterschiedliche Hallway-Formen, die zu einem 1x2 Secret-Raum auf Stockwerk 3 geführt haben.

Hier gibt es keine großen Ausreißer in den Hallway-Formen, die zu einer deutlich höheren Anzahl von 1x2 Secret-Räumen führen, jedoch sind die Formen an sich auffällig, es scheint als ob eine einzige Hallway-Zelle und ein L-Förmiger Hallway-Abschnitt aus 8 Abschnitten besonders häufig zu 1x2 Secret-Räumen führen, da diese Formen mehr Platz für Secret-Räume bieten.

![1x2 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor3_1x2.png)

### 2x2 Secret-Raum (Lava Room) Hallways

#### Stockwerk 1

Generierungen mit einem 2x2 Secret-Raum: 1420 / 100.000 (1.42%)

Es gab nur 10 unterschiedliche Hallway-Formen, die zu einem 2x2 Secret-Raum auf Stockwerk 1 geführt haben.

Hier ist die 1. Form mit ca. 89% deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 2x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![2x2 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor1_2x2.png)

#### Stockwerk 2

Generierungen mit einem 2x2 Secret-Raum: 1463 / 100.000 (1.46%)

Es gab nur 13 unterschiedliche Hallway-Formen, die zu einem 2x2 Secret-Raum auf Stockwerk 2 geführt haben. 

Hier ist die Generierung ähnlich zu Stockwerk 1, die 1. Form ist mit ca. 88% deutlich häufiger als andere Formen, diese Form garantiert jedoch keinen 2x2 Secret-Raum, diese Form ist die häufigste Form insgesamt für alle Secret-Raum-Typen, da sie viel Platz für Secret-Räume bietet.

![2x2 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor2_2x2.png)

#### Stockwerk 3

Generierungen mit einem 2x2 Secret-Raum: 1395 / 100.000 (1.40%)

Es gab 85 unterschiedliche Hallway-Formen, die zu einem 2x2 Secret-Raum auf Stockwerk 3 geführt haben.

Hier sind ebenfalls keine großen Ausreißer in den Hallway-Formen, die zu einer deutlich höheren Anzahl von 2x2 Secret-Räumen führen, jedoch gibt es hier wieder einen bestimmten Hallway-Verlauf, der besonders häufig zu 2x2 Secret-Räumen führt, da er viel Platz für Secret-Räume bietet. Das ist der gleiche L-Förmige Hallway-Abschnitt aus 8 Abschnitten, der auch bei 1x2 Secret-Räumen auffällig war.

![2x2 Secret-Room Hallway Shapes](/woodland_mansion/normal_heatmaps/hallways_floor3_2x2.png)

## Detaillierte Analyse jedes Raums pro Stockwerk

### 1x1_a1 - Flower room (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 56432 / 100.000 (56.43%)
Flower-pot bench display.

![1x1_a1 - Flower room](/woodland_mansion/normal_heatmaps/1x1_a1_Flower_room.png)

### 1x1_a2 - Pumpkin ring room (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 56085 / 100.000 (56.08%)
Cobblestone ring with rails and a carved pumpkin.

![1x1_a2 - Pumpkin ring room](/woodland_mansion/normal_heatmaps/1x1_a2_Pumpkin_ring_room.png)

### 1x1_a3 - Office (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 56109 / 100.000 (56.11%)
Twin cobblestone desks with flowers and carpets.

![1x1_a3 - Office](/woodland_mansion/normal_heatmaps/1x1_a3_Office.png)

### 1x1_a4 - Checkerboard room (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 55970 / 100.000 (55.97%)
Checker floor with a hidden chest above the door.

![1x1_a4 - Checkerboard room](/woodland_mansion/normal_heatmaps/1x1_a4_Checkerboard_room.png)

### 1x1_a5 - White tulip sanctuary (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 56509 / 100.000 (56.51%)
Stone alcove with a single white tulip.

![1x1_a5 - White tulip sanctuary](/woodland_mansion/normal_heatmaps/1x1_a5_White_tulip_sanctuary.png)

### 1x1_b1 - Birch arch room (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 65611 / 100.000 (65.61%)
Office-like room with a central birch arch.

![1x1_b1 - Birch arch room](/woodland_mansion/normal_heatmaps/1x1_b1_Birch_arch_room.png)

### 1x1_b2 - Small dining room (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 65412 / 100.000 (65.41%)
Compact dining room with chimney-like walls.

![1x1_b2 - Small dining room](/woodland_mansion/normal_heatmaps/1x1_b2_Small_dining_room.png)

### 1x1_b3 - Single bed bedroom (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 65653 / 100.000 (65.65%)
Bedroom with fireplace and bonsai.

![1x1_b3 - Single bed bedroom](/woodland_mansion/normal_heatmaps/1x1_b3_Single_bed_bedroom.png)

### 1x1_b4 - Small library (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 65362 / 100.000 (65.36%)
Study room with corner bookcases.

![1x1_b4 - Small library](/woodland_mansion/normal_heatmaps/1x1_b4_Small_library.png)

### 1x1_b5 - Allium room (Normal Room)

Room type: `1x1`
Per-mansion occurrence: 65680 / 100.000 (65.68%)
Oak stand with potted alliums and a chest.

![1x1_b5 - Allium room](/woodland_mansion/normal_heatmaps/1x1_b5_Allium_room.png)

### 1x2_a1 - Gray banner room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39616 / 100.000 (39.62%)
Altar-like room with a gray banner and hidden chest.

![1x2_a1 - Gray banner room](/woodland_mansion/normal_heatmaps/1x2_a1_Gray_banner_room.png)

### 1x2_a2 - Wheat farm (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39472 / 100.000 (39.47%)
Village-style indoor wheat farm.

![1x2_a2 - Wheat farm](/woodland_mansion/normal_heatmaps/1x2_a2_Wheat_farm.png)

### 1x2_a3 - Forge room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39679 / 100.000 (39.68%)
Polished andesite forge with lava and an anvil.

![1x2_a3 - Forge room](/woodland_mansion/normal_heatmaps/1x2_a3_Forge_room.png)

### 1x2_a4 - Sapling farm (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39838 / 100.000 (39.84%)
Dark oak sapling farm with ladders.

![1x2_a4 - Sapling farm](/woodland_mansion/normal_heatmaps/1x2_a4_Sapling_farm.png)

### 1x2_a5 - Wool room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39268 / 100.000 (39.27%)
Messy stack of blue wool.

![1x2_a5 - Wool room](/woodland_mansion/normal_heatmaps/1x2_a5_Wool_room.png)

### 1x2_a6 - Tree-chopping room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39500 / 100.000 (39.50%)
Artificial tree room with a sealed entrance.

![1x2_a6 - Tree-chopping room](/woodland_mansion/normal_heatmaps/1x2_a6_Tree_chopping_room.png)

### 1x2_a7 - Mushroom farm (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39400 / 100.000 (39.40%)
Indoor mushroom farm with table and chest.

![1x2_a7 - Mushroom farm](/woodland_mansion/normal_heatmaps/1x2_a7_Mushroom_farm.png)

### 1x2_a8 - Dual-staged farm (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39717 / 100.000 (39.72%)
Two-tier farm with pumpkins and melons.

![1x2_a8 - Dual-staged farm](/woodland_mansion/normal_heatmaps/1x2_a8_Dual_staged_farm.png)

### 1x2_a9 - Small storage room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 39360 / 100.000 (39.36%)
Shelves packed with empty single chests.

![1x2_a9 - Small storage room](/woodland_mansion/normal_heatmaps/1x2_a9_Small_storage_room.png)

### 1x2_b1 - Redstone jail (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 26870 / 100.000 (26.87%)
Large jail controlled by a lever and redstone.

![1x2_b1 - Redstone jail](/woodland_mansion/normal_heatmaps/1x2_b1_Redstone_jail.png)

### 1x2_b2 - Small jail (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 26784 / 100.000 (26.78%)
Compact jail beside a desk and chair.

![1x2_b2 - Small jail](/woodland_mansion/normal_heatmaps/1x2_b2_Small_jail.png)

### 1x2_b3 - Wood arch hallway (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 26772 / 100.000 (26.77%)
Dark oak arch hall with a chest at the end.

![1x2_b3 - Wood arch hallway](/woodland_mansion/normal_heatmaps/1x2_b3_Wood_arch_hallway.png)

### 1x2_b4 - Winding stairway room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 26608 / 100.000 (26.61%)
Walled spiral stair up to a chest.

![1x2_b4 - Winding stairway room](/woodland_mansion/normal_heatmaps/1x2_b4_Winding_stairway_room.png)

### 1x2_b5 - Illager head room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 26656 / 100.000 (26.66%)
Room centered on illager pixel art.

![1x2_b5 - Illager head room](/woodland_mansion/normal_heatmaps/1x2_b5_Illager_head_room.png)

### 1x2_c1 - Medium dining room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 76337 / 100.000 (76.34%)
Dining room with chandelier and serving counter.

![1x2_c1 - Medium dining room](/woodland_mansion/normal_heatmaps/1x2_c1_Medium_dining_room.png)

### 1x2_c2 - Double bed bedroom (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 76328 / 100.000 (76.33%)
Bedroom with pink and purple beds.

![1x2_c2 - Double bed bedroom](/woodland_mansion/normal_heatmaps/1x2_c2_Double_bed_bedroom.png)

### 1x2_c3 - Triple bed bedroom (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 76363 / 100.000 (76.36%)
Three-bed bedroom with desk.

![1x2_c3 - Triple bed bedroom](/woodland_mansion/normal_heatmaps/1x2_c3_Triple_bed_bedroom.png)

### 1x2_c4 - Medium library (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 76241 / 100.000 (76.24%)
Bookcase lounge with flower-pot table.

![1x2_c4 - Medium library](/woodland_mansion/normal_heatmaps/1x2_c4_Medium_library.png)

### 1x2_c_stairs - Curved staircase (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 73523 / 100.000 (73.52%)
Curving staircase variant leading upward.

![1x2_c_stairs - Curved staircase](/woodland_mansion/normal_heatmaps/1x2_c_stairs_Curved_staircase.png)

### 1x2_d1 - Master bedroom (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 41489 / 100.000 (41.49%)
Large four-post bed and banners.

![1x2_d1 - Master bedroom](/woodland_mansion/normal_heatmaps/1x2_d1_Master_bedroom.png)

### 1x2_d2 - Bedroom with loft (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 41403 / 100.000 (41.40%)
Two-tier bedroom with ladder loft and chest.

![1x2_d2 - Bedroom with loft](/woodland_mansion/normal_heatmaps/1x2_d2_Bedroom_with_loft.png)

### 1x2_d3 - Ritual room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 41565 / 100.000 (41.57%)
Altar room with banners and hostile spawns.

![1x2_d3 - Ritual room](/woodland_mansion/normal_heatmaps/1x2_d3_Ritual_room.png)

### 1x2_d4 - Cat statue room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 41476 / 100.000 (41.48%)
Large black wool cat statue.

![1x2_d4 - Cat statue room](/woodland_mansion/normal_heatmaps/1x2_d4_Cat_statue_room.png)

### 1x2_d5 - Chicken statue room (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 41339 / 100.000 (41.34%)
Large wool chicken statue.

![1x2_d5 - Chicken statue room](/woodland_mansion/normal_heatmaps/1x2_d5_Chicken_statue_room.png)

### 1x2_d_stairs - Straight staircase (Normal Room)

Room type: `1x2`
Per-mansion occurrence: 26477 / 100.000 (26.48%)
Straight staircase variant to the third floor.

![1x2_d_stairs - Straight staircase](/woodland_mansion/normal_heatmaps/1x2_d_stairs_Straight_staircase.png)

### 2x2_a1 - Large jail (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 57479 / 100.000 (57.48%)
Four jail cells and possible allays.

![2x2_a1 - Large jail](/woodland_mansion/normal_heatmaps/2x2_a1_Large_jail.png)

### 2x2_a2 - Large storage room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 57428 / 100.000 (57.43%)
Large storeroom with many chests.

![2x2_a2 - Large storage room](/woodland_mansion/normal_heatmaps/2x2_a2_Large_storage_room.png)

### 2x2_a3 - Illager statue room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 57502 / 100.000 (57.50%)
Giant wool illager statue hiding lapis.

![2x2_a3 - Illager statue room](/woodland_mansion/normal_heatmaps/2x2_a3_Illager_statue_room.png)

### 2x2_a4 - Nature room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 57427 / 100.000 (57.43%)
Andesite water feature and artificial tree.

![2x2_a4 - Nature room](/woodland_mansion/normal_heatmaps/2x2_a4_Nature_room.png)

### 2x2_b1 - Large dining room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 62837 / 100.000 (62.84%)
Large dining hall with chandeliers.

![2x2_b1 - Large dining room](/woodland_mansion/normal_heatmaps/2x2_b1_Large_dining_room.png)

### 2x2_b2 - Conference room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 62541 / 100.000 (62.54%)
U-shaped meeting table with tulips.

![2x2_b2 - Conference room](/woodland_mansion/normal_heatmaps/2x2_b2_Conference_room.png)

### 2x2_b3 - Large library (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 62718 / 100.000 (62.72%)
Large library with armchairs.

![2x2_b3 - Large library](/woodland_mansion/normal_heatmaps/2x2_b3_Large_library.png)

### 2x2_b4 - Map room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 62396 / 100.000 (62.40%)
Large table laid out like a map.

![2x2_b4 - Map room](/woodland_mansion/normal_heatmaps/2x2_b4_Map_room.png)

### 2x2_b5 - Arena room (Normal Room)

Room type: `2x2`
Per-mansion occurrence: 62611 / 100.000 (62.61%)
Arena platform with lofted chest.

![2x2_b5 - Arena room](/woodland_mansion/normal_heatmaps/2x2_b5_Arena_room.png)

### 1x1_as1 - X room (Secret Room)

Room type: `1x1`
Per-mansion occurrence: 14542 / 100.000 (14.54%)
Secret room with cobblestone X patterns and a chest.

![1x1_as1 - X room](/woodland_mansion/normal_heatmaps/1x1_as1_X_room.png)

### 1x1_as2 - Spider room (Secret Room)

Room type: `1x1`
Per-mansion occurrence: 14646 / 100.000 (14.65%)
Secret cobweb room with a spider spawner.

![1x1_as2 - Spider room](/woodland_mansion/normal_heatmaps/1x1_as2_Spider_room.png)

### 1x1_as3 - Obsidian room (Secret Room)

Room type: `1x1`
Per-mansion occurrence: 14481 / 100.000 (14.48%)
Secret obsidian shape hiding a diamond block.

![1x1_as3 - Obsidian room](/woodland_mansion/normal_heatmaps/1x1_as3_Obsidian_room.png)

### 1x1_as4 - Birch pillar room (Secret Room)

Room type: `1x1`
Per-mansion occurrence: 14627 / 100.000 (14.63%)
Secret room with four birch plank pillars.

![1x1_as4 - Birch pillar room](/woodland_mansion/normal_heatmaps/1x1_as4_Birch_pillar_room.png)

### 1x2_s1 - Clean chest room (Secret Room)

Room type: `1x2`
Per-mansion occurrence: 6235 / 100.000 (6.24%)
First-floor secret room with one chest and four torches.

![1x2_s1 - Clean chest room](/woodland_mansion/normal_heatmaps/1x2_s1_Clean_chest_room.png)

### 1x2_s2 - Fake End portal room (Secret Room)

Room type: `1x2`
Per-mansion occurrence: 6290 / 100.000 (6.29%)
First-floor secret fake portal and trapped chest.

![1x2_s2 - Fake End portal room](/woodland_mansion/normal_heatmaps/1x2_s2_Fake_End_portal_room.png)

### 1x2_se1 - Attic room (Secret Room)

Room type: `1x2`
Per-mansion occurrence: 35075 / 100.000 (35.08%)
Upper-floor secret attic with hidden chests.

![1x2_se1 - Attic room](/woodland_mansion/normal_heatmaps/1x2_se1_Attic_room.png)

### 2x2_s1 - Lava room (Secret Room)

Room type: `2x2`
Per-mansion occurrence: 3763 / 100.000 (3.76%)
Secret lava glass case hiding a diamond block.

![2x2_s1 - Lava room](/woodland_mansion/normal_heatmaps/2x2_s1_Lava_room.png)
