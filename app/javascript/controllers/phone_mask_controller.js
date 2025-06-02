import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static MAX_PHONE_LENGTH = 11;

    apply(event) {
        const input = event.target;
        const cursorPosition = input.selectionStart;
        const cleanedValue = this.cleanPhoneNumber(input.value);
        const formattedValue = this.formatPhoneNumber(cleanedValue);

        const wasAtEnd = cursorPosition === input.value.length;

        input.value = formattedValue;

        const newPosition = wasAtEnd
            ? formattedValue.length
            : this.calculateNewPosition(formattedValue, cursorPosition);

        input.setSelectionRange(newPosition, newPosition);
    }

    calculateNewPosition(formattedValue, oldPosition) {
        let digitCount = 0;
        for (let i = 0; i < oldPosition; i++) {
            if (/\d/.test(formattedValue[i])) digitCount++;
        }

        let newPosition = 0;
        let counted = 0;
        for (let i = 0; i < formattedValue.length; i++) {
            if (counted >= digitCount) break;
            if (/\d/.test(formattedValue[i])) counted++;
            newPosition = i + 1;
        }

        return newPosition;
    }

    cleanPhoneNumber(value) {
        return value.replace(/\D/g, '').slice(0, this.constructor.MAX_PHONE_LENGTH);
    }

    formatPhoneNumber(value) {
        if (!value) return '';

        const areaCode = value.substring(0, 2);
        const rest = value.substring(2);

        if (rest.length <= 4) {
            return `(${areaCode}) ${rest}`;
        } else if (rest.length <= 9) {
            return `(${areaCode}) ${rest.substring(
                0,
                rest.length - 4,
            )}-${rest.substring(rest.length - 4)}`;
        }

        return value;
    }
}
