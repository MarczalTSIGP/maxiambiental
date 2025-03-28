import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="carousel"
export default class extends Controller {
    static targets = ['carousel', 'nextButton', 'prevButton'];

    connect() {
        this.setupEventListeners();
        this.updateUI();
        this.observer = new ResizeObserver(() => this.updateUI());
        this.observer.observe(this.carouselTarget);
    }

    disconnect() {
        this.observer.disconnect();
    }

    next() {
        this.scrollBy(1);
    }

    prev() {
        this.scrollBy(-1);
    }

    // Private
    scrollBy(direction) {
        this.carouselTarget.scrollBy({
            left: direction * this.cardWidth,
            behavior: 'smooth',
        });
    }

    get cardWidth() {
        const card = this.carouselTarget.querySelector('li');
        return (
            card.offsetWidth +
            parseInt(getComputedStyle(card).marginLeft) +
            parseInt(getComputedStyle(card).marginRight) +
            parseInt(
                getComputedStyle(this.carouselTarget).gap.replace('px', ''),
            )
        );
    }

    setupEventListeners() {
        this.carouselTarget.addEventListener(
            'scroll',
            this.updateUI.bind(this),
        );

        window.addEventListener('resize', this.updateUI.bind(this));

        this.carouselTarget.addEventListener(
            'touchstart',
            this.handleTouchStart.bind(this),
        );

        this.carouselTarget.addEventListener(
            'touchend',
            this.handleTouchEnd.bind(this),
        );
    }

    updateUI() {
        const { scrollLeft, clientWidth, scrollWidth } = this.carouselTarget;
        const tolerance = 1;

        this.prevButtonTarget.disabled = scrollLeft <= tolerance;

        this.nextButtonTarget.disabled =
            scrollLeft + clientWidth >= scrollWidth - tolerance;

        this.prevButtonTarget.offsetHeight;
        this.nextButtonTarget.offsetHeight;
    }

    handleTouchStart(e) {
        this.touchStartX = e.changedTouches[0].screenX;
    }

    handleTouchEnd(e) {
        const touchEndX = e.changedTouches[0].screenX;
        if (this.touchStartX - touchEndX > 50) this.next();
        if (this.touchStartX - touchEndX < -50) this.prev();
    }
}
