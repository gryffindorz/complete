
require 'socket'
require 'faraday'
def generator()

  print "Jumlah yang mau di generate : "
  jumlah = gets.chomp.to_i
  i = 1
  while i < jumlah
    a = rand 1..255
    b = rand 1..255
    c = rand 1..255
    d = rand 1..255
    gabungan = "#{a}.#{b}.#{c}.#{d}"
    puts gabungan
    File.open("generator.txt", "a"){|f| f.write "#{gabungan}\n"}
    i += 1
  end
end

def zip()
  a = [18, 22, 33, nil, 5, 6]
  b = [1, 4, 1, 1, 88, 9]

  for i,j in a.zip(b)
    puts "#{i} : #{j}"
  end

end



def range()
  print "Input list IPS : "
  ips = gets.chomp
  range1 = (1..255).to_a
  range2 = (1..255).to_a
  File.foreach(ips).each do |lines|
    baris = lines.rstrip

    gokil = baris.split(".")
    buntut_1 = gokil[3]
    buntut_2 = gokil[2]
    for i in range1
      campur1 = "#{gokil[0]}.#{gokil[1]}.#{gokil[2]}.#{i}"
      puts campur1
      File.open("range.txt", "a"){|f| f.write "#{campur1}\n"}

    end
    for j in range2
      campur2 = "#{gokil[0]}.#{gokil[1]}.#{j}.#{gokil[3]}"
      puts campur2
      File.open("generator.txt", "a"){|f| f.write "#{campur2}\n"}
    end
    for zipi,zipi2 in range1.zip(range2)
      campur3 = "#{gokil[0]}.#{gokil[1]}.#{zipi}.#{zipi2}"
      puts campur3
      File.open("generator.txt", "a"){|f| f.write "#{campur3}\n"}

    end
  end

end

def checker()
  print "Input list IPS : "
  listips = gets.chomp
  File.foreach(listips).each do |lines|
    baris = lines.rstrip
    begin
      inireq = "http://#{baris}"
      conn = Faraday.new do |conn|
        conn.options.timeout = 20
      end
      requests = conn.get(inireq)
      if requests.status == 200
        puts "[ L I V E ] #{inireq}"
        File.open("checker_live.txt", "a"){|f| f.write "#{inireq}\n"}

      else
        inireq2 = "https://#{baris}"
        requests2 = conn.get(inireq2)

        if requests.status == 200
          puts "[ L I V E ] #{inireq2}"
          File.open("checker_live.txt", "a"){|f| f.write "#{inireq2}\n"}

        else
          puts "[ D I E ] #{inireq2}"
        end
      end
    rescue
      puts "[ D I E ] #{baris}"
    end

  end
end


if __FILE__ == $0
  system("cls")
  puts """
  ┌─┐┬─┐┬ ┬┌─┐┌─┐┬┌┐┌┌┬┐┌─┐┬─┐
  │ ┬├┬┘└┬┘├┤ ├┤ ││││ │││ │├┬┘
  └─┘┴└─ ┴ └  └  ┴┘└┘─┴┘└─┘┴└─
        kalls@Gryffindor

  [1] Checker IP
  [2] Range IP
  [3] Generator IP
  """

  print "Choose one : "
  nomor = gets.chomp.to_i
  if nomor == 1
    t1 = Thread.new{checker()}
    t1.join
  elsif nomor == 2
    t2 = Thread.new{range()}
    t2.join
  elsif nomor == 3
    t3 = Thread.new{generator()}
    t3.join
  else
    puts "Wrong number !"
  end
end