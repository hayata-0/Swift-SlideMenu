# スライドメニュー機能の作成
Swiftを使用した良く使うスライドメニュー

### 目的
* どのアプリケーションでも見かけるスライドメニューの勉強をするために実装をしました。

### 使用技術
* Swift

### 機能の説明
> 機能はスライドメニューをtableViewを使用し、画面移動をスムーズに行います。今回はコードでrootViewControllerを指定する形で行っております

## iconに使用したもの
* SF Symbols
`https://developer.apple.com/sf-symbols/`
SF Symbolsのバージョンによって合わせて使用してください

## Installation
1. クローンをします
```html
git clone https://~
```

2. ビルドしたら使用できます

## 技術メモ

### 別のViewControllerのViewを使用する
```html
addChild(menuVC)
view.addSubview(menuVC.view)
menuVC.didMove(toParent: self)
```
上記の処理で実装可能

### 循環参照を防止
```html
weak var delegate:MenuViewControllerDelegate?
```
メモリリークを防ぐことができます

### enumでstateをcase分け
```html
enum MenuState {
   case opened
   case closed
}
```

### UIKitアニメーションについて
> UIView.animateメソッド
* duration アニメーション時間
* delay 開始までの遅延時間
* options アニメーション中に使用するタイミング曲線の種類やアニメーションの逆再生などを指定
* animations クロージャの中でアニメーションしたいUIViewクラスのプロパティの値を変更する
* completion クロージャはアニメーションが完了したタイミングで呼ばれるクロージャ

今回記述の中の例
```html
       //開く処理
       UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
       } completion: {[weak self] done in
         if done{
            self?.menuState = .opened           
         }
       }
```

### weak selfについて
* weak selfと書くことでクロージャがselfを弱参照し、クロージャとselfの循環参照を防ぐことができる
使用した部分↓
```html
completion: {[weak self] done in
  if done{
      self?.menuState = .opene
  }
}
```
ここの部分はもう少し深掘りが必要そうなので下記のQiitaの記事を拝見
`https://qiita.com/reo0612/items/b0d1ee00ebf3a0e7c857`
`https://qiita.com/rockname/items/b00d52c9bc49603f99a5`

### UITableViewのセルをタップした時のアクションを実装
```html
//UITableViewのセルをタップした時のアクション
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
}
```
didSelectRowAtがCellを触ったといことを感知しているfunctionでここに処理を書くと簡単に実装できる

### 画面遷移後にUITableViewのセルが選択状態のままになってしまうのを防ぐ
```html
tableView.deselectRow(at: indexPath, animated: true)
```

### lazyプロパティの使い方
参照された時に初めて初期値が設定されるプロパティ

どんな時に使用するのかを参考にした記事
`https://qiita.com/negi0205/items/d367395d5780c915fb1d`

### guard letとは
これ以上処理を進めたくない場合に使用します。
特に、nilが入っていたらエラーとして扱うケースに良く使用されます
