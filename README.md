# はじめに

Windowsの開発環境を構築・メンテナンスするためのスクリプトなどです。

# 事前準備

[Windows への PowerShell のインストール](https://learn.microsoft.com/ja-jp/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#installing-the-msi-package)

# 初回実行

```cmd
Start-Process powershell -Verb runAs {Set-ExecutionPolicy RemoteSigned -scope CurrentUser -Force; iwr -useb https://raw.githubusercontent.com/junkichi424/MyEnvironments1/refs/heads/master/prerequisite.ps1 | iex}
```

完了後、PCを再起動します。

PowerShellからつぎのコマンドを実行します。

```powershell
cd c:\Repos\MyEnvironments
sudo .\update.ps1
```
# 更新

PowerShellからつぎのコマンドを実行します。

```powershell
cd c:\Repos\MyEnvironments
sudo .\update.ps1
```
