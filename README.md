# tweet_network_speed
5分おきに人権のある回線速度かツイートしてくれるスクリプト
- [speedtest-cli](https://github.com/sivel/speedtest-cli)を外部コマンドで呼び出して使ってるので、使えるようにしといてください
  - Macならbrewで入ります。pythonなら、easy_installで入るらしい
- 高速(30Mbps)超過か低速未満の状態が3回続いたらツイートやめます。
  - つぶやきすぎたらフォロワー減ったorz
- csvでログも残してあります。各自解析してどうぞ。
- 変数名とか、いろいろガバガバですが許して。いつか直すよ。たぶんね。てかPRお待ちしてます。
