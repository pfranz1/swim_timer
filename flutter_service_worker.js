'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "862daa5c10b5990d82a7eadfb981cb7d",
"icons/manifest.json": "a2b3516325017ef1a66dd199b4dc8ccf",
"icons/ms-icon-144x144.png": "1aac986686d009d36e060c75eed8470a",
"icons/ms-icon-70x70.png": "f39abf8a4d1143502b76a88fd7d23997",
"icons/apple-icon-152x152.png": "2c9942f0835439e61cd315ef4941eb41",
"icons/android-icon-72x72.png": "99803e1323ade4124dfcf84cb85ec886",
"icons/favicon-96x96.png": "fd35a3e6694bb402ababe5b2296c35fe",
"icons/android-icon-48x48.png": "86edd23286d7182ae06d18cf72c17228",
"icons/apple-icon.png": "c320335ca6682adfb1569f2b97dfeff7",
"icons/favicon-32x32.png": "56d0705b7015d3a1b4b868a94d10219b",
"icons/android-icon-96x96.png": "fd35a3e6694bb402ababe5b2296c35fe",
"icons/apple-icon-72x72.png": "99803e1323ade4124dfcf84cb85ec886",
"icons/apple-icon-180x180.png": "277ffe78399365bfe785f45631c43c7c",
"icons/favicon-16x16.png": "dd0d78e438871835f0a7476960a9889d",
"icons/apple-icon-114x114.png": "a4e0272ccd3e4ff4df6c893656d9d9a0",
"icons/apple-icon-57x57.png": "b3bd0fb4425ddffb5864858d03bc0750",
"icons/android-icon-36x36.png": "354601b20e9d9135deb7bde631cbc94a",
"icons/android-icon-144x144.png": "1aac986686d009d36e060c75eed8470a",
"icons/apple-icon-60x60.png": "50cbe24a45189789230ac29acce6fbfb",
"icons/apple-icon-76x76.png": "51d5ea84436603ff418a35ab03626490",
"icons/apple-icon-120x120.png": "bee3ad179b5948f8caff063471d66d8c",
"icons/ms-icon-310x310.png": "10f8c941e8d47b8b3532bebe0ab194b4",
"icons/apple-icon-precomposed.png": "c320335ca6682adfb1569f2b97dfeff7",
"icons/apple-icon-144x144.png": "1aac986686d009d36e060c75eed8470a",
"icons/android-icon-192x192.png": "653ed1c4709fb6842f322c1629ada2fc",
"icons/ms-icon-150x150.png": "3c432ead8760b2e427e598ddf3a4c2e6",
"canvaskit/profiling/canvaskit.js": "ba8aac0ba37d0bfa3c9a5f77c761b88b",
"canvaskit/profiling/canvaskit.wasm": "05ad694fda6cfca3f9bbac4b18358f93",
"canvaskit/canvaskit.js": "687636ce014616f8b829c44074231939",
"canvaskit/canvaskit.wasm": "d4972dbefe733345d4eabb87d17fcb5f",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"index.html": "1feadbdaecb62df521b17e0aeac8c027",
"/": "1feadbdaecb62df521b17e0aeac8c027",
"main.dart.js": "393ec72d0e069a41142bcec1c5c4ef83",
"favicon.ico": "055ebfa457e2817f55e1e695f00ffd40",
"assets/NOTICES": "29f9b2ff45f2f8c71d17d3879a8b6140",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "0ff5c2d72578756a2d288596d5a621dc",
"assets/FontManifest.json": "7482f593ec16383acf82ef81428fec4f",
"assets/AssetManifest.json": "45738b9b20707fc302a9e7b769ba1885",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/breaststroke_w.png": "937d9c8a1fd43380417278d4184b2285",
"assets/assets/images/butterfly.png": "db1adc04dcc3d4c3bf65605d79b68086",
"assets/assets/images/backstroke.png": "02582b4dc29f7de4c1a1ad7239613ad9",
"assets/assets/images/beachhouse.png": "f26244e2215ec232fc71c965f520cba7",
"assets/assets/images/butterfly_w.png": "32c63713b464315d6f818c13aff196e0",
"assets/assets/images/backstroke_w.png": "570eb6e10876ef0eb5c1004630d956c6",
"assets/assets/images/freestyle.png": "a6a5abd015c34ffb0bd09ac55ab03047",
"assets/assets/images/stop_watch_icon.png": "01aebd5792ec3a7e096bbb99803e915b",
"assets/assets/images/whistle_icon.png": "e974f873cc1f6fad74739194e727a436",
"assets/assets/images/breaststroke.png": "440ef1ee88eb3af94e62e4168e0cfb93",
"assets/assets/images/freestyle_w.png": "b8a5510e18894841a9202b43b66de774",
"assets/assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
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
