##Rakuten_review.rb
##中園翔
##

require 'CSV'
require 'net/http'
require 'nkf'
require 'uri'
class Rakuten

def Rakuten::search()
  res = []
  w = 0
  CSV.open("./review.csv",'w') do |writer|
   Net::HTTP.start('review.rakuten.co.jp', 80) {|http|

   for reviews in 1..100 do
      response = http.get("/item/1/241201_10001835/#{reviews}.1/")
        s = response.body.to_s
        s = NKF.nkf('-w',s)

        review = s.scan(/text">(.+?)<\/dd>/)
        score = s.scan(/<span class="eval">(.+?)<\/span>/)
        ageAndSex = s.scan(/font-size:80%">\n(.*)<\/dd>/)
        age = []
        sex = []
        puts ageAndSex.length
        puts review.length
        puts ageAndSex[14]
        for num in 0..ageAndSex.length-1 do
          as = ageAndSex[num][0].split("／")
          puts as
          age[num] = as[0]
          sex[num] = as[1]
        end
        for num in 0..review.length-1
           writer << [review[num],score[num],age[num],sex[num]]
        end
   end
   }
  end
return res
end
end

rak = Rakuten.new
Rakuten::search()
