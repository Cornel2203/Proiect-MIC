# README: Sistem de Alocare Parcare

Aceasta diagramă descrie procesul de funcționare al unui sistem de alocare automată a parcărilor, bazat pe introducerea unui număr de înmatriculare și diverse condiții. Sistemul este structurat astfel:

---

## 1. Introducerea numărului de înmatriculare
Utilizatorul începe procesul prin introducerea numărului de înmatriculare al vehiculului. În funcție de validitatea acestuia:

- **Număr valid:** Se trece la pasul următor, "Selectarea zonei."
- **Număr invalid:** Sistemul afișează mesajul "Număr incorect" și utilizatorul este redirecționat înapoi la început pentru a reintroduce numărul corect.

---

## 2. Selectarea zonei de parcare

După validarea numărului, utilizatorul selectează zona de parcare dorită. Există trei zone disponibile:

- **Z0**: Zonă prioritară.
- **Z1**: Zonă secundară.
- **Z2**: Zonă terțiară.

După selectarea zonei:
- Sistemul permite trecerea către detaliile timpului de parcare.
- Utilizatorul poate opta să se întoarcă la pasul anterior folosind opțiunea "Înapoi."

---

## 3. Alegerea timpului de parcare

Pentru fiecare zonă selectată, utilizatorul alege durata de parcare dorită:

- **1H** (1 oră)
- **2H** (2 ore)
- **24H** (24 ore)

După selecție, sistemul:
- Afișează suma de plată corespunzătoare în funcție de zonă și timp.
- Confirmă detaliile alese și trece la pasul final, "Plata acceptată."

---

## 4. Afișarea sumei de plată

În funcție de zona și durata selectată, sistemul afișează suma care trebuie plătită de utilizator:

- **Exemple:**
  - Zona Z0, 1 oră: "Se afișează suma de plată(Z0, 1H)."
  - Zona Z2, 24 ore: "Se afișează suma de plată(Z2, 24H)."

Utilizatorul este direcționat către pasul final pentru confirmarea plății.

---

## 5. Confirmarea plății

După afișarea sumei, utilizatorul efectuează plata. Dacă aceasta este reușită, sistemul afișează mesajul "Plata acceptată," iar parcarea este rezervată pentru durata selectată.

---

## Funcții adiționale

- **Opțiunea Înapoi:**
  - La fiecare pas, utilizatorul poate reveni la pasul anterior pentru a corecta selecțiile.

- **Mesaje de eroare:**
  - În cazul unui număr de înmatriculare invalid, sistemul returnează utilizatorul la introducerea numărului.

---

## Concluzie
Această diagramă ilustrează clar fluxul procesului de verificare, selecție și plată într-un sistem de parcare. Este conceput pentru a ghida utilizatorii într-un mod simplu și eficient, asigurând atât validarea corectă a informațiilor, cât și flexibilitatea în selecție.

