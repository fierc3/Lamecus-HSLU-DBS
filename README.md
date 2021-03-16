# Lamecus-HSLU-DBS
Datebasesystem Project for HSLU Module DBS.


A software which predicts the result of a tennis tournament based on the results of the last 5 years.

Technologies   
DB: mysql  
Languages: tbd 


*******************************************************************************************************************************************

Datenbankmangement Doc

Wir nutzen die Daten, um eine Prognose zu machen, welcher Tennis Spieler ein gewisses ATP Turnier, egal ob real oder nicht, gewinnen würde.
Der Nutzen daraus kann verschieden sein, man kann es für Wetten verwenden, für TV-Programme, Spiel Simulationen, Video Spiele und weiteres.
Die Datenbank wird verwendet, um die vielen Daten zu persistieren und zu verwalten. Ohne die Datenbank könnten wir nicht effizient die Informationen verarbeiten für ein sinnvolles Resultat.

Die Daten basieren auf vergangene ATP Matches.
Zielgruppe: Webseiten, Wettbüros, Videospiel Entwickler, Fernsehsender, ATP.
Zugriff: Die Endnutzer bekommen die Daten über eine REST-Schnittstelle. Die Administratoren bekommen zugriffen über MySql Workbench.

Sicherheit:
-	Da es nicht um klassifizierte Daten handelt, müssen wir uns nur auf die Integrität, Konsistenz und Verfügbarkeit fokussieren.
-	Um die Integrität zu gewährleisten, dürfen nur Administratoren Datensätze ändern. Über die REST-Schnittstelle können die Daten nicht manipuliert werden.
-	Um sicherzustellen das wir die Daten nicht verlieren, führen wir Backups der Daten durch.
Technologie: Wir verwenden MYSQL, da dieses Modul auf MYSQL basiert und wir gerne unser Wissen über MYSQL vertiefen möchten.
Daten Migration: Die öffentlich zur Verfügung stehenden Daten werden mittels einem CSV-Import importiert. Das CSV kommt von https://data.world/tylerudite/atp-match-data.
Funktionalitäten: Unser Projekt hat folgende 2 Funktionalitäten: 
-	Resultate von vergangen Turniere auszugeben.
-	Prognosen über zukünftige oder „fantasy“ Turniere zu geben

Dies gibt folgenden Input und Output:
Userinput => Vergangenes Turnier oder Turnier mit allen Teilnehmner und anderen Turnier Merkmalen.
Output => Turnierresultat in form eines JSON.
