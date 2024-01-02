'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "a3322b2f035e5345663b567001345585",
"index.html": "46ebc23bf524e8f861d5cbf16a76f4aa",
"/": "46ebc23bf524e8f861d5cbf16a76f4aa",
"main.dart.js": "7c3ef42cf059b0633da9f6bf1520e3f7",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "8181094b133ade4747ca90e03631c612",
"assets/AssetManifest.json": "e17952ac5231a5276843bc210d43bb9b",
"assets/NOTICES": "6848938ab762167f6c3a246135d35993",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "7657a7cc2dc97f1167eb59c41dbb599d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "79e9c424c37c377c8bd54623113a7acd",
"assets/packages/flutter_rating_stars/assets/star_off.png": "510ce4aac7c14568132bdda920c8a76e",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "befdc0e5b9640c9797db5636d9415f0c",
"assets/fonts/MaterialIcons-Regular.otf": "75e06a9e7c6401d4cc4f86acc40f2af6",
"assets/assets/apple_music_logo.png": "31c48ee9ae832eeb13923b22025a2d48",
"assets/assets/slider.png": "ea8cd529b4d4defaf56ffbfa20df2e28",
"assets/assets/apple_music_2.jpeg": "d18ff28d6ca83af6c77a62f065665664",
"assets/assets/app_icon_14.png": "730601881035d0840d1803c7b436be6b",
"assets/assets/app_icon_10.png": "1737b4a7e957bdb0f93b0b4328e35e22",
"assets/assets/apple_music_3.jpeg": "eb34a42b813efabc3f76582b98c26920",
"assets/assets/app_icon_11.png": "c1cd9ada68dd1a7319caa7c61f9ace74",
"assets/assets/app_icon_13.png": "1d58b366104f6a7eaf5f230606065220",
"assets/assets/app_icon_12.png": "64e8a84066678445de820d4014c9f053",
"assets/assets/apple_music_4.jpeg": "b086e93849d1237e70789ef62d7c7e32",
"assets/assets/heisenberg.jpeg": "5eb1835e80cc027f3e8068c186f8a903",
"assets/assets/slider1.png": "b88548cdd73883c4e2dabcb5e6daaed3",
"assets/assets/slider3.png": "8624cb9f00432eb3f8fef5d268a8f63a",
"assets/assets/github.png": "74f7475de22c2795f6447e654cc1f27f",
"assets/assets/slider2.png": "d0b92c23c7ec91c8a4280027029dc3af",
"assets/assets/empty_profile.png": "45976ff3565db0d40a5d8e1217b54f21",
"assets/assets/app_icon_8.png": "1b980b74c474d2ba5cf84a7b861f6d6f",
"assets/assets/app_icon_9.png": "b6efb077d26dc41bec97f5da2d73b709",
"assets/assets/apple_music_5.jpeg": "9b953115d1888bbe3edbb07e4b31f425",
"assets/assets/slider4.png": "f852534dc78d54750523e3e9c2e626de",
"assets/assets/app_icon_4.png": "bc7a775a2d269cb9ab37eeb3e8b216a4",
"assets/assets/app_icon_5.png": "70ac3a0999ea4cffccf79998bc531689",
"assets/assets/apple_music_6.jpeg": "b5878768484d7ef0685b0bfeeebd382d",
"assets/assets/app_icon_7.png": "e420890187a28b67b5d557435f7501e0",
"assets/assets/app_icon_6.png": "41075f492cd7c5ab9c6715819a491c57",
"assets/assets/app_icon_2.png": "dcedd46b8921c13034ea9cb0a711ea81",
"assets/assets/app_icon_3.png": "1b1d94b61c8892b25a4c235f8001a243",
"assets/assets/profile.png": "3230711bd8b591a6061a380a1d5fb06d",
"assets/assets/app_icon_1.png": "8f8e93c7b83e48491257a59ce8d49238",
"assets/assets/app_icon_0.png": "6bdb1874c8904df0fe63509397dfc209",
"assets/assets/favorite.json": "db4ba65063db32ae6c390584ba4fe97a",
"assets/assets/intro_33.gif": "237c2a1c3dfa7bc44695691f48b67cbc",
"assets/assets/apple_music_0.jpeg": "e035953f264cd030692c5155623ec9b1",
"assets/assets/intro_4.gif": "167298dd6781ce18cff578e385775f4c",
"assets/assets/apple_music_1.jpeg": "41b93691b2f68d09830512c72ab1c384",
"assets/assets/intro.gif": "e62b93615004e032a7802346964959e1",
"assets/assets/intro_1.gif": "0df2b9b8681c1afba5ed6820d4cbc142",
"assets/assets/intro_3.gif": "237c2a1c3dfa7bc44695691f48b67cbc",
"assets/assets/intro_2.gif": "7e262eeab034ee0cc2c517a651361b3b",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
