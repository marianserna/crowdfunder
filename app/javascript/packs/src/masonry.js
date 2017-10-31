import Masonry from 'masonry-layout';
import $ from 'jquery';

$(() => {
  // vanilla JS
  // init with element
  var grid = document.querySelector('.grid');
  var msnry = new Masonry( grid, {
    // options...
    itemSelector: '.grid-item',
    columnWidth: 200
  });

  // init with selector
  var msnry = new Masonry( '.grid', {
    // options...
  });
});
