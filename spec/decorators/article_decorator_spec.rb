require 'spec_helper'

describe ArticleDecorator do
  describe '#created_at_formatted' do
    it 'formats created_at' do
      article = Fabricate.build(:article) do
        created_at {'1/1/2019'}
      end.decorate
      expect(article.created_at_formatted).to eq('01/01/2019 - 00:00')
    end
  end

  describe '#comments_count' do
    it 'displays comment count' do
      article = Fabricate(:article) do
        comments { Array.new(2) { Fabricate(:comment) } }
      end.decorate
      expect(article.comments_count).to eq('2 Comments')
    end
  end

  describe '#to_json' do
    let(:article) { Fabricate.build(:article).decorate }
    context 'as regular user' do
      it 'returns json' do
        stub_current_user_is_admin false
        expect(article.to_json).to eq(
          article.object.slice(:title, :body, :created_at).to_json
        )
      end
    end

    context 'as admin user' do
      it 'renders json' do
        stub_current_user_is_admin true
        expect(article.to_json).to eq(
          article.object.slice(:title, :body, :created_at, :updated_at).to_json
        )
      end
    end
  end

  def stub_current_user_is_admin(is_admin)
    allow(helper).to receive(:current_user_is_admin?)
      .and_return(is_admin.to_s == 'true')
  end
end
