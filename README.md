# Instalation

> [!WARNING]  
> This neovim configuration depends on [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for some parts of its UI. If you're using it from the terminal, you'll need to set up your terminal font accordingly.
> The Windows installation setup the Hack Nerd font, but the Linux one leaves you on your own. 

## Windows
To install this neovim configuration on windows you'll need Powershell and [scoop](https://scoop.sh/).

To install scoop simply run:
```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
Once scoop is set up, add the necessary buckets:
```powershell
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts
```
Then you can install the `nvim-config` package:
```powershell
scoop install -k https://raw.githubusercontent.com/cpp-playground/nvim_config/master/neovim-config.json
```
You should now be ready to go. Run nvim (`nvim` or `nvim-qt`) and run `:PackerSync` to download and update all the plugins

## Linux
To install this neovim configuration on Ubuntu, simply run:
```bash
wget -O - https://raw.githubusercontent.com/cpp-playground/nvim_config/master/setup.sh | bash
```

> [!NOTE]
> The plugins used by this config require a fairly modern version of Neovim. Sometimes, the snap version isn't "new" enough.
> If you prefer to manually install the config, simply install all the dependencies (git unzip python3-venv) and neovim manually
> then clone this repository as `~/.config/nvim` (Which can be done with the following command: `git clone git@github.com:cpp-playground/nvim_config.git ~/.config/nvim`)
