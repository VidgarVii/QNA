document.addEventListener('turbolinks:load', () => {
  let showHonor = document.getElementById('show_honor'),
      honorBlock = document.getElementsByClassName('honor_block')[0];

  toogleBlock = (e) => {
    e.preventDefault();

    honorBlock.classList.toggle('hidden')
  }

  if (showHonor) { showHonor.addEventListener('click', toogleBlock) }


  // Form for create Honor

  let honorBtn = document.getElementById('create_honor');

  showFormHonor = (e) => {
    e.preventDefault();

    honorForm.classList.toggle('hidden');
  };

  setImage = (e) => {
    honorImage.alt = 'honor img';
    honorImage.src = URL.createObjectURL(fileField.files[0]);
  };

  if (honorBtn) {
    var honorForm  = document.getElementById('honor_form'),
      honorImage = document.getElementById('honor_image'),
      fileField  = honorForm.querySelector('input[type="file"]');

    honorBtn.addEventListener('click', showFormHonor);
    fileField.addEventListener('change', setImage);
  }
});
