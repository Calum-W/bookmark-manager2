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

  scenario "multiple tags can be added as links are created" do
    visit('/links/new')
    fill_in 'title', with: 'BBC'
    fill_in 'url', with: "http://www.bbc.co.uk"
    fill_in 'tag', with: 'news football'

    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('news', 'football')
  end

  scenario 'I can filter links by tag' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])
    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
    Link.create(url: 'http://www.zombo.com', title: 'This is Zombocom', tags: [Tag.first_or_create(name: 'bubbles')])
    Link.create(url: 'http://www.bubble-bobble.com', title: 'Bubble Bobble', tags: [Tag.first_or_create(name: 'bubbles')])

    visit '/tags/bubbles'
    expect(page.status_code).to eq(200)
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
      expect(page).to have_content('This is Zombocom')
      expect(page).to have_content('Bubble Bobble')
    end
  end
end
