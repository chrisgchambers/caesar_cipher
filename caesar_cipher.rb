require 'sinatra'

get '/' do
  plain_text = params["plain_text"]
  shift_by = params["shift_by"].to_i
  code_output = caesar_cipher(plain_text, shift_by)
  erb :index, :locals => {:code_output => code_output,
                          :shift_by => shift_by,
                          :plain_text => plain_text
                        }
end


def caesar_cipher(unencoded, shift_by = 1)
  encoded = unencoded.split('').collect do |character|
    # we're going to shift all letters and digits
    shift_by.times { character.next! } if character =~ /[a-zA-Z0-9]/
      # .next adds an index letter if we go past z, Z, 9 - this removes it
    character = character[-1]
    character
  end
  encoded.join('')
end
