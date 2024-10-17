(function enableScrollPreservation() {
	let scrollTop = 0;

	let shouldPreserveScroll = false;

	document.addEventListener("turbo:click", function (event) {
		if (event.target.hasAttribute("data-turbo-preserve-scroll")) {
			shouldPreserveScroll = true;
		} else {
			shouldPreserveScroll = false;
		}
	});

	document.addEventListener("turbo:visit", function () {
		if (shouldPreserveScroll) {
			scrollTop = document.documentElement.scrollTop;
		} else {
			scrollTop = 0;
		}
	});

	addEventListener("turbo:visit", () => {
		if (shouldPreserveScroll) {
			window.Turbo.navigator.currentVisit.scrolled = true;
			document.documentElement.scrollTop = scrollTop;
		}
		shouldPreserveScroll = false;
	});
})();