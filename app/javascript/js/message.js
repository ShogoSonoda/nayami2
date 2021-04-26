document.addEventListener('turbolinks:load', () => {
  const messageEndpoint = '/api/v1/messages';
  const getCsrfToken = () => {
    const metas = document.getElementsByTagName('meta');
    for (let meta of metas) {
      if (meta.getAttribute('name') === 'csrf-token') {
        return meta.getAttribute('content');
      }
    }
    return '';
  }
  
  const sendRequest = async (endpoint, method, json) => {
    const response = await fetch(endpoint, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': getCsrfToken()
      },
      method: method,
      credentials: 'same-origin',
      body: JSON.stringify(json)
    });
    
    if (!response.ok) {
      throw Error(response.statusText);
    } else {
      return response.json();
    }
  }

  // 新しいメッセージを一番下に表示する
  const addMessage = (userName, messageText) => {
    const messageBox = document.getElementById('messages');
    // link_toを使うと文字列として表記されてしまうのでaタグを使う
    const newMessage = `
      <div class="message">
        <div class="block mb-3 text-right">
          <div class="block">
            <a href="/users/2">${userName}</a>
          </div>
          <div class="inline-block border rounded-full px-2 py-1 bg-yellow-300">
            ${messageText}
          </div>
        </div>
      </div>`;
    messageBox.insertAdjacentHTML('beforeend', newMessage);
  }

  const btn = document.getElementById('message_btn');

  btn.addEventListener('click', event => {
    // クリックイベントのデフォルトの動きを止める
    event.preventDefault();

    const messageForm = document.getElementById('message');
    const message = messageForm.value;
    const roomId = document.getElementById('room_id').value;

    const createMessage = (message, roomId) => {
      sendRequest(messageEndpoint, 'POST', { room_id: roomId, text: message })
      .then((data) => {
        // フォームの中を空にする
        messageForm.value = '';
        const messageText = data.message.text;
        const userName = data.user_name;
        addMessage(userName, messageText);
      })
    }
    
    createMessage(message, roomId);
  })

});
