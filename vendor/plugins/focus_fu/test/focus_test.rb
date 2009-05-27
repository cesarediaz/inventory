[ 'rubygems', 'test/unit', 'action_pack', 'active_support' ].each{ |f| require f }
require 'action_controller'
require 'action_controller/assertions'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'focus'

class FocusTest < Test::Unit::TestCase
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::JavaScriptHelper
  include ActionView::Helpers::TagHelper
  include ActionController::Assertions::DomAssertions

  include Focus::FormHelpers
  
  Post = Struct.new('Post', :title, :body, :attachment, :published, :category)
  
  def setup
    @post = Post.new
    @post.title, @post.body, @post.published, @post.category = 'foo', 'bar', true, 'rails'
  end
  
  def test_text_field_normal
    assert_dom_equal(%Q(<input id="post_title" name="post[title]" size="30" type="text" value="foo" />),
                     text_field_without_focus(:post, :title))
  end

  def test_text_field_with_focus
    assert_dom_equal(text_field_without_focus(:post, :title) + "\n" + javascript_tag("$('post_title').focus()"),
                     text_field_with_focus(:post, :title, :focus => true))
  end
  
  def test_text_field_tag_normal
    assert_dom_equal(%Q(<input id="title" name="title" type="text" value="foo" />),
                     text_field_tag_without_focus(:title, @post.title))
  end
  
  def test_text_field_tag_with_focus
    assert_dom_equal(text_field_tag_without_focus(:title, @post.title) + "\n" + javascript_tag("$('title').focus()"),
                     text_field_tag_with_focus(:title, @post.title, :focus => true))
  end
  
  def test_password_field_normal
    assert_dom_equal(%Q(<input id="post_title" name="post[title]" size="30" type="password" value="foo" />),
                     password_field_without_focus(:post, :title))
  end

  def test_password_field_with_focus
    assert_dom_equal(password_field_without_focus(:post, :title) + "\n" + javascript_tag("$('post_title').focus()"),
                     password_field_with_focus(:post, :title, :focus => true))
  end

  def test_password_field_tag_normal
    assert_dom_equal(%Q(<input id="title" name="title" type="password" value="foo" />),
                     password_field_tag_without_focus(:title, @post.title))
  end
  
  def test_password_field_tag_with_focus
    assert_dom_equal(password_field_tag_without_focus(:title, @post.title) + "\n" + javascript_tag("$('title').focus()"),
                     password_field_tag_with_focus(:title, @post.title, :focus => true))
  end
  
  def test_file_field_normal
    assert_dom_equal(%Q(<input id="post_attachment" name="post[attachment]" size="30" type="file" />),
                     file_field_without_focus(:post, :attachment))
  end

  def test_file_field_with_focus
    assert_dom_equal(file_field_without_focus(:post, :attachment) + "\n" + javascript_tag("$('post_attachment').focus()"),
                     file_field_with_focus(:post, :attachment, :focus => true))
  end
 
  def test_file_field_tag_normal
    assert_dom_equal(%Q(<input id="attachment" name="attachment" type="file" />),
                     file_field_tag_without_focus(:attachment))
  end

  def test_file_field_tag_with_focus
    assert_dom_equal(file_field_tag_without_focus(:attachment) + "\n" + javascript_tag("$('attachment').focus()"),
                     file_field_tag_with_focus(:attachment, :focus => true))
  end
  
  def test_text_area_normal
    assert_dom_equal(%Q(<textarea id="post_body" name="post[body]" rows="20" cols="40">bar</textarea>),
                     text_area_without_focus(:post, :body))
  end

  def test_text_area_with_focus
    assert_dom_equal(text_area_without_focus(:post, :body) + "\n" + javascript_tag("$('post_body').focus()"),
                     text_area_with_focus(:post, :body, :focus => true))
  end
  
  def test_text_area_field_normal
    assert_dom_equal(%Q(<textarea id="body" name="body">bar</textarea>),
                     text_area_tag_without_focus(:body, @post.body))
  end

  def test_text_area_field_with_focus
    assert_dom_equal(text_area_tag_without_focus(:body, @post.body) + "\n" + javascript_tag("$('body').focus()"),
                     text_area_tag_with_focus(:body, @post.body, :focus => true))
  end

  def test_check_box_normal
    assert_dom_equal(%Q(<input name="post[published]" checked="checked" type="checkbox" id="post_published" value="1" /><input name="post[published]" type="hidden" value="0" />),
                     check_box_without_focus(:post, :published))
  end

  def test_check_box_with_focus
    assert_dom_equal(check_box_without_focus(:post, :published) + "\n" + javascript_tag("$('post_published').focus()"),
                     check_box_with_focus(:post, :published, :focus => true))
  end
  
  def test_check_box_tag_normal
    assert_dom_equal(%Q(<input name="published" checked="checked" type="checkbox" id="published" value="1" />),
                     check_box_tag_without_focus(:published, 1, @post.published))
  end

  def test_check_box_tag_with_focus
    assert_dom_equal(check_box_tag_without_focus(:published, 1, @post.published) + "\n" + 
                     javascript_tag("$('published').focus()"),
                     check_box_tag_with_focus(:published, 1, @post.published, :focus => true))
  end
  
  def test_radio_button_normal
    assert_dom_equal(%Q(<input name="post[category]" type="radio" id="post_category_python" value="python" />),
                     radio_button_without_focus(:post, :category, 'python'))
  end
  
  def test_radio_button_with_focus
    assert_dom_equal(radio_button_without_focus(:post, :category, 'python') + "\n" +
                     javascript_tag("$('post_category_python').focus()"),
                     radio_button_with_focus(:post, :category, 'python', :focus => true))
  end
  
  def test_radio_button_tag_normal
    assert_dom_equal(%Q(<input name="category" type="radio" id="category_python" value="python" />),
                     radio_button_tag_without_focus(:category, 'python', false))
  end
  
  def test_radio_button_tag_with_focus
    assert_dom_equal(radio_button_tag_without_focus(:category, 'python', false) + "\n" +
                     javascript_tag("$('category_python').focus()"),
                     radio_button_tag_with_focus(:category, 'python', false, :focus => true))
  end
  
  def test_select_normal
    assert_dom_equal(%Q(<select name="post[title]" id="post_title"><option selected="selected" value="foo">foo</option>\n<option value="bar">bar</option></select>), select_without_focus(:post, :title, %w( foo bar )))
  end

  def test_select_with_focus
    assert_dom_equal(select_without_focus(:post, :title, %w( foo bar )) + "\n" + javascript_tag("$('post_title').focus()"),
                     select_with_focus(:post, :title, %w( foo bar ), :focus => true))
  end
  
  def test_select_tag_normal
    assert_dom_equal(%Q(<select name="title" id="title"><option selected="selected" value="foo">foo</option>\n<option value="bar">bar</option></select>), select_tag_without_focus(:title, options_for_select( %w(foo bar), @post.title)))
  end

  def test_select_tag_with_focus
    assert_dom_equal(select_tag_without_focus(:title, options_for_select( %w(foo bar), @post.title)) + "\n" +
                     javascript_tag("$('title').focus()"),
                     select_tag_with_focus(:title, options_for_select( %w(foo bar), @post.title), :focus => true))
  end
  
end