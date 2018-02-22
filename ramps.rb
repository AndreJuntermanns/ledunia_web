require 'net/http'
require 'uri'

class Ramps

def initialize(col_rArr,col_gArr,col_bArr,nap,runs)
@col_rArr=col_rArr
@col_gArr=col_gArr
@col_bArr=col_bArr
@nap=nap
@runs=runs

rot,gruen,blau,nap,runs =nil

def sin_loop()
index = 0
nachunten = false


@runs.times do

  if index < @col_rArr.size 
    if nachunten != true
      index +=1
      @col_r = @col_rArr[index]
      @col_g = @col_gArr[index]
      @col_b = @col_bArr[index]
    end
  elsif index == @col_rArr.size
      @col_r = @col_rArr[index]
      @col_g = @col_gArr[index]
      @col_b = @col_bArr[index]
      nachunten = true
  end

  if index > 0
    if nachunten == true
      index-=1
      @col_r = @col_rArr[index]
      @col_g = @col_gArr[index]
      @col_b = @col_bArr[index]
  end 
  elsif index == 0  
    index+=1
    @col_r = @col_rArr[index]
    @col_g = @col_gArr[index]
    @col_b = @col_bArr[index]
    nachunten = false
    rand_num_r = rand(10)
    rand_num_g = rand(20)
    rand_num_b = rand(30)
      if not rand_num_r.even?
        @col_rArr=@col_rArr.reverse
      end
      if not rand_num_g.even?
        @col_gArr=@col_gArr.reverse
      end
      if not rand_num_b.even?
        @col_bArr=@col_bArr.reverse
      end       
end
uri = URI.parse("http://192.168.4.1/solidColor?r="+"#{@col_r}"+"&g="+"#{@col_g}"+"&b="+"#{@col_b}")
header = {'Content-Type': 'text/json'}
#color = "/solidColor?r=255&g=255&b=255"
# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
response = http.request(request)

sleep(@nap)
puts uri
end
end
sin_loop()
end
end

