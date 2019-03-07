document.addEventListener('turbolinks:load', () => {

  let alert = document.getElementsByClassName('alert-danger')[0];

  let showError = (e) => {
    var status = e.detail[e.detail.length - 1].status;

    if (status == 401) alert.innerText = e.detail[0]
  };

  document.addEventListener('ajax:error', showError);
});
