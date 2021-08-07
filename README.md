# zsh-tfswitch

![GitHub](https://img.shields.io/github/license/ptavares/zsh-tfswitch)

zsh plugin for installing and loading [terraform-switcher](https://github.com/warrensbox/terraform-switcher)

## Table of content

- [zsh-tfswitch](#zsh-tfswitch)
  - [Usage](#usage)
    - [Usage alias](#usage-alias)  
  - [Updating tfswitch](#updating-tfswitch)
  - [License](#license)

## Usage

Once the plugin installed, `tfswitch` will be available

- Using [Antigen](https://github.com/zsh-users/antigen)

Bundle `zsh-tfswitch` in your `.zshrc`

```shell script
antigen bundle ptavares/zsh-tfswitch
```

- Using [zplug](https://github.com/b4b4r07/zplug)

Load `zsh-tfswitch` as a plugin in your `.zshrc`

```shell script
zplug "ptavares/zsh-tfswitch"
```

- Using [zgen](https://github.com/tarjoilija/zgen)

Include the load command in your `.zshrc`

```shell script
zget load ptavares/zsh-tfswitch
```

- As an [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

Clone `zsh-tfswitch` into your custom plugins repo and load as a plugin in your `.zshrc`

```shell script
git clone https://github.com/ptavares/zsh-tfswitch.git ~/.oh-my-zsh/custom/plugins/zsh-tfswitch
```

```shell script
plugins+=(zsh-tfswitch)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.

- Manually

Clone this repository somewhere (`~/.zsh-tfswitch` for example) and source it in your `.zshrc`

```shell script
git clone https://github.com/ptavares/zsh-tfswitch ~/.zsh-tfswitch
```

```shell script
source ~/.zsh-tfswitch/zsh-tfswitch.plugin.zsh
```

## Updating tfswitch

The plugin comes with a zsh function to update [tfswitch](https://github.com/ahmetb/tfswitch.git) manually

```shell script
# From zsh shell
update_zsh_tfswitch
```

## License

[MIT](LICENCE)
