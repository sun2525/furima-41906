document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price'); // 販売価格の入力フィールド
  const feeDisplay = document.getElementById('add-tax-price'); // 手数料表示用
  const profitDisplay = document.getElementById('profit'); // 利益表示用

  if (priceInput && feeDisplay && profitDisplay) { // 全ての要素が存在する場合
    priceInput.addEventListener('input', () => {
      const price = parseInt(priceInput.value, 10); // 入力値を整数に変換

      if (!isNaN(price) && price >= 300 && price <= 9999999) { // 有効な範囲内の価格
        const fee = Math.floor(price * 0.1); // 手数料を計算（10%）
        const profit = price - fee; // 利益を計算

        feeDisplay.textContent = fee.toLocaleString(); // 手数料を表示
        profitDisplay.textContent = profit.toLocaleString(); // 利益を表示
      } else {
        // 不正な値や範囲外の場合はリセット
        feeDisplay.textContent = '0';
        profitDisplay.textContent = '0';
      }
    });
  }
});
