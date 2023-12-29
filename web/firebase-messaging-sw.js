importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyCXiwOUNsbzKH7sbSAZrqA9f7VOeCMdUOQ',
  appId: '1:414429242328:web:a4685f5ac6895ea767c8ad',
  messagingSenderId: '414429242328',
  projectId: 'gigaturnip-b6b5b',
  authDomain: 'gigaturnip-b6b5b.firebaseapp.com',
  storageBucket: 'gigaturnip-b6b5b.appspot.com',
  measurementId: 'G-Y8JTEJMTET',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();