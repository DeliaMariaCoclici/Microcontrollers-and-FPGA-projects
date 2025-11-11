# 🔧 Procesor MIPS 32 Single-Cycle în VHDL

## 📘 Descriere generală
Acest proiect implementează un procesor MIPS pe 32 de biți, arhitectură single-cycle, folosind limbajul VHDL. Include toate componentele principale necesare funcționării procesorului și interfața cu periferice precum LED-uri și display cu 7 segmente.

## ⚙️ Structura proiectului
- `test_env.vhdl` – Mediu de testare integrat.
- `IFetch.vhdl` – Modulul de preluare instrucțiuni.
- `ID.vhdl` – Decodificatorul și registrul de date.
- `UC.vhdl` – Unitatea de control.
- `EX.vhdl` – Modulul de execuție ALU.
- `MEM.vhdl` – Modulul de memorie.
- `MPG.vhdl` – Generator de semnal pentru puls.
- `SSD.vhdl` – Modulul pentru afișaj cu 7 segmente.

## 🧠 Funcționalități
- Implementare completă a unui procesor MIPS single-cycle.
- Suport instrucțiuni R, I și J.
- Control salturi și ramuri condiționate.
- Interfață cu LED-uri și display 7 segmente.
- Control prin butoane și switch-uri.

##🧪 Detalii tehnice
- Mediu de dezvoltare VHDL: Vivado.
- Placă FPGA compatibilă cu VHDL.
- Cunoștințe de arhitectură calculatoare și VHDL.

