// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";  // Stimulusアプリケーションをインポート
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"; // Stimulusのコントローラを遅延読み込みするためのヘルパー

// Stimulusコントローラを一括で読み込む設定
eagerLoadControllersFrom("controllers", application);  // 'controllers'ディレクトリ内の全てのコントローラをアプリケーションに登録

// DOMの読み込み完了後に実行されるスクリプト
document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');  // 販売価格の入力フィールドを取得
  const feeDisplay = document.getElementById('add-tax-price');  // 販売手数料表示用の要素を取得
  const profitDisplay = document.getElementById('profit');  // 販売利益表示用の要素を取得

  // 販売価格が入力されるたびに呼び出されるイベントリスナー
  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value, 10);  // 入力された価格を整数に変換

    // 入力された価格が有効な数値かつ300円以上の場合
    if (!isNaN(price) && price >= 300) {
      const fee = Math.floor(price * 0.1);  // 手数料（価格の10%）を計算
      const profit = price - fee;  // 利益（価格から手数料を引いたもの）を計算

      feeDisplay.textContent = fee.toLocaleString();  // 手数料を表示（3桁区切り）
      profitDisplay.textContent = profit.toLocaleString();  // 利益を表示（3桁区切り）
    } else {
      // 入力が不正な場合、手数料と利益を0に設定
      feeDisplay.textContent = '0';
      profitDisplay.textContent = '0';
    }
  });
});
