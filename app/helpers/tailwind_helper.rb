module TailwindHelper
    def container_class(additional_classes = "")
        default_class = 'container mx-auto flex flex-col md:flex-row justify-between items-center'
        "#{default_class} #{additional_classes}"
    end

    def auth_container_class(additional_classes = "")
        default_class = 'flex flex-col items-center justify-center min-h-screen bg-white'
        "#{default_class} #{additional_classes}"
    end

    def auth_box_class(additional_classes = "")
        default_class = 'bg-white shadow-lg rounded px-16 py-20 mb-4 w-full max-w-lg'
        "#{default_class} #{additional_classes}"
    end

    def h1_class(additional_classes = "")
        default_class = 'text-3xl font-bold'
        "#{default_class} #{additional_classes}"
    end

    def input_class(additional_classes = "")
        default_class = 'shadow border border-gray-300 rounded-md w-full py-3 px-4 mt-5 text-gray-700 leading-tight focus:outline-none focus:shadow-outline focus:border-green-700 focus:ring-green-700'
        "#{default_class} #{additional_classes}"
    end

    def button_class(additional_classes = "")
        default_class = 'w-full text-black py-2 px-4 rounded-md border focus:outline-none focus:shadow-outline inline-flex items-center justify-center'
        "#{default_class} #{additional_classes}"
    end

    def link_class(additional_classes = '')
        default_class = 'text-gray-500 hover:underline text-lg'
        "#{default_class} #{additional_classes}"
    end
end