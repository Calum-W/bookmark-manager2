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
  scenario "tag filters show links with tag" do
    visit('/links/new')
    fill_in 'title', with: 'Bubble shooter'
    fill_in 'url', with: "http://www.shooter-bubble.com"
    fill_in 'tag', with: 'bubbles'
    click_button 'Create link'

    click_button "bubbles"
    expect(page).to have_content "Bubble shooter"

  end
  scenario "tag filters don't show links without tag" do
    visit('/links/new')
    fill_in 'title', with: 'Bubble shooter'
    fill_in 'url', with: "http://www.shooter-bubble.com"
    fill_in 'tag', with: 'bubbles'
    click_button 'Create link'
    visit('/links/new')
    fill_in 'title', with: 'Reddit'
    fill_in 'url', with: "http://www.reddit.com"
    fill_in 'tag', with: 'fun'
    click_button 'Create link'

    visit "/tags/bubbles"
    expect(page).not_to have_content "Reddit"

  end
end
