require 'nyaplot'
require './plot.rb'

class Simulate

  def simulate

    tam = 15
    lumin = 401
    @luminosidad = Luminosidad.new(lumin)
    @tamano = Tamano.new(tam)
    @potencia = Array.new
    fuzzyLuminosidad
    fuzzyTamano
    print(@luminosidad.valor)
    print("/")
    print(@tamano.valor)
    print(@luminosidad.dict)
    print(@tamano.dict)

    p = []
    m = []
    g = []




  #   Llamando a las reglas

    p << regla1
    p << regla2
    p << regla5

    m << regla3
    m << regla6
    m << regla8

    g << regla4
    g << regla7

    mandami_agregation p, m, g



  end





  class Luminosidad


    attr_accessor :valor
    attr_accessor :dict

    def initialize (entrada)

      @valor = entrada
      @dict = Hash.new

    end

  end

  class Tamano


    attr_accessor :valor
    attr_accessor :dict

    def initialize (entrada)

      @valor = entrada
      @dict = Hash.new

    end
  end



  def triangular ( x , a , b, c)

    o1 = x - a
    o2 = b - a
    o3 = c - x
    o4 = c - b

    [ [o1/o2, o3/o4].min ,0].max

  end

  def trapezoidal ( x , a, b, c, d)

    o1 = x - a
    o2 = b - a
    o3 = d - x
    o4 = d - c

    [[o1/o2,[1,o3/o4].min].min,0].max


  end

  def gamma (x , a , m)
    o1 = x - a
    o2 = m - a
    [[o1/o2,1].min,0].max

  end

  def fuctionL(x, a, m)
    1 - gamma(x, a,m)

  end

  def myand (x , y)

    if x.nil?
      return y
    end
    if y.nil?
      return x
    end
    [x,y].min
  end

  def myor (x , y)
    if x.nil?
      return y
    end
    if y.nil?
      return x
    end
    [x,y].max
  end

  def fuzzyLuminosidad

    x = @luminosidad.valor
    oscuro = fuctionL(x,0.0,20.0)
    if oscuro > 0
       @luminosidad.dict["oscuro"] = oscuro
    end
    tenue = trapezoidal(x,5.0,20.0,50.0,100.0)
    if tenue > 0
       @luminosidad.dict["tenue"] = tenue
    end
    claro = triangular(x,80.0,300.0,500.0)
    if claro > 0
      @luminosidad.dict["claro"] = claro
    end
    intenso = gamma(x,400.0,700.0)
    if intenso > 0
      @luminosidad.dict["intenso"] = intenso
    end
  end

  def fuzzyTamano
    x = @tamano.valor
    pequeno = fuctionL(x,0.0,15.0)
    if pequeno > 0
      @tamano.dict["pequeno"] = pequeno
    end
    mediano = trapezoidal(x,10.0,20.0,25.0,35.0)
    if mediano  > 0
      @tamano.dict["mediano"] = mediano
    end
    grande = gamma(x,30,40.0)
    if grande > 0
      @tamano.dict["grande"] = grande
    end

  end

  def fuzzyPotencia(x)

    baja = fuctionL(x,0.0,15.0)
    media = trapezoidal(x,10.0,20.0,25.0,35.0)
    alta = gamma(x,30,40.0)
    if baja > 0
      @potencia << "baja"

    elsif media > 0
      @potencia << "media"

    elsif alta > 0
      @potencia << "alta"
    end

  end

  def regla1  #baja
    if @luminosidad.dict.include? "intenso"
      @luminosidad.dict["intenso"]


    else
      0
    end
  end

  def regla2   #baja

    if (@luminosidad.dict.include? ("claro")) && ( (@tamano.dict.include? ("pequeno")) || (@tamano.dict.include? ("mediano") ))
    # print "regla2"
    #   p @tamano.dict["pequeno"]
    #   p @tamano.dict["mediano"]
      myand( @luminosidad.dict["claro"] , myor( @tamano.dict["pequeno"], @tamano.dict["mediano"] ))

    else
      0
    end

  end

  def regla3  #media

    if @luminosidad.dict.include?("oscuro") && (( @tamano.dict.include?( "pequeno")) || (@tamano.dict.include? ("mediano") ))
      myand( @luminosidad.dict["oscuro"] , myor( @tamano.dict["pequeno"], @tamano.dict["mediano"] ))

    else
      0
    end
  end

  def regla4 #alta
    if @luminosidad.dict.include? ("oscuro") && @tamano.dict.include?("grande")
    myand( @luminosidad.dict["oscuro"], @tamano.dict["grande"])
    else
       0
    end

  end

  def regla5 #baja
    if @luminosidad.dict.include? ("tenue") && @tamano.dict.include?( "pequeno")
    myand( @luminosidad.dict["tenue"], @tamano.dict["pequeno"])
    else
      0
    end
  end

  def regla6 #media
    if @luminosidad.dict.include?("tenue") && @tamano.dict.include?("mediano")
    myand( @luminosidad.dict["tenue"], @tamano.dict["mediano"])
    else
      0
    end
  end

  def regla7 #alta
    if @luminosidad.dict.include? ("tenue") && @tamano.dict.include?("grande")
    myand( @luminosidad.dict["tenue"], @tamano.dict["grande"])
    else
      0
    end
  end

  def regla8 #media
    if @luminosidad.dict.include? ("claro") && @tamano.dict.include?("grande")
    myand( @luminosidad.dict["claro"], @tamano.dict["grande"])
    else
      0
    end
  end


  def mandami_agregation(p, m, g)

    # p p
    # p m
    # p g
    @peque = mandami p
    @medio = mandami m
    @grande = mandami g

    # p @medio
    plot = plot_potencia @peque , @medio , @grande

    desfuzzy_centroide( plot.first, plot.last)

    # print(plot)

  end

  def larsen_agregation (p , m, g)

    @peque = mandami p
    @medio = mandami m
    @grande = mandami g

    plot = plot_larsen @peque , @medio , @grande

    desfuzzy_centroide( plot.first, plot.last)

  end

  def mandami( x)

    c1 = x.first
    x.each do |i|
      c1 = myor(c1,i)
    end
    c1
  end



  def desfuzzy_centroide  (x, y)

    numerador = 0.0
    denominador = 0.0
    # (a..b).step(10).each do |i|
    # p (y)
    # (a..b).step((b-a)/1000).each do |i|
    x.each_with_index do |i,index|
      numerador += i * y[index]
      denominador += y[index]

    end
    if denominador <= 0
      0
    else
      numerador/denominador
    end

  end

  def middle (i, l)
    left = l[0...i].sum
    right = l.sum - left

    if left == right or i+1 >= l.length or i-1 < 0
      i
    elsif left > right
      if l[0...i-1].sum < l[i...l.length].sum then
        return i

      end
      middle i-1 , l
    else
      if l[0...i+1].sum > l[i+2...l.length].sum then
        return i
      end
      middle i+1 , l
    end
  end

  def desfuzzy_biseccion( x , y)
    i = middle y.length/2 , y
    [x[i], y[i]]

  end

  def middle_max (x , y)
    max_l = y.max
    values = []

    for i in 0..y.length
      if y[i] == max_l
        values.append x[i]
      end
    end
    values.sum/values.length
  end

  def smallest_max (x,y)

    x[y.index(y.max)]
  end

  def largest_max(x , y)
    y.reverse!
    x.reverse!
    smallest_max x , y
  end

end

a = Simulate.new
a.simulate()