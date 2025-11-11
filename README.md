# 🔧 Procesor MIPS 32 Pipelined în VHDL

## 📘 Descriere generală
Acest proiect implementează un procesor MIPS simplificat, pipelined, utilizând limbajul de descriere hardware VHDL.

## ⚙️ Structura proiectului
- `test_env.vhdl` – Mediu de testare integrat.  
- `IFetch.vhdl` – Modulul de preluare instrucțiuni (IF).  
- `ID.vhdl` – Decodificatorul și registrul de date (ID).  
- `UC.vhdl` – Unitatea de control.  
- `EX.vhdl` – Modulul de execuție ALU (EX).  
- `MEM.vhdl` – Modulul de acces memorie (MEM).  
- `WB.vhdl` – Modulul de scriere în registru (WB).  
- `PipelineRegs.vhdl` – Registre pipeline între etape.  
- `MPG.vhdl` – Generator de semnal pentru puls.  
- `SSD.vhdl` – Modulul pentru afișaj cu 7 segmente.  

## 🧠 Funcționalități
- Implementare completă a unui procesor MIPS pipelined pe 5 etape (IF, ID, EX, MEM, WB).  
- Suport instrucțiuni R, I și J.  
- Gestionare hazarduri și control de salturi (branch prediction simplificat).  
- Interfață cu LED-uri și display 7 segmente.  
- Control prin butoane și switch-uri.  
 
## 🧪 Detalii tehnice
- Mediu de dezvoltare VHDL: Vivado.  
- Placă FPGA compatibilă cu VHDL.  
- Necesită cunoștințe de arhitectură calculatoare și design pipelined.  
