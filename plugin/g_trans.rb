# translate.rb
#!/usr/local/bin/ruby
 
# install json
# sudo gem install json
 
$KCODE = 'utf'
require 'pp'
require 'net/http'
require 'uri'
require 'rubygems'
require 'json'
require 'cgi'
 
def translate( string, to, from='en' )
 
  url =
"http://translate.google.ru/translate_a/t?client=x&text={#{string}}&sl={#{from.to_s}}&tl={#{to.to_s}}"
 
  resp = Net::HTTP.get_response( URI.parse( "#{url}" ) )
 
  json = JSON.parse( resp.body )
 
  if json['responseStatus'] == 200
    json['responseData']['translatedText']
  else
    raise StandardError, resp['responseDetails']
  end
end
 
if __FILE__ == $0
  string = ARGV[0] || 'oracle'
  lang = ARGV[1] || 'ru' # Change it to your language.
  puts translate( string, lang  )
end

