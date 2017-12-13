feature 'Adding tags' do
  scenario "single tags can be added to links as they're created" do
    visit('/links/new')
    fill_in 'title', with: 'Reddit'
    fill_in 'url', with: "http://www.reddit.com"
    fill_in 'tag', with: 'fun'

    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('fun')
  end
end
