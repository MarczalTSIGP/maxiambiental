# frozen_string_literal: true

require "test_helper"

class Home::HeroSection::HeroSectionComponentTest < ViewComponent::TestCase
  def test_should_renders_a_title
    render_inline(Home::HeroSection::HeroSectionComponent.new)
    assert_selector("h1", text: "Maxiambiental Treinamentos")
  end

  def test_should_renders_a_subtitle
    render_inline(Home::HeroSection::HeroSectionComponent.new)
    assert_selector("h2", text: "Transformando Conhecimento Ambiental em Ação")
  end


  def test_should_renders_a_link_to_know_more
    render_inline(Home::HeroSection::HeroSectionComponent.new)
    assert_selector("a", text: "Saiba mais")
  end
end
