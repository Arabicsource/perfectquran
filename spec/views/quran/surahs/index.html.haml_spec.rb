require 'rails_helper'

describe 'quran/surahs/index' do

  before(:each) do
    assign(
      :surahs, 
      [
        FactoryGirl.build_stubbed(:surah, transliterated_name: 'First Surah'),
        FactoryGirl.build_stubbed(:surah, transliterated_name: 'Second Surah'),
        FactoryGirl.build_stubbed(:surah, transliterated_name: 'Third Surah')
      ]
    )
  end
  
  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'Suwar')
    
    render   
  end

  it 'has a level one heading' do
    render
    
    expect(rendered).to have_selector 'h1', text: 'Suwar'
  end

  it 'lists each surah' do
    render

    expect(rendered).to have_css 'ol#suwar-index'
    expect(rendered).to have_css 'li.surah', count: 3
    expect(rendered).to have_text 'First Surah'
    expect(rendered).to have_text 'Second Surah'
    expect(rendered).to have_text 'Third Surah'    
  end
end