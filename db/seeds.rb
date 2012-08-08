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


Expression.create(:expression => '(\s[Pp]|^[Pp])[Ii][Ss][Cc][Oo]', :tag_id => Tag.find_by_name('pisco').id )
Expression.create(:expression => '(\s[Pp]|^[Pp])[Ii][Ss][Cc][Oo][Ll][Aa]', :tag_id => Tag.find_by_name('piscola').id )
Expression.create(:expression => '(\s[Tt]|^[Tt])[Ee][Qq][Uu][Ii][Ll][Aa]', :tag_id => Tag.find_by_name('tequila').id )
Expression.create(:expression => '(\s[CcKk]|^[CcKk])[Aa][Rr][Rr][Ee][Tt][Ee] ', :tag_id => Tag.find_by_name('carrete').id )
Expression.create(:expression => '(\s[CcKk]|^[CcKk])[Oo0][Pp][Ee3][Tt][Ee3] ', :tag_id => Tag.find_by_name('copete').id )
Expression.create(:expression => '(\s[Cc]|^[Ca])[Aa][Rr][Rr][Ee][Tt][Ee][Aa][Nn][Dd][Oo] ', :tag_id => Tag.find_by_name('carreteando').id )
Expression.create(:expression => '(\s[Uu]|^[Uu])[Ll][Tt][Rr][Aa][Bb][Aa][Ii][Ll][Aa][Bb][Ll][Ee] ', :tag_id => Tag.find_by_name('ultrabailable').id )
Expression.create(:expression => '(\s[Pp]|^[Pp])[Aa@][Rr][Tt][YyIi] ', :tag_id => Tag.find_by_name('party').id )
Expression.create(:expression => '(\s[Dd]|^[Dd])[Ii][Ss][Cc][Oo0][Tt][Ee3][Qq][Uu][Ee3][Rr][Oo0] ', :tag_id => Tag.find_by_name('discotequero').id )
Expression.create(:expression => '(\s[Ff]|^[Ff])[Oo0][Nn][Dd][Aa@] ', :tag_id => Tag.find_by_name('fonda').id )


#Filtros para eventos Culturales

Expression.create(:expression => '(\s[Ee]|^[Ee])[Xx][Pp][Oo0][SsCc][Ii][Ooó][Nn] ', :tag_id => Tag.find_by_name('exposicion').id )
Expression.create(:expression => '(\s[Cc]|^[Cc])[Hh][Aa][Rr][Ll][Aa@] ', :tag_id => Tag.find_by_name('charla').id )
Expression.create(:expression => '(\s[CckK]|^[CckK])[Aa][Ff][EeéÉ][Cc][Oo0][Nn][Cc][Ee3][Rr][Tt] ', :tag_id => Tag.find_by_name('cafeconcert').id )
Expression.create(:expression => '(\s[Oo0]|^[Oo0])[Bb][Rr][Aa] ', :tag_id => Tag.find_by_name('obra').id )



#Filtros para Musica

Expression.create(:expression => '(\s[CcKk]|^[CcKk])[Oo0][Nn][Cc][Ii][Ee3][Rr][Tt][Oo0] ', :tag_id => Tag.find_by_name('concierto').id )
Expression.create(:expression => '(\s[Tt]|^[Tt])[Oo][CcKk][Aa][Tt][Aa] ', :tag_id => Tag.find_by_name('tocata').id )
Expression.create(:expression => '(\s[Rr]|^[Rr])[Ee3][CcSs][Ii][Tt][Aa@][Ll] ', :tag_id => Tag.find_by_name('recital').id )
Expression.create(:expression => '(\s[Cc]|^[Ca])[Aa][Rr][Rr][Ee][Tt][Ee] ', :tag_id => Tag.find_by_name('carrete').id )
Expression.create(:expression => '(\s[Rr]|^[Rr])[Oo][Cc][Kk] ', :tag_id => Tag.find_by_name('rock').id )


Expression.create(:expression => '(.*)', :tag_id => Tag.find_by_name('todos').id )

