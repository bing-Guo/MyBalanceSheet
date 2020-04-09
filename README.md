# MyBalanceSheet - 個人資產管理表

[APP連結](https://apps.apple.com/tw/app/mybalencesheet-%E5%80%8B%E4%BA%BA%E8%B3%87%E7%94%A2%E8%B2%A0%E5%82%B5%E8%A1%A8/id1506556532)

## 設計方向
* 可以每個月記一次帳就好，免除每天都要記帳的壓力
* APP可以清楚明白自身目前財務狀況，包括資產多少、負債多少、淨值多少、跟上個月比是變好還是變壞？
* 考量隱私要支援Face ID加鎖
* 加入「尚未有資料」的圖片引導，讓使用者知道要怎麼新增

## 使用技術

### UI
* 使用Storyboard+xib刻UI
* 以月為單位，預設呈現當月資訊，點選左右按鈕可以切換月份，原本加入手勢可左右滑動切換月份，但沒有轉場效果直接刷新資料，讓人感受度滿差的，這部分下次更新會補上。
* 呈現是使用Card View，客製table view cell實現該效果

### 儲存
* 使用Core Data，選擇這方案單純是我練習考量(因之前使用過Realm)，加上之後可以上iCloud，實現備份雲端功能

### 生物辨識
* 使用LocalAuthentication實現Face ID和支援指紋辨識，這裡考慮有人會關閉或不支援Face ID或指紋辨識，也提供以密碼方式登入

### 上架APP Store
* 使用Sketch準備宣傳文字，和不同size的icon和網頁截圖
* 建立launch screen跟icon
* 填寫申請內容，上架APP
