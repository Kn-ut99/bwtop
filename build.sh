#!/usr/bin/env bash
# Compile bwtop en binaire autonome (aucun Python requis sur la machine cible).
# A lancer sur une machine de meme architecture / glibc (ou plus ancienne) que la cible.
set -euo pipefail
cd "$(dirname "$0")"

python3 -m venv .build-venv
. .build-venv/bin/activate
pip install --quiet pyinstaller

cp bwtop bwtop_build.py
pyinstaller --onefile --name bwtop --strip bwtop_build.py
rm -f bwtop_build.py

echo
echo "Binaire : $(pwd)/dist/bwtop"
echo "Installation : sudo install -m 0755 dist/bwtop /usr/local/bin/bwtop"
# Alternative (binaire C natif, plus rapide au demarrage) :
#   pip install nuitka && python3 -m nuitka --onefile -o bwtop-native bwtop
