(function pwaServiceWorker() {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker
            .register('/service-worker.js')
            .then((registration) => {
                console.log('ServiceWorker registered: ', registration);
            })
            .catch((error) => {
                console.error('ServiceWorker registration failed: ', error);
            });
    } else {
        console.log('Service workers are not supported in this browser.');
    }
})();
