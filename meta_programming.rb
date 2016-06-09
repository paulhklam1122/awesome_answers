class MyClass
  [:a, :b, :c, :d, :e, :f].each do |letter|
    define_method(letter) do
      puts "I'm inside method #{letter}"
    end
  end

  def method_missing(*args)
    puts "I'm inside method missing #{args}"
  end
end

# eval(my_code) runs code in a string as if it was code

# send
# method_name = :capitalize
# a.send(method_name)
