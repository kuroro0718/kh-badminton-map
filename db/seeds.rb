puts "This seed file will create 100 posts with 10 different address"

city = '高雄市'
district_table = ['左營區', '小港區', '三民區', '鼓山區', '前金區', '前鎮區', '新興區', '苓雅區', '楠梓區', '大社區']
road = '文學路330巷44號'

create_posts = for i in 0..99 do
  Post.create!([title: "球聚#{i}", address: city+district_table[Random.new.rand(9)]+road])
end