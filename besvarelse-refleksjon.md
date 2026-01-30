# Besvarelse av refleksjonsspørsmål - DATA1500 Oppgavesett 1.3

Skriv dine svar på refleksjonsspørsmålene fra hver oppgave her.

---

## Oppgave 1: Docker-oppsett og PostgreSQL-tilkobling

### Spørsmål 1: Hva er fordelen med å bruke Docker i stedet for å installere PostgreSQL direkte på maskinen?

**Ditt svar:**

Docker gjør jobbing med databasen mer konsistent, slik at mange kan jobbe med det samme med samme konfigurering og versjon, uavhengig av OS eller maskin. Det gjør at situasjoner hvor noe "funker for andre, men ikke for meg" ikke lenger er et problem.

I tillegg kan man kjøre mange containers i en enkel server fordi de krever ikke mye.
(kilde: https://youtu.be/s69slvfVp0I?t=197)

---

### Spørsmål 2: Hva betyr "persistent volum" i docker-compose.yml? Hvorfor er det viktig?

**Ditt svar:**

Persistent volum er en måte å fortsatt ha data uansett hva som skjer med containeren. Så hvis du sletter containeren du mister ikke dataen.

---

### Spørsmål 3: Hva skjer når du kjører `docker-compose down`? Mister du dataene?

**Ditt svar:**

docker-compose down stopper og sletter alle containers, nettverk, volumer og images som er lagd av docker-compose up. volumer som er eksterne dvs. persistent volum mistes ikke.
(kilde så jeg ikke glemmer: https://docs.docker.com/reference/cli/docker/compose/down/)

---

### Spørsmål 4: Forklar hva som skjer når du kjører `docker-compose up -d` første gang vs. andre gang.

**Ditt svar:**

-d gjør at docker compose up kjøres i bakgrunnen

Første gang bygger, starter eller restarter, lager og kobler terminalen til containers.

Andre gang ser om det er allerede finnes containere, og hvis det gjør så ser den om image eller service er oppdatert. Hvis en eller begge er oppdaterte, slettes containeren fra før og det lages en ny en, som i den første gangen. Dette er raskere siden det gjenbruker images eller containers med mindre image eller services har blitt oppdatert.

---

### Spørsmål 5: Hvordan ville du delt docker-compose.yml-filen med en annen student? Hvilke sikkerhetshensyn må du ta?

**Ditt svar:**

Er ikke sikker. Hovedsakelig ville jeg brukt en github repo eller Docker Hub

---

## Oppgave 2: SQL-spørringer og databaseskjema

### Spørsmål 1: Hva er forskjellen mellom INNER JOIN og LEFT JOIN? Når bruker du hver av dem?

**Ditt svar:**

INNER JOIN velger poster som har samme verdier i to tabeller
LEFT JOIN velger alle poster fra den første tabellen og poster som har samme verdi som andre tabell
Hvis man har en butikk og ser alle kunder, så kan du se om de er medlemmer av butikken din eller om de har kjøpt noe.

---

### Spørsmål 2: Hvorfor bruker vi fremmednøkler? Hva skjer hvis du prøver å slette et program som har studenter?

**Ditt svar:**

Vi bruker fremmednøkler for å referere til den verdien i en anne post i en annen blokk, så hvis du endrer i den posten f.eks epost til en kunde så skal alt som bruker den eposten kunne referere til den nye eposten. 

---

### Spørsmål 3: Forklar hva `GROUP BY` gjør og hvorfor det er nødvendig når du bruker aggregatfunksjoner.

**Ditt svar:**

GROUP BY grupperer poster slik at man kan se hvor mange av en id det finnes. Litt bedre å forklare med et eksempel: La oss si du er en butikk som selger til alle land, så vil du se hvor mange fra et land som kjøper varene dine. Da bruker man GROUP BY, som samler rader som har samme verdi i en valgt kolonne. Det er nødvendig for å holde orden.

---

### Spørsmål 4: Hva er en indeks og hvorfor er den viktig for ytelse?

**Ditt svar:**

En indeks er som en innholdsfortegnelse i en bok. Databasen bruker en indeks for å finne rader raskere, og indeksen er knyttet til en eller flere kolonner, som navn, id, epost, eller dato.

---

### Spørsmål 5: Hvordan ville du optimalisert en spørring som er veldig treg?

**Ditt svar:**

[Skriv ditt svar her]

---

## Oppgave 3: Brukeradministrasjon og GRANT

### Spørsmål 1: Hva er prinsippet om minste rettighet? Hvorfor er det viktig?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 2: Hva er forskjellen mellom en bruker og en rolle i PostgreSQL?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 3: Hvorfor er det bedre å bruke roller enn å gi rettigheter direkte til brukere?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 4: Hva skjer hvis du gir en bruker `DROP` rettighet? Hvilke sikkerhetsproblemer kan det skape?

**Ditt svar:**

[Skriv ditt svar her]

---

### Spørsmål 5: Hvordan ville du implementert at en student bare kan se sine egne karakterer, ikke andres?

**Ditt svar:**

[Skriv ditt svar her]

---

## Notater og observasjoner

Bruk denne delen til å dokumentere interessante funn, problemer du møtte, eller andre observasjoner:

[Skriv dine notater her]


## Oppgave 4: Brukeradministrasjon og GRANT

1. **Hva er Row-Level Security og hvorfor er det viktig?**
   - Svar her...

2. **Hva er forskjellen mellom RLS og kolonnebegrenset tilgang?**
   - Svar her...

3. **Hvordan ville du implementert at en student bare kan se karakterer for sitt eget program?**
   - Svar her...

4. **Hva er sikkerhetsproblemene ved å bruke views i stedet for RLS?**
   - Svar her...

5. **Hvordan ville du testet at RLS-policyer fungerer korrekt?**
   - Svar her...

---

## Referanser

- PostgreSQL dokumentasjon: https://www.postgresql.org/docs/
- Docker dokumentasjon: https://docs.docker.com/

