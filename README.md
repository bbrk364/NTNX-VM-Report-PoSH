# NTNX-VM-Report-PoSH
PowerShell で AHV 環境レポート出力自動化くん

## なんだこれ - What's this?
PowerShell のスクリプトです。

Nutanix AHV の環境において対象クラスターに存在している仮想マシンをCSV形式で出力してくれます。

## 実行方法 - How to use

ログイン情報ファイルをコピーして、アドレス、ユーザ、パスワードなどを書き換える。

```
PS> cp ./NTNX-Login-Config_SAMPLE.ps1 ./NTNX-Login-Config.ps1
```

ログイン情報ファイルを指定してスクリプトを実行し、レポートを出力する。

```
PS> ./NTNX-VM-Report.ps1 ./NTNX-Login-Config.ps1
```

## なぜこれを作ったか - Why
かつて仮想環境のオペレーターをやっていたワタクシは月に一度、定例会で仮想サーバーの稼働状況を報告していました。

だいぶ前の話なので手作業でやっていたのですが、それを自動化したいという願いを込めて、まずはこれから始めました。

## 将来の展望 - Roadmap
CPUやメモリの利用状況とか継続時間を出力できるようにしたいです。

あと、立派なExcelでの報告書形式にしたいです。

