Graphite für Monitoring
===============

[German / Deutsch](LIESMICH.md) 

Dieses Projekt erzeugt eine VM mit der Anwendung in einem
Docker-Container und einen weiteren Docker-Container für
Graphite. Graphite kann als Monitoring-Werkzeug für die Anwendung
genutzt werden.

#Vagrant

Vagrant startet eine VM, installiert Docker und startet dann die
Docker Container in der VM.

Zum Ausführen:

- Installiere Vagrant, siehe
  http://docs.vagrantup.com/v2/installation/index.html
- Installiere Virtual Box von https://www.virtualbox.org/wiki/Downloads
- Gehe zum übergeordneten Verzeichnis und führe dort `mvn install` aus
- Wechsel zum Verzeichnis mit diesem Liesmich.md und führe `vagrant
   up` aus.

Das Ergebnis:

- Eine VirtualBox VM wird von Vagrant gestartet
- Docker wird in der VM gestartet
- Die Anwendung steht unter http://localhost:8083/ zur Verfügung.
- Graphite steht unter http://localhost:8082/ zur Verfügung.
- Graphites Port, um Daten an Graphite zu übergeben, steht als Port
  2003 ebenfalls zur Verfügung.

#Docker Machine

Docker Machine kann virtuelle Machine erstellen, auf denen dann Docker
Container laufen können.

Um das Beispiel ablaufen zu lassen:

- Installiere Docker Compose, siehe
https://docs.docker.com/compose/#installation-and-set-up
- Installiere Docker Machine, siehe
https://docs.docker.com/machine/#installation
- Installiere Docker, see https://docs.docker.com/installation/
- Installiere Virtual Box von https://www.virtualbox.org/wiki/Downloads
- Führe `docker-machine create  --virtualbox-memory "4096" --driver
  virtualbox dev` aus. Das erzeugt eine neue Umgebung names`dev`mit Docker
  Machine. Es wird eine virtuelle Machine in Virtual Box mit 4GB RAM sein.
 - Führe `eval "$(docker-machine env dev)"` (Linux / Mac OS X) oder
    `docker-machine.exe env --shell powershell dev` (Windows,
    Powershell) /  `docker-machine.exe env --shell cmd dev` (Windows,
    cmd.exe) aus. Das docker Kommando nutzt nun die neue virtuelle Maschine als Umgebung.
- Führe im dem Verzeichnis, das auch das LIESMICH.md enthält, `docker-compose
  build` gefolgt von `docker-compose up -d` aus.

Das Ergebnis:

- Find mit `docker-machine ip dev`die IP address der virtuellen
Maschine
- Dort steht unter Port 8083 die Anwendung bereit.
- Graphite steht unter Port 808e die Anwendung bereit.
- Der Port zur Ablage von Daten in Graphite ist 2023.
- Nutze `docker-machine rm dev`, um die virtuelle Maschine wieder zu zerstören.
