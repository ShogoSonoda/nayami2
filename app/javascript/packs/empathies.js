document.addEventListener('turbolinks:load', () => {
  let empathyButton = document.getElementById('js-empathy-button');
  let currentColor = empathyButton.classList.item(-1) + empathyButton.classList.item(-2);
  const empathyColor = 'text-white bg-red-500';
  const unempathyColor = 'text-red-500 bg-white';

  console.log(empathyButton);
  console.log(currentColor);
  console.log(empathyColor);
  console.log(unempathyColor);
  
  empathyButton.addEventListener('click', () => {
  
  });

});