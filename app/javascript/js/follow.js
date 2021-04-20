document.addEventListener('turbolinks:load', () => {
  const followColor = "js-follow-button text-blue-500 bg-white hover:bg-blue-300 rounded border w-32 py-1 px-2 text-center";
  const unfollowColor = "js-follow-button text-white bg-blue-400 hover:bg-blue-500 rounded w-32 py-1 px-2 text-center";
  const followEndpoint = '/api/v1/relationships';
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

  const followButtons = document.getElementsByClassName('js-follow-button');
  
  for (let i = 0; i < followButtons.length; i++) {
    followButtons[i].addEventListener('click', event => {
      const button = event.target;

      const createFollow = (followedId, button) => {
        sendRequest(followEndpoint, 'POST', { followed_id: followedId })
        .then((data) => {
          button.value = data.relationship_id;
          console.log(button.value);
          
        });
      }

      const deleteFollow = (relationshipId, button) => {
        const deleteFollowEndpoint = followEndpoint + '/' + `${relationshipId}`;
        sendRequest(deleteFollowEndpoint, 'DELETE', { id: relationshipId })
        .then(() => {
          button.value = '';
        });
      }

      if (!!button) {
        const currentColor = button.className;
        const followedId = button.id;
        const relationshipId = button.value;
        // フォローする場合
        if (currentColor === unfollowColor) {
          button.className = followColor;
          button.innerText = 'フォロー中';
          createFollow(followedId, button);
        }
        // フォロー外す場合
        else {
          button.className = unfollowColor;
          button.innerText = 'フォローする';
          deleteFollow(relationshipId, button);
        }
      }
    });
  }
});