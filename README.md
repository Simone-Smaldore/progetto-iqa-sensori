# iqa-sensori 


1) Generare a partire dal notebook genera dataset da csv il dataset con le immagini alle varie profondità (Il dataset con i csv non è sotto controllo di versione)

2) Eseguire lo script Estrazione features palmprint/generaTemplate_LopreteSpera.m passando come cartella il dataset appena generato. In questo modo si ottengono i template che verranno utilizzati per l'identificazione del soggetto

N.B Potrebbe rompersi perché Matlab ha bisogno dell'installazione di un paio di toolbox per farlo funzionare in maniera corretta

3) Copiare la cartella templateGenerati nella cartella Utilità python

4) Eseguire il notebook genera_verifica_da_template per creare una cartella con tutti i file .dat in un formato accettabile dal codice Matlab da eseguire successivamente. Si ottiene così una cartella TemplateVerifica/datiAcquisizioni con all'interno tutte le acquisizioni per cui va calcolato lo score

5) Eseguire lo script Verifica/identificazioneMatching3D per calcolare lo score di confronto tra le varie acquisizioni. Prima di eseguire si va ad assegnare il tipo di analisi. Per cominciare lasciamo sempre 2D. Una volta eseguito si va prima di tutto a selezionare la cartella appena creata TemplateVerifica e poi si da il nome ad un file .mat che non usiamo. Noi andiamo ad usare un file csv salvato in tabellaScore.csv. Questo file ci serve per la generazione delle pseudo-label. 

ATTENZIONE: Il tempo di esecuzione di questo script cresce in maniera esponenziale all'aumentare dei confronti da effettuare 

6) IN CORSO -- Generare le pseudo label nel notebook genera-pseudo-labels
