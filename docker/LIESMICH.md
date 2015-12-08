Beispiel mit Docker
==============

Dieses Projekt erzeugt eine VM mit der Anwendung in einem
Docker-Container. 

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
- Die Anwendung steht unter http://localhost:8090/ zur Verfügung.

#Docker Machine

Docker Machine kann virtuelle Machine erstellen, auf denen dann Docker
Container laufen können.

Um das Beispiel ablaufen zu lassen:

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
- Führe im dem Verzeichnis, das auch das LIESMICH.md enthält, folgende
Kommandos aus:
  - `docker build --tag=java java`
  - `docker build --tag=user-registration user-registration`
  - `docker run -p 8080:8080 -d user-registration`

Das Ergebnis:

- Find mit `docker-machine ip dev`die IP address der virtuellen
Maschine
- Dort steht unter Port 8080 die Anwendung bereit.
- Nutze `docker-machine rm dev`, um die virtuelle Maschine wieder zu zerstören.
