feature 'tab bar' do
  feature 'visiting the homepage' do
    scenario 'the page titles is visible' do
      visit '/'
      expect(page).to have_content "Home list of spaces Make a listing Sign in Sign up"

    end
    scenario 'press home link' do
      visit '/'
      click_link('Home')
      expect(page).to have_content "Home list of spaces Make a listing Sign in Sign up"
    end
    scenario 'press list of spaces link' do
      visit '/'
      click_link('list of spaces')
      expect(page).to have_content "Home list of spaces Make a listing Sign in Sign up"

    end
  end
  scenario 'make a listing' do
    visit '/make_listing'
    expect(page).to have_content "Add a space"
    fill_in('Description', with: 'John')
    fill_in('Price Per Night', with: 'Seekrit')
    fill_in('Dates Avaliable', with: 'Really Long Text…')
    fill_in('Availability', with: 'true')
    fill_in('Location', with: 'anywhere')
    click_button("Submit")
  end
  scenario 'sign up' do
    visit '/sign_up'
    expect(page).to have_content "Sign Up"
    fill_in('full_name', with: 'John f')
    fill_in('username', with: 'John')
    fill_in('password', with: 'Seekrit')
  end
  scenario 'sign in' do
    visit '/sign_in'
    expect(page).to have_content "Sign in"
    fill_in('username', with: 'John')
    fill_in('password', with: 'Seekrit')
  end


end
