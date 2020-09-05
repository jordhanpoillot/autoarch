#!/bin/sh
# Créé le 03/09/2020 par Jordhan Poillot
# Ce script permet d'automatiser la configuration d'une nouvelle installation ArchLinux

# NE PAS EXECUTER CE SCRIPT QUI EST ENCORE EN COURS DE REDACTION

clear

echo -e "
\t\tBienvenue dans le script de configuration d'ArchLinux !

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

Plusieurs questions vous serons posé, les réponses seront enregistrées temporairement,
puis à la fin toute l'installation se fera en une fois.
Vous ne serez donc pas obligé de rester devant votre écran.

Souhaitez vous continuer l'exectution de ce script ?
Tapez 1 ou 2 pour choisir.
"
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
				clear
                echo -e "\nConfiguration de votre installation ArchLinux."
                break
        elif [ "$i" = "Non" ]; then
                echo "Si vous n'êtes pas certain de ce qui est réalisé par le script, n'hésitez pas à faire la commande "cat config.sh" pour voir son contenu."
                exit
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

echo -e "\nPassage du clavier en azerty."
loadkeys fr-latin1

echo "
Souhaitez vous installer Ranger ?
Ranger est un explorateur de fichier basé sur Vim, il s'utilise dans un terminal
Si vous préférez un explorateur graphique avec utilisation de la souris, répondez non à cette étape.
Tapez 1 ou 2 pour choisir.
"
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                install_ranger="True"
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

clear
echo "
Souhaitez vous installer PCmanFM ?
PCmanFM est un explorateur de fichier avec interface graphique, il est leger tout en restant intuitif.
Tapez 1 ou 2 pour choisir.
"
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
				install_pcmanfm="True"
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

clear
echo "
Souhaitez vous installer Grub ?
Grub est un BootLoader, il permet de détecter quel système d'exploitation utiliser quand vous démarrez votre ordinateur.
Si vous ne savez pas configurer un BootLoader, validez cette étape. Sinon vous savez quoi faire.
Tapez 1 ou 2 pour choisir.
"
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
                install_grub="True"
                fdisk -l
                echo -e "\nVotre disque contenant ArchLinux est-il bien sur /dev/sda ?"
                echo "Ca devrait être le cas si vous n'avez qu'un disque et que vous installer l'OS depuis une clef USB."
                echo "Cette étape va écrire les informations de boot sur la partition."
                echo "Si vous n'êtes pas certain de ce que vous faites, ou s'il s'agit du bon périphérique, répondez non pour le moment."
                echo "Vous pourrez executer la commande grub-install après le script. (ex: grub-install /dev/sda)"
                echo "S'éxecute sur le périphérique et non la partition : /dev/sda OK, /dev/sda1 NON."
                echo "En cas de doute, cherchez sur internet comment utiliser la commande grub-install"
                echo "Valider l'écriture du grub sur /dev/sda ?"
                select i in Oui Non; do
                      if [ "$i" = "Oui" ]; then
					  		install_grub_sda="True"
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

clear
echo "
Souhaitez vous installer Gnome ?
Gnome est un des display manager les plus connu grace à son integration dans la distribution Ubuntu.
C'est lui qui gère toute l'interface graphique du système, la gestion des fenêtres, les menus...
Il n'est pas le plus leger, mais est intuitif et simple à utiliser.
Si vous êtes un utilisateur confirmé, répondez non (prenez lightdm par exemple), sinon répondez oui.
Tapez 1 ou 2 pour choisir.
"
select i in Oui Non; do
        if [ "$i" = "Oui" ]; then
				install_gnome="True"
                break
        elif [ "$i" = "Non" ]; then
                break
        else
                echo "Réponse invalide, tapez 1 ou 2."
        fi
done

if [[ $install_pcmanfm = "True" ]];then
	yes|pacman -Scc pcmanfm
fi

if [[ $install_grub = "True" ]];then
    yes|pacman -Scc grub
fi

if [[ $install_grub_sda = "True" ]];then
    grub-install /dev/sda
fi

if [[ $install_ranger = "True" ]];then
    yes|pacman -Scc ranger
fi

if [[ $install_gnome = "True" ]];then
    yes|pacman -Scc gnome
fi

# Installation des principaux paquets
yes|pacman -Scc vim sudo dhcp networkmanager

# Installation des paquets secondaires
yes|pacman -Scc htop mlocate tree git wget
