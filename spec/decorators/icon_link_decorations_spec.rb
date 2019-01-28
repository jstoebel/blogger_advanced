require 'spec_helper'

class DummyObject
  include IconLinkDecorations
  def initialize(helper_spy, object_double)
    @helper_spy = helper_spy
    @object_double = object_double
  end

  def h
    @helper_spy
  end

  def object
    @object_double
  end
end

describe IconLinkDecorations do
  let(:helper_spy) { double('helper_spy') }
  let(:object_double) { 'my object' }
  let(:image) { 'my image' }
  let(:path) { double('path') }
  let(:obj) { DummyObject.new helper_spy, object_double }
  describe '#delete_icon' do
    let(:options) { { method: :delete, confirm: "Delete 'my object'?" } }

    before(:each) do
      expect(helper_spy).to receive(:polymorphic_path)
        .with(object_double)
        .and_return(path)
    end
    it 'displays a delete icon' do
      expect(helper_spy).to receive(:link_to).with(image, path, options)

      expect(helper_spy).to receive(:image_tag)
        .with('cancel.png')
        .and_return(image)

      obj.delete_icon
    end

    it 'displays a delete icon with text' do
      extra_text = 'my extra text'
      expect(helper_spy).to receive(:link_to)
        .with("#{image} #{extra_text}", path, options)

      expect(helper_spy).to receive(:image_tag)
        .with('cancel.png')
        .and_return(image)

      obj.delete_icon extra_text
    end
  end

  describe '#edit_icon' do
    before(:each) do
      expect(helper_spy).to receive(:edit_polymorphic_path)
        .with(object_double)
        .and_return(path)
    end
    it 'displays an edit icon' do
      expect(helper_spy).to receive(:image_tag)
        .with('page_edit.png')
        .and_return(image)

      expect(helper_spy).to receive(:link_to).with(image, path)

      obj.edit_icon
    end

    it 'displays an edit icon with text' do
      extra_text = 'extra text'
      expect(helper_spy).to receive(:image_tag)
        .with('page_edit.png')
        .and_return(image)

      expect(helper_spy).to receive(:link_to)
        .with("#{image} #{extra_text}", path)

      obj.edit_icon 'extra text'
    end
  end
end
