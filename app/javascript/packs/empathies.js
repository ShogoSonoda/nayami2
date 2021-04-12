document.addEventListener('turbolinks:load', () => {
  const empathyButton = document.getElementById('js-empathy-button');
  let currentColor = empathyButton.className
  const empathyColor = "inline-block border border-red-500 py-1 px-2 rounded-lg text-white bg-red-500";
  const unempathyColor = "inline-block border border-red-500 py-1 px-2 rounded-lg text-red-500 bg-white";
  
  empathyButton.addEventListener('click', () => {
    // いいね済の場合
    if (currentColor === empathyColor) {
      empathyButton.className = unempathyColor;
    }
    // いいねしていない場合
    else {
      empathyButton.className = empathyColor;
      post_data = {
        post_id: document.getElementById('post_id').value
      }
      const res = fetch('/api/v1/empathies', {
        method: 'POST',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': getCsrfToken()
        },
        body: JSON.stringify(post_data),
      })
    }
  });
  
  const getCsrfToken = () => {
    const metas = document.getElementsByTagName('meta');
    for (let meta of metas) {
      if (meta.getAttribute('name') === 'csrf-token') {
        return meta.getAttribute('content');
      }
    }
    return '';
  }
});
