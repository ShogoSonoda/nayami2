document.addEventListener('turbolinks:load', () => {
  const empathyColor = "js-empathy-button inline-block border border-red-500 py-1 px-2 rounded-lg text-white bg-red-500";
  const unempathyColor = "js-empathy-button inline-block border border-red-500 py-1 px-2 rounded-lg text-red-500 bg-white";
  const empathyEndpoint = '/api/v1/empathies';
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
  
  
  const empathyButtons = document.getElementsByClassName('js-empathy-button');
  
  for (let i = 0; i < empathyButtons.length; i++) {
    empathyButtons[i].addEventListener('click', event => {
      const button = event.target;

      const createEmpathy = (postId, button) => {
        sendRequest(empathyEndpoint, 'POST', { post_id: postId })
          .then((data) => {
            button.value = data.empathy_id
            console.log(button.value);
          });
        }
        
        const deleteEmpathy = (empathyId, button) => {
          const deleteEmpathyEndpoint = empathyEndpoint + '/' + `${empathyId}`;
          sendRequest(deleteEmpathyEndpoint, 'DELETE', { id: empathyId })
          .then(() => {
            button.value = '';
            console.log(button.value);
          });
      }

      if (!!button) {
        const currentColor = button.className;
        const postId = button.id;
        const empathyId = button.value;
        // 共感する場合
        if (currentColor === unempathyColor) {
          button.className = empathyColor;
          button.innerText = '共感済み';
          createEmpathy(postId, button);
        }
        // 共感済みの場合
        else {
          button.className = unempathyColor;
          button.innerText = '共感する';
          deleteEmpathy(empathyId, button);
        }
      }
    });
  }
});
