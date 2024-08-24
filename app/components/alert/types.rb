# app/components/alert/types.rb
module Alert
    module Types
      STYLES = {
        success: {
          background: "bg-green-100",
          border: "border-green-500",
          text: "text-green-700"
        },
        warning: {
          background: "bg-yellow-100",
          border: "border-yellow-500",
          text: "text-yellow-700"
        },
        error: {
          background: "bg-red-100",
          border: "border-red-500",
          text: "text-red-700"
        },
        info: {
          background: "bg-blue-100",
          border: "border-blue-500",
          text: "text-blue-700"
        }
      }.freeze
    end
  end
  