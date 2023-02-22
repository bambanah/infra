#!/bin/bash

declare -A aliases=(
    ["pb"]="ansible-playbook"
    ["pb-media"]="ansible-playbook media.yml"
    ["pb-pihole"]="ansible-playbook pihole.yml"
)

aliasFileLoc="$HOME/.aliases"

if [ ! -f $HOME/.aliases ]; then
    touch $HOME/.aliases
fi

for alias in "${!aliases[@]}"; do
    grep -q "^$alias=" "$aliasFileLoc" && sed -i "s/^alias $alias=.*/$alias=${aliases[$alias]}/" "$aliasFileLoc" || echo "alias $alias=${aliases[$alias]}" >> "$aliasFileLoc"
done

NORMAL=$(tput sgr0)
BOLD=$(tput bold)

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

printf "Aliases appended to ${MAGENTA}${BRIGHT}$aliasFileLoc${NORMAL}:\n\n"
for alias in "${!aliases[@]}"; do printf "\t${CYAN}${BOLD}$alias${NORMAL}: ${aliases[$alias]}\n"; done
printf "\nYou will need to reload your shell to be able to use them (${RED}source ~/.zshrc${NORMAL})\n"
