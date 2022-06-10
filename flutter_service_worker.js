'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "24b7f51826db51886d6a620f86d2afd1",
"/": "24b7f51826db51886d6a620f86d2afd1",
"manifest.json": "d972698b08eea4363fbc1eb84e4112de",
"splash/img/dark-2x.png": "2333a1ea1f3ece57279f33777e50d743",
"splash/img/dark-1x.png": "f38855856eed656f9736611975e3cd85",
"splash/img/dark-3x.png": "7c7362af81ab04c0fb86f941d0ef0d2c",
"splash/img/light-4x.png": "e3e84e8727131d3ca77ce19feb8c6797",
"splash/img/dark-4x.png": "e3e84e8727131d3ca77ce19feb8c6797",
"splash/img/light-1x.png": "f38855856eed656f9736611975e3cd85",
"splash/img/light-2x.png": "2333a1ea1f3ece57279f33777e50d743",
"splash/img/light-3x.png": "7c7362af81ab04c0fb86f941d0ef0d2c",
"splash/style.css": "b78354eb2b5660c45ba5780a7bb861f9",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "0fda6109989028872733c622b4f2f9b7",
"assets/AssetManifest.json": "87238e8a95d1881bf0d785a7b437eec0",
"assets/assets/drawable/Load/default.jpg": "7630955ff829ce1348e43f66a07151e9",
"assets/assets/drawable/Settings/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/Title/Ocean.jpg": "af102b47f1dc15005311b886018aa959",
"assets/assets/drawable/Title/Lion.jpg": "6f4304ebf9a572c03e2c2eac426111df",
"assets/assets/drawable/Title/default.jpg": "7630955ff829ce1348e43f66a07151e9",
"assets/assets/drawable/Title/wsharp_banner_expanded.png": "40f19b8be8e59504116bbe02ee9f2bf8",
"assets/assets/drawable/appIcon.png": "8630d1d5b2f3a7f8f5f972794e21a32d",
"assets/assets/drawable/CharacterImage/Ayana/angry(eyeOpend).png": "28a9cc93729f665883f19179f2454ba9",
"assets/assets/drawable/CharacterImage/Ayana/flat(eyeClosed-mouthOpend).png": "f1fca6f44302809b69f6c9e1f787441a",
"assets/assets/drawable/CharacterImage/Ayana/puzzled(eyeOpend).png": "8a2c3113539ed8c0c4f01fe076996223",
"assets/assets/drawable/CharacterImage/Ayana/angry(eyeClosed).png": "33130a19a41898335768bd79d4a32ff4",
"assets/assets/drawable/CharacterImage/Ayana/flat(eyeOpend-mouthOpend).png": "47ad30c653d91721e31baf41ca4a52ff",
"assets/assets/drawable/CharacterImage/Ayana/puzzled(eyeClosed).png": "c4c62852b38c378095cdf64c0bcf9901",
"assets/assets/drawable/CharacterImage/Ayana/smiled(eyeClosed).png": "32eb8539d9b98f2adbd6ec5a3a0303c1",
"assets/assets/drawable/CharacterImage/Ayana/normal.png": "0de3626f6ef7f3702dbb38b41539c035",
"assets/assets/drawable/CharacterImage/Ayana/flat(eyeClosed-mouthClosed).png": "5c3a5bf26570a37807df34fddd1ebf65",
"assets/assets/drawable/CharacterImage/Ayana/flat(eyeOpend-mouthClosed).png": "e5676cbd4a84e96f779b221044695f7a",
"assets/assets/drawable/CharacterImage/Nonono/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/CharacterImage/Sakaki/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/Conversation/001_stationBB.png": "77bd1f05580883dfe9ac7647b02ae8b7",
"assets/assets/drawable/Conversation/004_corridorBB.png": "ae7f3d9a4a54c5ccbc3347d7f2cd8710",
"assets/assets/drawable/Conversation/003_cafeBB.png": "2f6f7fe7fb1d6609afc0a0b84608002e",
"assets/assets/drawable/Conversation/icon_sakaki.png": "c9c7bc2250f6193c4c49809d9b84a864",
"assets/assets/drawable/Conversation/background_sample1.jpg": "d76d34323544a82c193ca7564b8db97f",
"assets/assets/drawable/Conversation/000_skyBB.png": "344b7cd3b7388deba96519ef19ed73e1",
"assets/assets/drawable/Conversation/005_flat_roomBB.png": "4ed3fa2e556d8a814d6a3ef45f2dd40f",
"assets/assets/drawable/Conversation/background_sample2.jpg": "66f24712c1911596ce910c512b93503d",
"assets/assets/drawable/Conversation/black_screen.png": "7a24ed37028d3190d02637860a841bf1",
"assets/assets/drawable/Conversation/no_character.png": "98971fd3e87051ac781ef631a6779a1c",
"assets/assets/drawable/Conversation/icon_nonono.png": "1c677a77dcbe92920fa5d7b0fc955f67",
"assets/assets/drawable/Conversation/character_sample1.png": "c830d9109c0895dfb44d69acc0b72381",
"assets/assets/drawable/Conversation/character_sample2.png": "1cb8216b2e8cbeac98c3f1f1a061d629",
"assets/assets/drawable/Conversation/4k.jpg": "87702329d2abc7b3f09e29e365019cd2",
"assets/assets/drawable/Conversation/button_sample.png": "1c0b21ea1b946257c8f65e3cd106e211",
"assets/assets/drawable/Conversation/icon_unknown.png": "ef7eed464344c794c02268bd80fe71df",
"assets/assets/drawable/Conversation/icon_ayana.png": "7fef52ae5f7b75be9a218c744fb6f5c9",
"assets/assets/drawable/Conversation/002_classroomBB.png": "b09e53059b3105ed69c0fd8c3e9ec056",
"assets/assets/drawable/Dialogs/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/Home/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/Menu/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/NowLoading/LoadingAnimation.gif": "8f02038e5e82da3474322bd797a0355f",
"assets/assets/drawable/SelectAction/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/drawable/Splash/splash.png": "23d8d55108014e3a42446f2d4e3a84f0",
"assets/assets/drawable/Splash/Wsharp.png": "47763ee8524626c369b93a4d271b176d",
"assets/assets/drawable/ActionResult/PlaceHolder": "ec1eca5992fef5a5eb244ef9a42c93bb",
"assets/assets/sound/BGM/Full-bloomer.mp3": "30e126a60d2a3a66e12d41ba8ccded48",
"assets/assets/sound/SE/PlaceHolder": "6e0c667e47f3a2a9209047c28d30841a",
"assets/assets/sound/UISound/next.mp3": "59202203a8912f1302eb3e33f59d17bb",
"assets/assets/sound/UISound/pushButton.mp3": "b0660e39f869d3d8f360d42079bc55c9",
"assets/assets/sound/CharacterVoice/voice_sample_007.wav": "9600fbe51bf0587fe3532d066b248a49",
"assets/assets/sound/CharacterVoice/voice_sample_006.wav": "0af46f774c54a376ea5cdb86d7c61e76",
"assets/assets/sound/CharacterVoice/voice_sample_009.wav": "afeb5d38e37f11ee4cfd9c506ea2ac21",
"assets/assets/sound/CharacterVoice/voice_sample_000.wav": "660cd0a599afbec057554a1be4cf66bb",
"assets/assets/sound/CharacterVoice/voice_sample_002.wav": "49e7f3c05e8d6253ff0fd2fe653581c7",
"assets/assets/sound/CharacterVoice/voice_sample_004.wav": "bad157eaf2171f2c7c5bdad4832b3243",
"assets/assets/sound/CharacterVoice/voice_sample_010.wav": "15d1d477f4cd8a4cb3f5351987ca01d1",
"assets/assets/sound/CharacterVoice/voice_sample_001.wav": "29b1cbd99a9f14aaf78ba8d06ccc0720",
"assets/assets/sound/CharacterVoice/voice_sample_003.wav": "142979a18fe7ea8f802e28608e27e9c1",
"assets/assets/sound/CharacterVoice/voice_sample_005.wav": "beebacc855a77df212b22c8ce45130aa",
"assets/assets/sound/CharacterVoice/voice_sample_008.wav": "b546f5ac1c9c1d591bfd248485b06d28",
"assets/assets/text/ScenarioData/ChapterTest/event1.json": "3330dc6cf7ed1ed84559a960d1e84428",
"assets/assets/text/ScenarioData/ChapterTest/102.json": "9b82a13e23a82c6ada48116af802e372",
"assets/assets/text/fonts/SourceHanSansJP-Normal.otf": "986cc3340d690c00b334783d01324e70",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "db4e209bd9f75846d29167bee0d80a66",
"favicon.png": "c12456f3809b82934ca0361a604fdbca",
"version.json": "f8d3d797d2ab6148e5ded49ef4920624",
"main.dart.js": "0f48252b018ba2e9f958e6e2991a5aad",
"icons/Icon-maskable-512.png": "2de6ad4ac35dac99910bd6d2e900ef0e",
"icons/Icon-maskable-192.png": "c6472e0e5e2321fa2995bc3a4e65d54c",
"icons/Icon-192.png": "c6472e0e5e2321fa2995bc3a4e65d54c",
"icons/Icon-512.png": "2de6ad4ac35dac99910bd6d2e900ef0e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
