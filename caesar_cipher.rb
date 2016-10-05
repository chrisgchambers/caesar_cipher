require 'sinatra'
require 'sinatra/reloader' if development?
get '/' do
  erb :index, :locals =>  {
    :code_output => nil,
    :shift_by => nil,
    :plain_text => nil
  }
end

post '/' do
  plain_text = params["plain_text"]
  shift_by = params["shift_by"].to_i
  code_output = plain_text ? caesar_cipher(plain_text, shift_by) : ''
  erb :index, :locals =>  { :code_output => code_output,
                            :shift_by => params["shift_by"].to_i,
                            :plain_text => params["plain_text"] || nil
                          }
end



def caesar_cipher(unencoded='', shift_by = 1)
  encoded = unencoded.split('').collect do |character|
    # we're going to shift all letters and digits
    shift_by.times { character.next! } if character =~ /[a-zA-Z0-9]/
      # .next adds an index letter if we go past z, Z, 9 - this removes it
    character = character[-1]
    character
  end
  encoded.join('')
end
