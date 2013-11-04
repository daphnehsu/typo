Given /^the following (.*?) exist:$/ do |input, table|
  # table is a Cucumber::Ast::Table
	table.hashes.each do |item|
		if input=="users"
			User.create!(item)
		elsif input == "articles"
			Article.create!(item)
		elsif input == "comments"
			Comment.create(item)
		end
	end
end

Given /^I am logged in as "(.*?)" with pass "(.*?)"$/ do |user, password|
	visit '/accounts/login'
	fill_in 'user_login', :with => user
	fill_in 'user_password', :with => password
	click_button 'Login'
end

Given /^I have merged articles with id "(.*?)" and id "(.*?)"$/ do |id1, id2|
	article = Article.find_by_id(id1)
	article.merge_with(id2)
end

Then /^the article with id "(.*?)" should have author "(.*?)" or "(.*?)"$/ do |id, author1, author2|
	article = Article.find_by_id(id)
	assert (article.author == author1 || article.author == author2)
end
