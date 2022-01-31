#!/usr/bin/env bash

NIX_PYTHON_VERSION="python38"
REQUIREMENTS="requirements.txt"
SKELETON="skeleton.nix"
FILE="shell.nix"

if test -f "$FILE"; then
    printf '%s\n\n' "File \"${FILE}\" already exists."
else
    cp $SKELETON $FILE
fi

line_number=$(($(grep -rn "nativeBuildInputs = with pkgs; \[" $FILE | cut -d: -f 2) + 1))

if ! grep -q "${NIX_PYTHON_VERSION}" "${FILE}"; then
    gsed -i "${line_number}i ${NIX_PYTHON_VERSION}" $FILE
    line_number=$((line_number + 1))
fi

while IFS= read -r line; do
    insert="${NIX_PYTHON_VERSION}Packages.$(echo "${line}" | cut -d "=" -f1 | cut -d ">" -f1)"
    if ! grep -q "${insert}" "${FILE}"; then
        gsed -i "${line_number}i ${insert}" $FILE
    fi
    line_number=$((line_number + 1))
done < ${REQUIREMENTS}

printf '%s\n\n' "Populated file \"${FILE}\":"
if command -v "bat" > /dev/null; then
    bat -Pp ${FILE}
else
    cat ${FILE}
fi
