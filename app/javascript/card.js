const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // 送信処理を一旦停止（これがないと処理が途中で中断される可能性あり）

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        console.error(response.error.message); // エラー内容をコンソールに表示
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value="${token}" name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      form.submit(); // トークンが取得できたらフォーム送信
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);