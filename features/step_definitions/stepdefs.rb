module GetTheHomePage
  def get_me_home
    @home
  end
end
World GetTheHomePage

Given("there should be a home page") do
    @home = 'home_page'
  end

  When("I click on the url") do
    @home_page = get_me_home
  end

  Then("I should be directed to the home page {string}") do |home_page|
    expect(@home_page).to.eq(home_page)
  end
