import * as THREE from 'three';
import OBJLoader from 'three-obj-loader';
import OrbitControlsCreator from 'three-orbit-controls';
import $ from 'jquery';

OBJLoader(THREE);
const OrbitControls = OrbitControlsCreator(THREE);

function load(window, document) {
  var container = document.getElementById('three-container');
  if (!container) {
    return;
  }
  var width = container.offsetWidth;
  var height = container.offsetHeight;
  var scene = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera( 75, width / height, 0.1, 1000);

  var light = new THREE.AmbientLight( 0xA2A9AF, 1.2 ); // soft white light
  scene.add( light );

  var spotLight = new THREE.SpotLight( 0xA2A9AF, 0.5 );
  spotLight.position.set( 100, 1000, 100 );
  spotLight.castShadow = true;
  spotLight.shadow.mapSize.width = 1024;
  spotLight.shadow.mapSize.height = 1024;
  spotLight.shadow.camera.near = 500;
  spotLight.shadow.camera.far = 4000;
  spotLight.shadow.camera.fov = 30;
  scene.add( spotLight );

  var renderer = new THREE.WebGLRenderer({
    antialias: true,
    wireframe: true,
    alpha: true
  });
  renderer.setSize( width, height );

  container.appendChild( renderer.domElement );
  const controls = new OrbitControls( camera, renderer.domElement );

  // Resize
  window.addEventListener( 'resize', function() {
    renderer.setSize( container.offsetWidth, container.offsetHeight );
    camera.aspect = container.offsetWidth / container.offsetHeight;
    camera.updateProjectionMatrix();
  } );

  camera.position.z = 10;

  var loader = new THREE.OBJLoader();
  var tooth;
  var material = new THREE.MeshPhongMaterial({color: 0xFA625F, side: THREE.DoubleSide});

  loader.load
  (
    '/PiggyBank.obj',
    function( object ) {
      // object.position.z = 0;
      // object.rotation.y += 90 * Math.PI / 180;
      object.rotation.x -= 1;
      object.position.y -= 3;
      object.scale.set(0.08, 0.08, 0.08);
      object.traverse( function ( child ) {
        if ( child instanceof THREE.Mesh ) {
          child.material = material;
        }
      });
      scene.add( object );
      tooth = object;
    }
  );

  // Draw scene
  var render = function() {
    renderer.render( scene, camera );
  };

  // Run loop (update, render, repeat)
  var loop = function() {

    requestAnimationFrame( loop );

    render();
  };
  loop();
}

$(function() {
  load(window, document);
})
