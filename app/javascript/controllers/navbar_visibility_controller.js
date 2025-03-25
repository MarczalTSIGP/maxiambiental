import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static targets = ['logo', 'menu', 'links'];

    connect() {
        this.toggleBackground();
        window.addEventListener('scroll', this.toggleBackground.bind(this));
    }

    disconnect() {
        window.removeEventListener('scroll', this.toggleBackground.bind(this));
    }

    toggleBackground() {
        const isMobile = window.innerWidth < 768;

        if (window.scrollY > 50) {
            !isMobile && this.logoTarget.classList.remove('hidden');
            this.setNavClasses(['bg-white', 'shadow-md'], ['bg-transparent']);
            this.setLinksColor('text-green-700', 'text-white');
        } else {
            this.logoTarget.classList.add('hidden');
            this.setNavClasses(['bg-transparent'], ['bg-white', 'shadow-md']);
            this.setLinksColor('text-white', 'text-green-700');
        }
    }

    setNavClasses(addClasses, removeClasses) {
        addClasses.forEach((className) => this.element.classList.add(className));
        removeClasses.forEach((className) =>
            this.element.classList.remove(className),
        );
    }

    setLinksColor(addClass, removeClass) {
        this.linksTargets.forEach((link) => {
            link.classList.add(addClass);
            link.classList.remove(removeClass);
        });
    }

    toggleMenu() {
        this.menuTarget.classList.toggle('hidden');
    }
}
