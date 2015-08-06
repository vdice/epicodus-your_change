class Fixnum
  define_method(:your_change) do
    remainder = self
    apology = ''

    denom = {'q' => {"denom"    => "quarter",
                     "count"    => 0,
                     "interval" => 25,
                     "avail"    => 2},

             'd' => {"denom"    => "dime",
                     "count"    => 0,
                     "interval" => 10,
                     "avail"    => 2},

             'n' => {"denom"    => "nickel",
                     "count"    => 0,
                     "interval" => 5,
                     "avail"    => 4},

             'p' => {"denom"    => "penny",
                     "count"    => 0,
                     "interval" => 1,
                     "avail"    => 1000}}

    until remainder.==(0)
      denom.each do |key, coin|
        until remainder.<(coin.fetch('interval'))
          if coin.fetch('avail').==(0)
            apology = apology.concat("#{coin.fetch('denom')}, ")
            break
          else
            count = coin.fetch('count')
            if count.==(1)
              coin.store('denom', coin.fetch('denom').concat('s'))
              coin.store('denom', (coin.fetch('denom')).sub('y','ie'))
            end

            coin.store('count', count.+(1))
            coin.store('avail', coin.fetch('avail').-(1))
            remainder = remainder.-(coin.fetch('interval'))
          end
        end
      end
    end

    result = []
    denom.each do |key, coin|
      count = coin.fetch('count')
      if count.>(0)
        result.push("#{count} #{coin.fetch('denom')}")
      end
    end

    final = result.join(", ")
    final = final.reverse()
    final = final.sub(',','dna ')

    if apology.length().>(0)
      apology = apology.strip!.reverse()
      apology = apology.sub(',', '')
      apology = apology.sub(',', 'dna ')
      apology = apology.reverse()
      apology = "Sorry! We are out of ".concat(apology).concat('. Your change is: ')
    end

    final = apology.concat(final.reverse())
  end
end
