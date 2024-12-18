# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin 'preserve_scroll', to: 'lib/preserve_scroll.js'

pin "quill", to: 'https://cdn.jsdelivr.net/npm/quill@2.0.0-rc.2/dist/quill.js'
pin "quill-delta-to-html", to: 'https://cdn.jsdelivr.net/npm/quill-delta-to-html@0.12.1/dist/browser/QuillDeltaToHtmlConverter.bundle.min.js'
pin "quill-image-uploader", to: 'https://cdn.jsdelivr.net/npm/quill-image-uploader@1.3.0/dist/quill.imageUploader.min.js'

pin_all_from 'app/javascript/controllers', under: 'controllers'