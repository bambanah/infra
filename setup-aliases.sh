#!/bin/bash

aliasFileLoc="$HOME/.aliases"
declare -A aliases=(
    ["a"]="ansible"
    ["ap"]="ansible-playbook"
    ["ag"]="ansible-galaxy"
    ["al"]="ansible-lint"
    ["av"]="ansible-vault"
)

if [ ! -f $aliasFileLoc ]; then
    touch $aliasFileLoc
fi

for alias in "${!aliases[@]}"; do
    grep -q "^alias $alias=" "$aliasFileLoc" && sed -i "s/^alias $alias=.*/alias $alias=\"${aliases[$alias]}\"/" "$aliasFileLoc" || echo "alias $alias=\"${aliases[$alias]}\"" >> "$aliasFileLoc"
done

# Text formatting
NORMAL=$(tput sgr0)
BOLD=$(tput bold)

MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)

# Success Message
printf "Aliases appended to ${MAGENTA}${BRIGHT}$aliasFileLoc${NORMAL}:\n\n"
for alias in "${!aliases[@]}"; do printf "\t${CYAN}${BOLD}$alias${NORMAL}: ${aliases[$alias]}\n"; done
printf "\nYou will need to reload your shell to be able to use them (${RED}source ~/.zshrc${NORMAL})\n"
