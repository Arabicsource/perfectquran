require 'rails_helper'

describe 'quran/surahs/show' do
  before(:each) do
    surah = FactoryGirl.build_stubbed :surah, transliterated_name: 'abc123'
    allow(surah).to receive(:ayahs).and_return([
      FactoryGirl.build_stubbed(:ayah, number: 1),
      FactoryGirl.build_stubbed(:ayah, number: 2),
      FactoryGirl.build_stubbed(:ayah, number: 3)
    ])
    allow(surah).to receive(:previous).and_return(1)
    allow(surah).to receive(:next).and_return(3)
    assign :surah, surah
  end
  
  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'abc123')
    
    render   
  end

  it 'has a level one heading' do
    render
    
    expect(rendered).to have_selector 'h1', text: 'abc123'
  end

  it 'renders a breadcrumb' do
    render

    expect(rendered).to have_css '.breadcrumb'
  end

  it 'has a previous surah link' do
    render

    expect(rendered).to have_link 'Previous'
  end

  it 'has a next surah link' do
    render

    expect(rendered).to have_link 'Next'
  end

  it 'has an audio player tag' do
    render
    
    expect(rendered).to have_selector 'audio'
  end

  it 'lists each ayah' do
    render

    expect(rendered).to have_css 'article#surah'
    expect(rendered).to have_css 'article.ayah', count: 3
    expect(rendered).to have_link 'abc123 1'
    expect(rendered).to have_link 'abc123 2'
    expect(rendered).to have_link 'abc123 3'   
  end
end