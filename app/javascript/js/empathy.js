document.addEventListener('turbolinks:load', () => {
  const empathyColor = "js-empathy-button inline-block border border-red-500 py-1 px-2 rounded-lg text-white bg-red-500 cursor-pointer hover:bg-red-700";
  const unempathyColor = "js-empathy-button inline-block border border-gray-700 py-1 px-2 rounded-lg text-gray-700 bg-white cursor-pointer hover:bg-red-300";
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
      console.log(button);
      let empathyCount = Number(button.children[0].value);
      const postId = Number(button.children[1].value);
      const empathyId = Number(button.children[2].value);
      console.log(empathyCount);
      console.log(postId);
      console.log(empathyId);
      
      const createEmpathy = (button, postId, empathyId, empathyCount) => {
        sendRequest(empathyEndpoint, 'POST', { post_id: postId })
          .then((data) => {
            empathyCount += 1;
            button.className = empathyColor;
            button.innerHTML = `
              共感済み ${empathyCount}
              <input type="hidden" id="empathy_count" value="${empathyCount}">
              <input type="hidden" id="post_id" value="${postId}">
              <input type="hidden" id="empathy_id" value="${data.empathy_id}">`;
          });
        }
        
        const deleteEmpathy = (button, postId, empathyId, empathyCount) => {
          const deleteEmpathyEndpoint = empathyEndpoint + '/' + `${empathyId}`;
          sendRequest(deleteEmpathyEndpoint, 'DELETE', { id: empathyId })
          .then(() => {
            empathyCount -= 1;
            button.className = unempathyColor;
            button.innerHTML = `
              共感する ${empathyCount}
              <input type="hidden" id="empathy_count" value="${empathyCount}">
              <input type="hidden" id="post_id" value="${postId}">
              <input type="hidden" id="empathy_id" value="">`;
        });
      }

      if (!!button) {
        const currentColor = button.className;
        
        // 共感する場合
        if (currentColor === unempathyColor) {
          createEmpathy(button, postId, empathyId, empathyCount);
        }
        // 共感済みの場合
        else {
          deleteEmpathy(button, postId, empathyId, empathyCount);
        }
      }
    });
  }
});
