#!/usr/bin/env zsh

#####################
# commons
#####################
autoload colors is-at-least

#########################
# constant
#########################
bold="bold"
none="none"

#########################
# plugin main
#########################

[[ -z "$TFSWITCH_HOME" ]] && export TFSWITCH_HOME="$HOME/.tfswitch/"

ZSH_TFSWITCH_VERSION_FILE=${TFSWITCH_HOME}/version.txt

#########################
# Functions
#########################

_zsh_tfswitch_log() {
    local font=$1
    local color=$2
    local msg=$3

    if [ $font = $BOLD ]
    then
        echo $fg_bold[$color] "[zsh-tfswitch-plugin] $msg" $reset_color
    else
        echo $fg[$color] "[zsh-tfswitch-plugin] $msg" $reset_color
    fi
}

_zsh_tfswitch_last_version() {
    echo $(curl -s https://api.github.com/repos/warrensbox/terraform-switcher/releases | grep tag_name | head -n 1 | cut -d '"' -f 4)
}

_zsh_tfswitch_download_install() {
    local version=$1
    _zsh_tfswitch_log $NONE "blue" "  -> download and install tfswitch ${version}"
    wget -qc --no-check-certificate https://github.com/warrensbox/terraform-switcher/releases/download/${version}/terraform-switcher_${version}_${OSTYPE%-*}_amd64.tar.gz -O ${TFSWITCH_HOME}/tfswitch.tar.gz
    tar xzf ${TFSWITCH_HOME}/tfswitch.tar.gz --directory ${TFSWITCH_HOME} 2>&1 > /dev/null
    rm -rf ${TFSWITCH_HOME}/tfswitch.tar.gz
    echo ${version} > ${ZSH_TFSWITCH_VERSION_FILE}
}

_zsh_tfswitch_install() {
    _zsh_tfswitch_log $NONE "blue" "#############################################"
    _zsh_tfswitch_log $BOLD "blue" "Installing tfswitch..."
    _zsh_tfswitch_log $NONE "blue" "-> creating tfswitch home dir : ${TFSWITCH_HOME}"
    mkdir -p ${TFSWITCH_HOME} || _zsh_tfswitch_log $NONE "green" "dir already exist"
    local last_version=$(_zsh_tfswitch_last_version)
    _zsh_tfswitch_log $NONE "blue" "-> retrieve last version of tfswitch..."
    _zsh_tfswitch_download_install ${last_version}
    _zsh_tfswitch_log $BOLD "green" "Install OK"
    _zsh_tfswitch_log $NONE "blue" "#############################################"
}

update_zsh_tfswitch() {
    _zsh_tfswitch_log $NONE "blue" "#############################################"
    _zsh_tfswitch_log $BOLD "blue" "Checking new version of kubectx..."

    local current_version=$(cat ${ZSH_TFSWITCH_VERSION_FILE})
    local last_version=$(_zsh_tfswitch_last_version)

    if is-at-least ${last_version} ${current_version}
    then
        _zsh_tfswitch_log $BOLD "green" "Already up to date, current version : ${current_version}"
    else
        _zsh_tfswitch_log $NONE "blue" "-> Updating tfswitch..."
        _zsh_tfswitch_download_install ${last_version}
        _zsh_tfswitch_log $BOLD "green" "Update OK"
    fi
    _zsh_tfswitch_log $NONE "blue" "#############################################"
}

_zsh_tfswitch_load() {
    # export PATH
    export PATH=${PATH}:${TFSWITCH_HOME}
}

# install tfswitch if it isnt already installed
[[ ! -f "${ZSH_TFSWITCH_VERSION_FILE}" ]] && _zsh_tfswitch_install

# load tfswitch if it is installed
if [[ -f "${ZSH_TFSWITCH_VERSION_FILE}" ]]; then
    _zsh_tfswitch_load
fi


########################################################
##### function to load tfswitch automaticaly
########################################################
load-tfswitch() {
  local tfswitchrc_path=".tfswitchrc"

  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}
add-zsh-hook chpwd load-tfswitch
load-tfswitch

unset -f _zsh_tfswitch_install _zsh_tfswitch_load