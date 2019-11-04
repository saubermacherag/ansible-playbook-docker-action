#!/bin/sh

# Evaluate keyfile
export KEYFILE=
if [ -z "$INPUT_KEYFILE" ]
then
  echo "\$INPUT_KEYFILE not set. You'll most probably only be able to work on localhost."
else
  echo "\$INPUT_KEYFILE is set. Will use $INPUT_KEYFILE as ssh keyfile for host connections."
  export KEYFILE="--key-file ${INPUT_KEYFILE}"
fi

# Evaluate verbosity
export VERBOSITY=
if [ -z "$INPUT_VERBOSITY" ]
then
  echo "\$INPUT_VERBOSITY not set. Will use standard verbosity."
else
  echo "\$INPUT_VERBOSITY is set. Will use verbosity level $INPUT_VERBOSITY."
  export VERBOSITY="-$INPUT_VERBOSITY"
fi

# Evaluate inventory file
export INVENTORY=
if [ -z "$INPUT_INVENTORYFILE" ]
then
  echo "\$INPUT_INVENTORYFILE not set. Won't use any inventory option at playbook call."
else
  echo "\$INPUT_INVENTORYFILE is set. Will use ${INPUT_INVENTORYFILE} as inventory file."
  export INVENTORY="-i ${INPUT_INVENTORYFILE}"
fi

# Evaluate requirements.
export REQUIREMENTS=
if [ -z "$INPUT_REQUIREMENTSFILE" ]
then
  echo "\$INPUT_REQUIREMENTSFILE not set. Won't install any additional external roles."
else
  export ROLES_PATH=
  if [ -z "$INPUT_ROLESPATH" ]
  then
    echo "\$INPUT_ROLESPATH not set. Will install roles in standard path."
  else
    echo "\$INPUT_ROLESPATH is set. Will install roles to ${INPUT_ROLESPATH}."
    export ROLES_PATH=$INPUT_ROLESPATH
  fi 
  echo "\$INPUT_REQUIREMENTSFILE is set. Will use ${INPUT_REQUIREMENTSFILE} to install external roles."
  ansible-galaxy install --force \
    --roles-path ${ROLES_PATH} \
    -r ${INPUT_REQUIREMENTSFILE} \
    ${VERBOSITY}
fi

# Evaluate extra vars file
export EXTRAFILE=
if [ -z "$INPUT_EXTRAFILE" ]
then
  echo "\$INPUT_EXTRAFILE not set. Won't inject any extra vars file."
else
  echo "\$INPUT_EXTRAFILE is set. Will inject $INPUT_EXTRAFILE as extra vars file."
  export EXTRAFILE="--extra-vars @${INPUT_EXTRAFILE}"
fi

echo "going to execute: "
echo "ansible-playbook ${INPUT_PLAYBOOKNAME} ${INVENTORY} ${KEYFILE} ${EXTRAFILE} ${VERBOSITY}"
 ansible-playbook ${INPUT_PLAYBOOKNAME} ${INVENTORY} ${KEYFILE} ${EXTRAFILE} ${VERBOSITY}