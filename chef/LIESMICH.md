Java-Beispiel mit Chef
=============================

[English / Englisch](README.md)

Dieses Beispiel zeigt, wie Chef genutzt werden kann, um eine
Java-Umgebung zu konfigurieren.

Die Anwendung findet sich im Verzeichnis `cookbooks/webapp/files/default` .

In der Datei `roles/tomcatserver.json` ist konfiguriert, welche Rezpte
in ablaufen sollen und wie sie konfiguriert sind. Die Cookbooks stammen
aus dem Opscode Open Source Repository.

## Vagrant

Das Vagrantfile kann genutzt werden, um eine Java-Anwendung in einer
virtuellen Maschine zu installieren. Diese virtuelle Maschine wird von
VirtualBox verwaltet. Siehe http://vagrantup.com/  Um die Anwendung zu
starten muss nur `vagrant up` genutzt werden.

Die Anwendung steht unter http://localhost:18080/demo/ bereit.

## Chef Solo on Ubuntu 16.04

Die Anwendung kann auch auf einem System mit Chef Solo installiert
werden. Das funktioniert auf Ubuntu 16.04

* Installiere Chef `sudo apt-get install chef`

* Installiere die Versionsverwaltung git mit `sudo apt-get install git-core`

* Hole das Github-Repository mit dem Befehl `git clone
  https://github.com/ewolff/user-registration-V2.git`

* Passe solo.rb im Verzeichnis chef an: In der ersten Zeile ist die
Variable root definiert. Sie muss das Verzeichnis enthalten, in dem
das chef-Verzeichnis dieses Git-Repository zur Verfügung steht.

* Starte die Installation mit `sudo chef-solo -j node.json -c solo.rb`

## Amazon EC2

Das Verzeichnis `.chef` enthält ein einfaches `knife.rb`, das
angepasst werden muss, um es mit knife zu nutzen und die Anwendung
dann in der Amazon-EC2-Cloud zu installieren. Anweisungen sind in dem File.

Um es zu benutzen:
* Installiere Knife - siehe https://downloads.chef.io/chef-dk/ ,
* Installiere das EC2-PlugIn - siehe dazu
  https://github.com/chef/knife-ec2#installation
* Lade die Cookbooks mit `knife cookbook upload –a` hoch
* Lade die Rolle mit `knife role from file roles/tomcatserver.json` hoch
* Jetzt kannst Du mit  `knife ec2 server create -r
  'role[tomcatserver]' --identity-file ~/.ssh/<schluessel>.pem`
  einen neuen Server installieren



