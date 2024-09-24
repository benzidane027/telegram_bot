BEGIN {
  puts '************ begin ************'
}
at_exit do
  puts '************* end *************'
end
