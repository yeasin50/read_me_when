{{flutter_js}}
{{flutter_build_config}}

const loaderContainer = document.getElementsByClassName("loading_view")[0];

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    // Remove the loading spinner when the app runner is ready
    if (document.body.contains(loaderContainer)) {
      loaderContainer.style.transition = 'opacity 0.5s ease-out'; // Set transition effect
      loaderContainer.style.opacity = '0'; // Start fading out

      // Wait for the transition to complete before removing the element
      setTimeout(() => {
        if (document.body.contains(loaderContainer)) {
          document.body.removeChild(loaderContainer);
        }
      }, 3000);
    }

    await appRunner.runApp();
  }
});