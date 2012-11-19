# rake FEATURE=features/merge_article.feature cucumber
Given /the following articles exist/ do |contents|
  contents.hashes.each do |article|
    Article.create!(:title => article[:title], 
                    :published => article[:published], 
                    :author => article[:author],
                    :body => article[:body],
                    :id => article[:id])
  end
end

When /^I fill in "(.*?)" with (\d+)$/ do |field, value|
  fill_in(field, :with => value)
end
