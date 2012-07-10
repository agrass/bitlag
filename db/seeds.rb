# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tag.create(:name =>'fiesta')
Tag.create(:name =>'concierto')
Tag.create(:name =>'teatro')
Tag.create(:name =>'cine')
Tag.create(:name =>'arte')
Tag.create(:name =>'todos')
Expression.create(:expression => '(\s[Ff]|^[Ff])[Ii][Ee][Ss][Tt][Aa]', :tag_id => Tag.find_by_name('fiesta').id )
Expression.create(:expression => '(\s[Cc]|^[Cc])[Aa][Rr][Rr][Ee][Tt][Ee]' , :tag_id => Tag.find_by_name('fiesta').id)
Expression.create(:expression => '(\s[Cc]|^[Cc])[Oo][Nn][Cc][Ii][Ee][Rr][Tt][Oo]', :tag_id => Tag.find_by_name('concierto').id )
Expression.create(:expression => '(\s[Tt]|^[Tt])[Oo][Cc][Aa][Tt][Aa]', :tag_id => Tag.find_by_name('concierto').id )
Expression.create(:expression => '(\s[Tt]|^[Tt])[Ee][Aa][Tt][Rr][Oo]' , :tag_id => Tag.find_by_name('teatro').id)
Expression.create(:expression => '(\s[Cc]|^[Cc])[Ii][Nn][Ee]' , :tag_id => Tag.find_by_name('cine').id)
Expression.create(:expression => '(\s[Aa]|^[Aa])[Rr][Tt][Ee]' , :tag_id => Tag.find_by_name('arte').id)
Expression.create(:expression => '(.*)', :tag_id => Tag.find_by_name('todos').id )
