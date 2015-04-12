# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
	Movie.create movie	
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
	assert page.body =~ /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
if uncheck == "un"
	rating_list.split(', ').each{
		|x| step %{I uncheck "ratings_#{x}"}
	}
else 
	rating_list.split(', ').each{
		|x| step %{I check "ratings_#{x}"}
	}
end

end
Then /I should not see any of the movies/ do
	rows = page.all('#movies tr').size -1 
	assert rows = 0
end

Then /I should see all the movies/ do
	rows = page.all('#movies tr').size
	movs = Movie.count() -1
	#puts "
	assert movs == rows-2
end
