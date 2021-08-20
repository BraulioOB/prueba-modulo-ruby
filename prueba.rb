#szD6cRBcmJUEcGIAeKNL27Li7VIyLnxttdWXzaQf
#https://api.nasa.gov/planetary/apod?api_key=szD6cRBcmJUEcGIAeKNL27Li7VIyLnxttdWXzaQf
# Account Email: sific15195@fxseller.com
# Account ID: 1aeca1e1-8485-47b6-9b24-2555bd1d4ec8

# https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=szD6cRBcmJUEcGIAeKNL27Li7VIyLnxttdWXzaQf

require "json"
require "uri"
require "net/http"

def request (src, api_key)
    url = URI(src + "&api_key=" + api_key)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    return JSON.parse response.read_body
end

def buid_web_page (hash)
    template = [
        '<!DOCTYPE html>',
        '<html lang="en">',
        '<head>',
            '<meta charset="UTF-8">',
            '<meta http-equiv="X-UA-Compatible" content="IE=edge">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '<title>Mars Photos</title>',
        '</head>',
        '<body>',
            '<ul>',
                '!li',
            '</ul>',
        '</body>',
        '</html>'
    ]
    
    img_array = []
    hash["photos"].each do |img_url|
        # img_array.append "<li><img src='#{img_url["img_src"]}'></li>"
        img_array = img_url.select{|k,v| k == "img_src"}
    end
    
    file = File.open("index.html", "w")
    template.each do |line|
        if line != '!li'
            file.puts(line)
        else
            img_array.each do |li_img|
                file.puts(li_img)
            end
        end
    end

    file.close

end

# def photos_count (hash)
#     img_array = []
#     hash["photos"].each do |img_url|
#         img_array.append "<li><img src='#{img_url["img_src"]}'></li>"
#     end
# end

u = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10"
k = "szD6cRBcmJUEcGIAeKNL27Li7VIyLnxttdWXzaQf"

r = request u, k
buid_web_page (r)