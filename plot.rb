require 'nyaplot'

  def plot_luminosidad

    plot = Nyaplot::Plot.new
    
    x1 = Array.new
    x2 = Array.new
    x3 = Array.new
    x4 = Array.new
    y1 = Array.new
    y2 = Array.new
    y3 = Array.new
    y4 = Array.new

    21.times  do |i|

      x1<< i
      y1 << fuctionL(i,0.0,20.0)

      # print y
    end
    100.times  do |i|

      x2<< i
      y2 << trapezoidal(i,5.0,20.0,50.0,100.0)

      # print y
    end
    500.times  do |i|

      x3<< i
      y3 << triangular(i,80.0,300.0,500.0)

      # print y
    end
    1000.times  do |i|

      x4<< i
      y4 << gamma(i,400.0,700.0)

      # print y
    end



    # df = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
    # df1 = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
    #
    # sc = plot.add_with_df(df, :scatter, :x, :y)
    # sc1 = plot.add_with_df(df1, :scatter, :x, :y)

    cs1 = plot.add(:scatter , x1 , y1)
    # #
    cs2 = plot.add(:scatter , x2,y2)
    cs2.color(Nyaplot::Colors.qual)
    cs3 = plot.add(:scatter ,   x3 , y3  )
    cs4 = plot.add(:scatter ,  x4 , y4  )
    cs4.color(Nyaplot::Colors.binary)
    plot.export_html("luminosidad.html")
  end

  def plot_tamano

    plot = Nyaplot::Plot.new

    x1 = Array.new
    x2 = Array.new
    x3 = Array.new
    y1 = Array.new
    y2 = Array.new
    y3 = Array.new

    16.times  do |i|

      x1<< i
      y1 << fuctionL(i,0.0,15.0)

      # print y
    end
    36.times  do |i|

      x2<< i
      y2 << trapezoidal(i,10.0,20.0,25.0,35.0)

      # print y
    end
    41.times  do |i|

      x3<< i
      y3 << gamma(i,30,40.0)

      # print y
    end



    # df = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
    # df1 = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
    #
    # sc = plot.add_with_df(df, :scatter, :x, :y)
    # sc1 = plot.add_with_df(df1, :scatter, :x, :y)

    cs1 = plot.add(:scatter , x1 , y1)
    # #
    cs2 = plot.add(:scatter , x2,y2)
    cs2.color(Nyaplot::Colors.qual)
    cs3 = plot.add(:scatter ,   x3 , y3  )

    plot.export_html("tamano.html")
  end

   def plot_potencia (p = NIL , m = NIL , g = NIL)

    if p.nil?
      p = 1.0
      m = 1.0
      g = 1.0
    end

    plot = Nyaplot::Plot.new

    x = Array.new
    y = Array.new
    x1 = Array.new
    x2 = Array.new
    x3 = Array.new
    y1 = Array.new
    y2 = Array.new
    y3 = Array.new




    101.times  do |i|

      x1<< i
      y1 << [fuctionL(i,0.0,30.0),p].min

      # print y
    end
    101.times  do |i|

      x2<< i
      y2 << [trapezoidal(i,25.0,40.0,60.0,75.0),m].min

      # print y
    end
    101.times  do |i|

      x3<< i
      y3 << [gamma(i,60,100.0),g].min

      # print y
    end



    # df = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
    # df1 = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
    #
    # sc = plot.add_with_df(df, :scatter, :x, :y)
    # sc1 = plot.add_with_df(df1, :scatter, :x, :y)
    p y1[0]
    p y1[1]
    cs1 = plot.add(:scatter , x1 , y1)
    # #
    cs2 = plot.add(:scatter , x2,y2)
    cs2.color(Nyaplot::Colors.qual)
    cs3 = plot.add(:scatter ,   x3 , y3  )

    plot.export_html("potencia.html")

    101.times do |i|
      x << i
      #
      # p y1[i]
      # p y2[i]
      # p y3[i]
      y << [y1[i] , y2[i] ,y3[i]].max

    end
    plot1 = Nyaplot::Plot.new
    plot1.add(:scatter , x,y )
    plot1.export_html("potencia_truncada.html")
     [x , y]
  end

def plot_larsen (p = NIL , m = NIL , g = NIL)

  if p.nil?
    p = 1.0
    m = 1.0
    g = 1.0
  end
  # print "aqui esta el tufo"
  # p p
  # p m
  # p g

  plot = Nyaplot::Plot.new

  x = Array.new
  y = Array.new
  x1 = Array.new
  x2 = Array.new
  x3 = Array.new
  y1 = Array.new
  y2 = Array.new
  y3 = Array.new




  101.times  do |i|

    x1<< i
    # p (fuctionL(i,0.0,30.0) * p)
    y1 << (fuctionL(i,0.0,30.0) * p)

    # print y
  end
  101.times  do |i|

    x2<< i
    # p (trapezoidal(i,25.0,40.0,60.0,75.0) * m)
    y2 << (trapezoidal(i,25.0,40.0,60.0,75.0) * m)

    # print y
  end
  101.times  do |i|

    x3<< i
    # p (gamma(i,60,100.0) * g)
    y3 << (gamma(i,60,100.0) * g)

    # print y
  end



  # df = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
  # df1 = Nyaplot::DataFrame.new({x: x,y: y,name: samples, home: home})
  #
  # sc = plot.add_with_df(df, :scatter, :x, :y)
  # sc1 = plot.add_with_df(df1, :scatter, :x, :y)

  cs1 = plot.add(:scatter , x1 , y1)
  # #
  cs2 = plot.add(:scatter , x2,y2)
  cs2.color(Nyaplot::Colors.qual)
  cs3 = plot.add(:scatter ,   x3 , y3  )

  plot.export_html("potencia_larsen.html")

  101.times do |i|
    x << i
    #
    # p y1[i]
    # p y2[i]
    # p y3[i]
    y << [y1[i] , y2[i] ,y3[i]].max

  end
  plot1 = Nyaplot::Plot.new
  plot1.add(:scatter , x,y )
  plot1.export_html("potencia_escalada.html")
  [x , y]
end



  def gamma (x , a , m)
    o1 = x - a
    o2 = m - a
    [[o1/o2,1].min,0].max

  end

  def fuctionL(x, a, m)
    1 - gamma(x, a,m)

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






# plot_luminosidad
# plot_tamano
plot_potencia