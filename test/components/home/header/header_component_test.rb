# frozen_string_literal: true

require "test_helper"

class Home::Header::HeaderComponentTest < ViewComponent::TestCase
  def test_should_renders_a_navbar
    render_inline(Home::Header::HeaderComponent.new)
    assert_selector("nav")
  end

  def test_should_renders_a_navbar_with_a_list_of_links
    render_inline(Home::Header::HeaderComponent.new)

    assert_selector('ul')

    assert_selector('li', text: "Cursos")
    assert_selector('li', text: "Galeria de Fotos")
    assert_selector('li', text: "Sobre Nós")
    assert_selector('li', text: "Fale Conosco")
  end

  def test_should_renders_a_navbar_with_link_to_login
    render_inline(Home::Header::HeaderComponent.new)

    assert_selector('a', text: "Entrar")
  end

  def test_should_renders_a_navbar_with_link_to_register
    render_inline(Home::Header::HeaderComponent.new)

    assert_selector('a', text: "Cadastrar")
  end

  def test_should_renders_a_sidebar
    render_inline(Home::Header::HeaderComponent.new)

    assert_selector("aside")
  end
end
