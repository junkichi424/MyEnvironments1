# はじめに

Windowsの開発環境を構築・メンテナンスするためのスクリプトなどです。
このリポジトリは PowerShell 7 向けに最適化されています。

# 事前準備

[Windows への PowerShell 7 のインストール](https://learn.microsoft.com/ja-jp/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)

PowerShell 7 のインストールは次のコマンドでも実行できます（管理者権限のコマンドプロンプトから）:

```cmd
winget install --id Microsoft.Powershell --source winget
```

# 初回実行

PowerShell 7 を管理者権限で起動し、次のコマンドを実行します:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/junkichi424/MyEnvironments1/refs/heads/master/prerequisite.ps1 | Invoke-Expression
```

完了後、PCを再起動します。

PowerShell 7 から次のコマンドを実行します。

```powershell
cd C:\Repos\MyEnvironments1
sudo .\update.ps1
```

# 更新

PowerShell 7 から次のコマンドを実行します。

```powershell
cd C:\Repos\MyEnvironments1
sudo .\update.ps1
```