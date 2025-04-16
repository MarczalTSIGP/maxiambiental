class Search::FormComponent < ViewComponent::Base
  def initialize(base_url:)
    super()
    @base_url = base_url
  end

  private

  def term
    params[:term]&.strip
  end

  def input_options
    {
      value: term,
      data: {
        search_target: 'input',
        action: 'input->search#clearCheck'
      }
    }.compact
  end

  def form_options
    {
      controller: 'search',
      action: 'submit->search#search',
      search_base_url_value: @base_url
    }
  end
end
