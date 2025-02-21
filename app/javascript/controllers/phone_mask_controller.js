import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static MAX_PHONE_LENGTH = 11
    static PHONE_FORMATS = {
        short: /(\d{2})(\d{4})(\d{0,4})/,
        long: /(\d{2})(\d{5})(\d{0,4})/
    }

    apply(event) {
        const input = event.target
        const cleanedValue = this.cleanPhoneNumber(input.value)
        const formattedValue = this.formatPhoneNumber(cleanedValue)

        input.value = formattedValue
    }

    cleanPhoneNumber(value) {
        return value
            .replace(/\D/g, '')
            .slice(0, this.constructor.MAX_PHONE_LENGTH)
    }

    formatPhoneNumber(value) {
        const isShortFormat = value.length <= 10
        const format = isShortFormat
            ? this.constructor.PHONE_FORMATS.short
            : this.constructor.PHONE_FORMATS.long

        return value.replace(format, (match, areaCode, prefix, suffix) =>
            this.constructFormattedPhone(areaCode, prefix, suffix)
        )
    }

    constructFormattedPhone(areaCode, prefix, suffix) {
        return suffix
            ? `(${areaCode}) ${prefix}-${suffix}`
            : `(${areaCode}) ${prefix}`
    }
}
