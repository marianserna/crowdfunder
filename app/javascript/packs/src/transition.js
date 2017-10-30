import $ from 'jquery';
import Barba from 'barba.js';
import { TweenMax } from 'gsap';

const SlideTransition = Barba.BaseTransition.extend({
  start: function() {
    this.newContainerLoading.then(() => {
      this.slideOut();
      this.slideIn();
    });
  },

  slideOut: function() {
    TweenMax.fromTo(this.oldContainer, 0.5, {
      x: '0%'
    }, {
      x: '100%'
    });
  },

  slideIn: function() {
    TweenMax.set(this.newContainer, {
      visibility: 'visible',
      opacity: 1
    });

    TweenMax.fromTo(this.newContainer, 0.5, {
      x: '-100%'
    }, {
      x: '0%',
      onComplete: () => {
        this.done();
      }
    });
  }
});

Barba.Pjax.getTransition = () => {
  return SlideTransition;
};

$(() => {
  Barba.Pjax.start();
});
