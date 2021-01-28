def hex_to_rgb(hex_code)
	hex_code = hex_code.to_s
	hex_code.delete! '#'

	if !hex_code.delete("0123456789abcdefABCDEF").empty?
		raise "Cannot convert '##{hex_code}' to rgb; hex values must be between 00 and FF"
	end

	if hex_code.length == 6
		hex_array = hex_code.chars.each_slice(2).map(&:join)
	else
		raise "Cannot convert '##{hex_code}' to rgb; expected a string containing a hexidecimal colour code with 6 characters (eg #010203)"
	end

	rgb_map = { r: hex_array[0].hex, g: hex_array[1].hex, b: hex_array[2].hex }
	return rgb_map
end

def rgb_to_hex(rgb_map)
	hex_code = "#"

	rgb_map.each do |k, v|
		if !k.to_s.downcase.delete("rgb").empty? || v > 255 || v < 0
			raise "#{rgb_map} is not a valid hash of rgb values in 256 bit colour space; expected a hash with keys r g b and values between 0 and 255"
		end

		this_hex = v.to_s(16)
		if this_hex.length == 1
			this_hex = "0#{this_hex}"
		end
		hex_code += this_hex
	end

	return hex_code
end

class Colour
	def initialize (input)
		@hex_code = input[:hex_code].to_s
		@rgb_map = input[:rgb_map]
	end

	def to_hex_code
		if @hex_code == ''
			@hex_code = rgb_to_hex(@rgb_map)
		end
		return @hex_code
	end

	def to_rgb_map
		if @rgb_map == nil
			@rgb_map = hex_to_rgb(@hex_code)
		end
		return @rgb_map
	end
end
