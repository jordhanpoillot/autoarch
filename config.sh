#!/bin/sh
# Créé le 03/09/2020 par Jordhan Poillot
# Ce script permet d'automatiser la configuration d'une nouvelle installation ArchLinux

# NE PAS EXECUTER CE SCRIPT QUI EST ENCORE EN COURS DE REDACTION

echo ***
Ce script va installer les paquets suivants :
  - vim
  - sudo
  - dhcp
  - networkmanager + configuration automatique de la partie réseau
  - htop
  - mlocate
  - tree
  - git
  - wget

Vous aurez ensuite le choix pour l'installation des paquets suivants :
  - Ranger
  - PCmanFM
  - Grub
  - Gnome
    
Votre clavier passera en azerty si ce n'est pas déjà fait.

Il vous sera également proposé de créer un utilisateur, et de lui donner les droits root.

Après toute ces étapes, votre ArchLinux sera totalement fonctionnel.
***

echo "Souhaitez vous continuer l'exectution de ce script ?"
echo "Tapez 1 ou 2 pour choisir."
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                echo "Configuration de votre installation ArchLinux."
                break
        elif [ "$i" = "Non" ]; then
                echo "Si vous n'êtes pas certain de ce qui est réalisé par le script, n'hésitez pas à faire la commande "cat config.sh" pour voir son contenu."
                exit
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

echo "Passage du clavier en azerty."
loadkeys fr-latin1

echo "Souhaitez vous installer Ranger ?"
echo "Ranger est un explorateur de fichier basé sur Vim, il s'utilise dans un terminal"
echo "Si vous préférez un explorateur graphique avec utilisation de la souris, répondez non à cette étape."
echo "Tapez 1 ou 2 pour choisir."
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                yes|pacman -Scc ranger
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

echo "Souhaitez vous installer PCmanFM ?"
echo "PCmanFM est un explorateur de fichier avec interface graphique, il est leger tout en restant intuitif."
echo "Tapez 1 ou 2 pour choisir."
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                yes|pacman -Scc pcmanfm
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

echo "Souhaitez vous installer Grub ?"
echo "Grub est un BootLoader, il permet de détecter quel système d'exploitation utiliser quand vous démarrez votre ordinateur."
echo "Si vous ne savez pas configurer un BootLoader, validez cette étape. Sinon vous savez quoi faire."
echo "Tapez 1 ou 2 pour choisir."
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                yes|pacman -Scc grub
                fdisk -l
                echo "Votre disque contenant ArchLinux est-il bien sur /dev/sda ?"
                echo "Ca devrait être le cas si vous n'avez qu'un disque et que vous installer l'OS depuis une clef USB."
                echo "Cette étape va écrire les informations de boot sur la partition."
                echo "Si vous n'êtes pas certain de ce que vous faites, ou s'il s'agit du bon périphérique, répondez non pour le moment."
                echo "Vous pourrez executer la commande grub-install après le script. (ex: grub-install /dev/sda)"
                echo "S'éxecute sur le périphérique et non la partition : /dev/sda OK, /dev/sda1 NON."
                echo "En cas de doute, cherchez sur internet comment utiliser la commande grub-install"
                echo "Valider l'écriture du grub sur /dev/sda ?"
                select i in Oui Non; do
                      if [ "$i" = "Oui" ]; then
                            grub-install /dev/sda
                            break
                      elif [ "$i" = "Non" ]; then
                            break
                      else
                            echo "Réponse invalide, tapez 1 ou 2."
                      fi
                done 
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

echo "Souhaitez vous installer Gnome ?"
echo "Gnome est un des display manager les plus connu grace à son integration dans la distribution Ubuntu."
echo "C'est lui qui gère toute l'interface graphique du système, la gestion des fenêtres, les menus..."
echo "Il n'est pas le plus leger, mais est intuitif et simple à utiliser."
echo "Si vous êtes un utilisateur confirmé, répondez non (prenez lightdm par exemple), sinon répondez oui."
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                yes|pacman -Scc gnome
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

# Installation des principaux paquets
yes|pacman -Scc vim sudo dhcp networkmanager

# Installation des paquets secondaires
yes|pacman -Scc htop mlocate tree git wget
