# アプリ名
 
テニスの試合状況確認アプリ

# 概要

 
- お気に入り選手を登録すると，その選手の試合前に LINE で通知が来る．
- 選手ごとに，過去の試合結果を web ページで確認できる．
- 大会ごとの web ページでは，現地付近のライブカメラ画像を見ることができる．
- 大会開始前に，大会開始の通知と現地付近のライブカメラ画像が LINE で送られてくる

# URL 

https://atp-tour-search.tk/


# デモ

- 選手ごとに，過去の試合結果を確認
https://user-images.githubusercontent.com/63027348/160748658-420f8670-6ff3-4aa3-aeea-fb6a3de857b5.mp4

- お気に入り選手の試合前の LINE 通知

<img src="https://user-images.githubusercontent.com/63027348/172530859-46d9d331-13e6-4710-9783-9c7248649425.jpg" width="250">

- 大会ごとの web ページで，現地付近のライブカメラ画像の確認
https://user-images.githubusercontent.com/63027348/172530570-7c04f6f6-5d7f-4a49-b14b-105db4cc66ff.mp4


- 大会開始前の通知

<img src="https://user-images.githubusercontent.com/63027348/172531122-63b20259-6304-4413-83f8-503e32bffeab.jpg" width="250">



# ターゲット

自分の母のような，ATP テニスの熱狂的なファン

# 課題

1. お気に入りの選手の試合日程を自分で調べるのは面倒．忘れていて見逃してしまうこともある．試合日程を通知してくれるアプリは既にあるが，錦織圭など日本人の選手しか対応していない．
2. コロナでなかなか海外旅行に行けない

# 上の課題を解決するための機能

1. お気に入り選手の試合前に LINE で通知する機能
日本人以外の選手にも対応．
2. webページや LINE による通知で現地付近のライブカメラ映像を確認できる
ATPツアーと共に海外旅行している気分になれる

# 結果（アプリを使うことにより，課題は解決されたか）

1. 母から「試合を見逃すことがなくなった．ありがとう」と言われた．
2. 全仏オープン開始前の LINE 通知で現地のライブカメラ映像を見た母に，「いいね．旅行に行った気分になれる」と言われた．

# 使用技術

Ruby/Ruby on Rails/Tennis Live Data API/webcams.Travel API/Line Notify/AWS/PostgreSQL


# 技術的に工夫した点

- Web ページの表示速度の改善のためにクエリの処理を工夫した点．（例えば，工夫前と比べてトップページの表示速度は 0.7 秒改善した）

# ER 図

![drawSQL-export-2022-05-08_23_40](https://user-images.githubusercontent.com/63027348/167301526-6e61c79d-6b87-4fbf-aa6f-f3b83fb892b1.png)
