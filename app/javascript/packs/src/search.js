import $ from 'jquery';

$(() => {
  const search_form = document.querySelector('.search-form');

  const search_btn = document.querySelector('.trigger-search');
  search_btn.addEventListener('click', (e) => {
    e.preventDefault();
    search_form.classList.toggle('visible');
  });
});
